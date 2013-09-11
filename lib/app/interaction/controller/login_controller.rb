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

          if request.has_key?(:login_result)
            data_model = request[:login_result]
          else
            data_model = {}
          end

          view_model = View::Model::LoginViewModel.as_hash(data_model)
          
          {:body => request[:view].render(:login, view_model)}
        end

        def action(request)
          if response = redirect_if_logged_in(request)
            return response
          end

          login_result = Data::Action::LoginDataAction.exec({
            :mappers => request[:mappers],
            :email => request[:post][:email],
          })

          if login_result.has_key?(:user_id)
            {
              :session => {:user_id => login_result[:user_id]},
              :redirect => '/',
            }
          else
            request[:login_result] = {
              :values => {:email => request[:post][:email]},
              :errors => request[:errors],
            }

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
      end
    end
  end
end
