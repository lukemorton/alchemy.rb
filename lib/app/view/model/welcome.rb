module App
  module View
    module Model
      class Welcome
        def to_hash(data)
          {
            :user_name => data[:user][:name],
            :logout_url => logout_url,
          }
        end

        private

        def logout_url()
          '/logout'
        end
      end
    end
  end
end

