class ServiceResolver
  def self.jenkins_uri
    Boulderdash::Application::JENKINS_ROOT_URI.host
  end
end
