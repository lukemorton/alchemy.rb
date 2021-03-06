module App
  module Interaction
    module Controller
      class Login
        def view(request)
          if response = redirect_if_logged_in(request)
            return response
          end

          view_model =
            request[:view][:model][:login].to_hash(
              login_data_model(request))
          
          {
            :body =>
              request[:view][:template_engine][:mustache].render(
                :login,
                view_model)
          }
        end

        def action(request)
          if response = redirect_if_logged_in(request)
            return response
          end

          login_result =
            request[:data][:action][:login].exec({
              :mappers => request[:data][:mappers],
              :email => request[:post][:email],
            })

          if response = login_and_redirect_if_successful(login_result)
            response
          else
            request[:login_result] = login_result
            view(request)
          end
        end

        private

        def is_logged_in(request)
          request[:session].has_key?(:user_id)
        end

        def redirect_if_logged_in(request)
          if is_logged_in(request)
            {:redirect => '/'}
          end
        end

        def login_data_model(request)
          if request.has_key?(:login_result)
            request[:login_result]
          else
            {}
          end
        end

        def login_and_redirect(user_id)
          {
            :session => {:user_id => user_id},
            :redirect => '/',
          }
        end

        def login_and_redirect_if_successful(login_result)
          if login_result.has_key?(:user_id)
            login_and_redirect(login_result[:user_id])
          end
        end
      end
    end
  end
end
