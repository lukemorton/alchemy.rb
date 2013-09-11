require 'bundler'

APP_ROOT = File.dirname(__FILE__)

require APP_ROOT + '/lib/app/interaction/application/sinatra'
require APP_ROOT + '/lib/app/interaction/controller/welcome'
require APP_ROOT + '/lib/app/interaction/controller/login'
require APP_ROOT + '/lib/app/interaction/controller/logout'

require APP_ROOT + '/lib/app/data/mapper/users'

require APP_ROOT + '/lib/app/view/template_engine/mustache'

class Application < App::Interaction::Application::Sinatra
  
  # Public asset folder
  # 
  set(:public_folder, APP_ROOT + '/static')

  # Session secret so that shotgun server saves sessions
  # 
  # Since shotgun creates a new server instance each page load
  # it will create a random session secret each page load. By
  # defining the secret ourselves this will be used by shotgun
  # and therefore circumvent the problem.
  # 
  set(:session_secret, "something")

  # Initialise dependencies
  # 
  def initialize()
    @controllers = {
      :welcome => App::Interaction::Controller::Welcome.new,
      :login => App::Interaction::Controller::Login.new,
      :logout => App::Interaction::Controller::Logout.new,
    }

    @mappers = {
      :users => App::Data::Mapper::Users.new,
    }

    @view =
      App::View::TemplateEngine::Mustache.new({
        :template_path => APP_ROOT + '/templates'
      })

    super
  end

  # Inject some of our own objects into request hash
  # 
  def request_hash()
    hash = super

    hash[:view] = @view
    hash[:mappers] = @mappers

    hash
  end

  # Application Routing
  # 
  get('/') { view(:welcome) }

  get('/login') { view(:login) }

  post('/login') { action(:login) }
  
  get('/logout') { action(:logout) }
end

run Application
