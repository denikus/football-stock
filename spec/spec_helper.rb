require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # for Devise
  require 'rails/application'
  Spork.trap_method(Rails::Application, :reload_routes!)

  # Simplecov
  #require 'simplecov'
  #SimpleCov.start 'rails'
  unless ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
  end

  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  # capybara
  require 'capybara/rspec'
  require 'capybara/rails'
  require 'capybara/poltergeist'
  require 'capybara_helper'

  Capybara.javascript_driver = :poltergeist
  #Capybara.default_host = 'test.voyages.fr'
  #Capybara.app_host = 'test.voyages.fr'

  #Capybara.register_driver :poltergeist do |app|
    #options = {:inspector => true}
    #Capybara::Poltergeist::Driver.new(app, options)
  #end
  #Capybara.default_wait_time = 30

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false


    # Devise
    #Enable
    #config.include Devise::TestHelpers, :type => :controller

    # Factory girl
    #config.include FactoryGirl::Syntax::Methods

    config.before :suite do
      require Rails.root.join('db','seeds')
    end
    #TODO enable
    #require 'controller_test_helper'
  end

end

Spork.each_run do
  # Simplecov
  if ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
  end

  require 'factory_girl_rails'
  #FactoryGirl.reload
  FactoryGirl.factories.clear
  FactoryGirl.reload
  #FactoryGirl.find_definitions
end

#Enable
#include Warden::Test::Helpers
#Warden.test_mode!

# Will run the given code as the user passed in
def as_user(user=nil, &block)
  current_user = user || FactoryGirl.create(:user, :confirmed_at => Time.now)
  if request.present?
    sign_in(current_user)
  else
    login_as(current_user, :scope => :user)
  end
  #current_user.remember_me!
  #cookies[:remember_token] = {:value => current_user.password_salt, :expires => Time.parse((Date.current + 2.years).to_s), :path => "/"}
  page.cookies[:remember_token] = {:value => current_user.password_salt, :expires => Time.parse((Date.current + 2.years).to_s), :path => "/"}
  #page.driver.browser.set_cookie "remember_token=#{current_user.password_salt}"
  block.call if block.present?
  return self
end

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end

# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

module Capybara
  class Session
    def cookies
      @cookies ||= begin
        secret = Rails.application.config.secret_token
        cookies = ActionDispatch::Cookies::CookieJar.new(secret)
        cookies.stub(:close!)
        cookies
      end
    end
  end
end

