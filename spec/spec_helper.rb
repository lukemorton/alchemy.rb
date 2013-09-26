require 'coveralls'
Coveralls.wear!

require_relative '../lib/app/data/mapper/users'

require_relative '../lib/app/data/mapper/users'
require_relative '../lib/app/data/action/login'
require_relative '../lib/app/data/model/welcome'

require_relative '../lib/app/view/template_engine/hash'
require_relative '../lib/app/view/model/login'
require_relative '../lib/app/view/model/welcome'

def request(request = {})
  request[:data] = {
    :mappers => {
      :users => App::Data::Mapper::Users.new,
    },

    :model => {
      :welcome => App::Data::Model::Welcome.new,
    },

    :action => {
      :login => App::Data::Action::Login.new,
    }
  }

  request[:view] = {
    :template_engine => {
      :mustache => App::View::TemplateEngine::Hash.new,
    },

    :model => {
      :login => App::View::Model::Login.new,
      :welcome => App::View::Model::Welcome.new,
    },
  }
  
  request[:session] ||= {}
  request[:post] ||= {}
  request[:query] ||= {}

  return request
end

def logged_in_request()
  request({:session => {:user_id => 0}})
end
