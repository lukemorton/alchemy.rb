require_relative '../../data/model/welcome_data_model'
require_relative '../../view/model/welcome_view_model'

module App
  module Interaction
    module Controller
      class WelcomeController
        def view(request)
          if response = redirect_if_not_logged_in(request)
            return response 
          end

          data_model =
            Data::Model::WelcomeDataModel.as_hash({
              :mappers => request[:mappers],
              :user_id => request[:session][:user_id],
            })

          view_model = View::Model::WelcomeViewModel.as_hash(data_model)
          {:body => request[:view].render(:welcome, view_model)}
        end

        private

        def redirect_if_not_logged_in(request)
          unless request[:session].has_key?(:user_id)
            {:redirect => '/login'}
          end
        end
      end
    end
  end
end
