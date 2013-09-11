require_relative '../../data/action/login_data_action'
require_relative '../../view/model/login_view_model'

module App
  module Interaction
    module Controller
      class LoginController
        def view(request)
          if response = redirect_if_logged_in(request)
            return response
          end

          view_model =
            View::Model::LoginViewModel.as_hash(
              login_data_model(request))
          
          {:body => request[:view].render(:login, view_model)}
        end

        def action(request)
          if response = redirect_if_logged_in(request)
            return response
          end

          login_result =
            Data::Action::LoginDataAction.exec({
              :mappers => request[:mappers],
              :email => request[:post][:email],
            })

          if login_result.has_key?(:user_id)
            login_and_redirect(login_result[:user_id])
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
      end
    end
  end
end
