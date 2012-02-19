class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :initialize_jenkins

  private

  def jenkins_service
    JenkinsService.new(Backends::Fake)
  end

  def initialize_jenkins
    @jobs = Boulderdash::Application::JENKINS_CONFIG["jobs"]
  end
end
