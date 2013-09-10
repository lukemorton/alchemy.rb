module App
  module Data
    module Action
      class LoginDataAction
        def self.exec(data)
          self.new.exec(data)
        end

        def exec(data)
          if user_id = user_id_from_email(data)
            {:user_id => user_id}
          else
            {:errors => {:email => 'Not found'}}
          end
        end

        private

        def user_id_from_email(data)
          if user = data[:mappers][:users].find_by_email(data[:email])
            user[:id]
          end
        end
      end
    end
  end
end
