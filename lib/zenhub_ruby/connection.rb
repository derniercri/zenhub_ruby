require 'faraday'
require 'faraday_middleware'

module ZenhubRuby
  module Connection
    END_POINT = 'https://api.zenhub.io'.freeze

    def get(path)
      api_connection.get(path)
    end

    def post(path, params)
      api_connection.post(path) do |req|

        req.body = params
      end
    end

    def put(path, payload)
      api_connection.put(path, payload)
    end

    def patch(path, params)
      api_connection.patch(path) do |req|
        puts params.inspect

        req.body = params
      end
    end

    private

    def api_connection
      Faraday.new(url: END_POINT) do |conn|
        conn.request :json

        conn.response :json, content_type: /\bjson$/
        conn.response :logger

        conn.adapter Faraday.default_adapter
        conn.headers = {
          accept: 'application/json',
          user_agent: "ZenhubRuby v#{VERSION}",
          x_authentication_token: zenhub_access_token
        }
      end
    end
  end
end
