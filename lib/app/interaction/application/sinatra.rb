require 'sinatra/base'

module App
  module Interaction
    module Application
      class Sinatra < Sinatra::Base
        enable(:sessions)

        private

        def symbolise_hash_keys(hash)
          hash.each_with_object({}) do |(k, v), h|
            key_sym = k.to_sym rescue k
            h[key_sym] = v
          end
        end

        def stringify_hash_keys(hash)
          hash.each_with_object({}) do |(k,v), h|
            h[k.to_s] = v
          end
        end

        def request_hash()
          {
            :params => params,
            :query => symbolise_hash_keys(request.GET),
            :post => symbolise_hash_keys(request.POST),
            :cookies => symbolise_hash_keys(request.cookies),
            :session => symbolise_hash_keys(session),
          }
        end

        def normalise_response_headers(response)
          if response.has_key?(:headers)
            response[:headers] = stringify_hash_keys(response[:headers])
          else
            response[:headers] = {}
          end
        end

        def add_redirect_response(response)
          if response.has_key?(:redirect)
            unless response[:headers].has_key?(:location)
              response[:headers]['location'] = response[:redirect]
            end

            unless response.has_key?(:status)
              response[:status] = 302
            end
          end
        end

        def set_default_response_status(response)
          unless response.has_key?(:status)
            response[:status] = 200
          end
        end

        def set_default_response_body(response)
          unless response.has_key?(:body)
            response[:body] = ''
          end
        end

        def normalise_response(response)
          normalise_response_headers(response)
          add_redirect_response(response)
          set_default_response_status(response)
          set_default_response_body(response)
        end

        def save_session(response)
          if response.has_key?(:session)
            response[:session].each do |k, v|
              session[k] = v
            end
          end
        end

        def control(controller_name, method)
          controller = dependencies[:interaction][:controller][controller_name]
          response = controller.send(method, request_hash)
            
          normalise_response(response)
          save_session(response)

          [response[:status], response[:headers], response[:body]]
        end

        def view(controller)
          control(controller, :view)
        end

        def action(controller)
          control(controller, :action)
        end
      end
    end
  end
end
