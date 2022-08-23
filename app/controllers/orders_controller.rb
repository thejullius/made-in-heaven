class OrdersController < ApplicationController
  before_action :authenticate!
  before_action :set_buying_group, only: %i[new create]

  def new
    @order = @buying_group.orders.build

    set_order_items
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
            .permit(:buying_group_id, :name, :email, :phone,
                    :zip_code, :state, :city, :address, :address_number,
                    :address_complement, :observation, :document,
                    order_items_attributes: %i[id batch_id order_id quantity])
    end
end
