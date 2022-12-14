class OrdersController < ApplicationController
  before_action :authenticate!
  before_action :set_buying_group, only: %i[new create]

  def new
    @order = @buying_group.orders.build

    set_order_items
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def create
    @order = @buying_group.orders.build(order_params)

    if @order.save
      redirect_to @buying_group
    else
      set_order_items
      render :new, status: :unprocessable_entity
    end
  end

  def shipment_options
    @packages = params[:items].map do |item|
      batch = Batch.find item[:id]

      {
        id: batch.id,
        width: batch.width,
        height: batch.height,
        length: batch.length,
        weight: batch.weight,
        insurance_value: 50,
        quantity: item[:quantity]
      }
    end

    response = MelhorEnvio::CalculateShippingService.call(params[:zip_code], @packages)

    @options = response.map do |item|
      service = I18n.t(Order.shipment_services.invert[item['id']], scope: 'enums.order.shipment_service')
      const = "R$ #{item['price']}"
      delivery_time = "#{item['delivery_time']} dias uteis"
      custom_id = "#{item['id']}|#{item['price']}"

      ["🚚 #{service} 💰 #{const} 🕒 #{delivery_time}", "#{custom_id}"]
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

    def set_buying_group
      @buying_group = BuyingGroup.find(params[:buying_group_id])
    end

    def set_order_items
      @order.order_items = @buying_group.batches.map do |batch|
        OrderItem.new(batch: batch)
      end
    end

    def order_params
      params.require(:order)
            .permit(:buying_group_id, :name, :email, :phone, :shipment_service,
                    :zip_code, :state, :city, :address, :address_number,
                    :address_complement, :observation, :document, :shipment_cost,
                    order_items_attributes: %i[id batch_id order_id quantity])
            .tap do |param|
              shipment_service, shipment_cost = param[:shipment_service].split('|')

              param[:shipment_service] = shipment_service.to_i
              param[:shipment_cost] = shipment_cost
            end

    end
end
