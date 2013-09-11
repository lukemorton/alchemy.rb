require 'spec_helper'
require_relative '../lib/app/interaction/controller/login_controller'

def login_controller()
  App::Interaction::Controller::Login.new
end

describe App::Interaction::Controller::Login do
  describe :view do
    it 'should show login form if not logged in' do
      response = login_controller.view(request)
      expect(response[:body][:template]).to eq(:login)
    end

    it 'should redirect to / if already logged in' do
      response = login_controller.view(logged_in_request)
      expect(response[:redirect]).to eq('/')
    end
  end

  describe :action do
    it 'should on successful login set session and redirect to /' do
      response = login_controller.action(request({
        :post => {:email => 'lukemorton.dev@gmail.com'},
      }))

      expect(response[:session][:user_id]).to eq(0)
    end

    it 'should redirect to / if already logged in' do
      response = login_controller.action(logged_in_request)
      expect(response[:redirect]).to eq('/')
    end

    it 'should show view if login unsuccessful' do
      response = login_controller.action(request({
        :post => {:email => 'unknown@gmail.com'},
      }))

      expect(response[:body][:template]).to eq(:login)
    end
  end
end
