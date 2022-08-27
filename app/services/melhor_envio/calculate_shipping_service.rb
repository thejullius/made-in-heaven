module MelhorEnvio
  class CalculateShippingService < ::ApplicationService
    def initialize(zip_code, products)
      @zip_code, @products = zip_code, products
    end

    def call
      MelhorEnvio::Shipment.calculate(data)
    end

    private

    def data
      {
        from: {
          # todo ajust postal_code
          postal_code: '01153000'
        },
        to: {
          postal_code: @zip_code
        },
        products: @products,
        services: Order.shipment_services.values.join(',')
      }
    end
  end
end
