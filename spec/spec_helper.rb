ENV["RAILS_ENV"] = "test"

require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'rspec/rails'

module ControllerSpecHelper
  def self.included(base)
    base.render_views
  end
end

RSpec.configure do |config|
  config.include ControllerSpecHelper, :type => :controller
  config.mock_with :mocha
end