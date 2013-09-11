module App
  module Interaction
    module Controller
      class Logout
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
