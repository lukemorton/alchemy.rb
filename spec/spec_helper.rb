require_relative '../lib/app/data/mapper/users_data_mapper'
require_relative '../lib/app/view/template_engine/hash_template_engine'

def request(request = {})
  request[:mappers] = {
    :users => App::Data::Mapper::UsersDataMapper.new,
  }

  request[:view] = App::View::TemplateEngine::HashTemplateEngine.new
  
  request[:session] ||= {}
  request[:post] ||= {}
  request[:query] ||= {}

  return request
end

def logged_in_request()
  request({
    :session => {:user_id => 0},
  })
end
