module App
  module View
    module Model
      class Welcome
        def self.as_hash(data)
          welcome_view_model = self.new(data)
          {
            :user_name => welcome_view_model.user_name,
            :logout_url => '/logout'
          }
        end

        def initialize(data)
          @user = data[:user]
        end

        def user_name()
          @user[:name]
        end

        def logout_url()
          '/logout'
        end
      end
    end
  end
end

