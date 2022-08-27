# frozen_string_literal: true

module MelhorEnvio
  class Shipment < Base
    class << self
      def calculate(body)
        post '/api/v2/me/shipment/calculate', body: body.to_json
      end
    end
  end
end
