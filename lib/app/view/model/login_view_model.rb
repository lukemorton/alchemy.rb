module App
  module View
    module Model
      class LoginViewModel
        def self.as_hash(data)
          login_view_model = self.new(data)
          {:email => login_view_model.email}
        end

        def initialize(data)
          if data.has_key?(:values)
            @values = data[:values]
          else
            @values = {:email => nil}
          end

          if data.has_key?(:errors)
            @errors = data[:errors]
          else
            @errors = {:email => nil}
          end
        end

        def email()
          {
            :value => value(:email),
            :error => error(:email),
          }
        end

        private

        def value(key)
          if @value and @value.has_key?(key)
            return @value[key]
          end
        end

        def error(key)
          if @errors and @errors.has_key?(key)
            return @errors[key]
          end
        end
      end
    end
  end
end
