require 'spec_helper'
require_relative '../lib/app/interaction/controller/welcome'

def welcome_controller()
  App::Interaction::Controller::Welcome.new
end

describe App::Interaction::Controller::Welcome do
  describe :view do
    it 'should show welcome view if logged in' do
      response = welcome_controller.view(logged_in_request)
      expect(response[:body][:template]).to eq(:welcome)
    end

    it 'should redirect to /login if not logged in' do
      response = welcome_controller.view(request)
      expect(response[:redirect]).to eq('/login')
    end
  end
end
