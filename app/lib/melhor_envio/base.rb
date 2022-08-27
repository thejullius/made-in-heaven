# frozen_string_literal: true

module MelhorEnvio
  class Base
    include HTTParty
    base_uri Rails.application.credentials.melhor_envio_uri
    headers 'Accept': 'application/json'
    headers 'Content-Type': 'application/json'
    headers 'User-Agent': 'Aplicação goncalves.juliof@gmail.com'
    headers 'Authorization': "Bearer #{Rails.application.credentials.melhor_envio_token}"

  protected
    (class << Base; self end).class_eval do
      %i[get post put delete].each do |method|
        define_method(method) do |endpoint, options = {}|
          handle_response super(endpoint, options)
        end
      end
    end

    def self.handle_response(response)
      #todo ajust raise
      raise ResponseError, "#{response.dig('code')}: #{response.dig('description')}" if response.code >= 400

      response.parsed_response.select do |option|
        option['error'].nil?
      end
    end
  end
end
