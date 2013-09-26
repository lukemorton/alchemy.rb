module App
  module Data
    module Model
      class Welcome
        def as_hash(data)
          {:user => data[:mappers][:users].find_by_id(data[:user_id])}
        end
      end
    end
  end
end
