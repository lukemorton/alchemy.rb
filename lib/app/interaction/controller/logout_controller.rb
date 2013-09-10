module App
  module Interaction
    module Controller
      class LogoutController
        def action(request)
          {
            :session => {:user_id => nil},
            :redirect => '/login',
          }
        end
      end
    end
  end
end
