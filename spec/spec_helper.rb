require 'coveralls'
Coveralls.wear!

require_relative '../lib/app/data/mapper/users'
require_relative '../lib/app/view/template_engine/hash'

def request(request = {})
  request[:mappers] = {
    :users => App::Data::Mapper::Users.new,
  }

  request[:view] = App::View::TemplateEngine::Hash.new
  
  request[:session] ||= {}
  request[:post] ||= {}
  request[:query] ||= {}

  return request
end

def logged_in_request()
  request({:session => {:user_id => 0}})
end
