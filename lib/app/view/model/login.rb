module App
  module View
    module Model
      class Login
        def as_hash(data)
          {
            :email => email(data),
          }
        end

        private

        def email(data)
          {
            :value => data.fetch(:values, {}).fetch(:email, nil),
            :error => data.fetch(:errors, {}).fetch(:email, nil),
          }
        end
      end
    end
  end
end
