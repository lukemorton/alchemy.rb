module App
  module Interaction
    module Controller
      class Welcome
        def view(request)
          if response = redirect_if_not_logged_in(request)
            return response 
          end

          data_model =
            request[:data][:model][:welcome].to_hash({
              :mappers => request[:data][:mappers],
              :user_id => request[:session][:user_id],
            })

          view_model = request[:view][:model][:welcome].to_hash(data_model)

          {
            :body =>
              request[:view][:template_engine][:mustache].render(
                :welcome,
                view_model)
          }
        end

        private

        def is_logged_in(request)
          request[:session].has_key?(:user_id)
        end

        def redirect_if_not_logged_in(request)
          unless is_logged_in(request)
            {:redirect => '/login'}
          end
        end
      end
    end
  end
end
