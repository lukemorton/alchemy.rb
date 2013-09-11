module App
  module Data
    module Mapper
      class Users
        def initialize()
          @users = [
            {
              :id    => 0,
              :name  => 'Luke',
              :email => 'lukemorton.dev@gmail.com',
            }
          ]
        end

        def find_by_id(user_id)
          @users[user_id]
        end

        def find_by_email(email)
          matched_user = nil

          @users.each do |user|
            matched_user = user if user[:email] == email
          end

          matched_user
        end
      end
    end
  end
end
