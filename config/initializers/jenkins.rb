jenkins_file_path = "#{Rails.root}/config/jenkins.yml"
raise "Must specify jenkins configuration in 'config/jenkins.yml'" unless File.exist?(jenkins_file_path)
# load jenkins config file
Boulderdash::Application::JENKINS_CONFIG = YAML::load(File.open(jenkins_file_path))["jenkins"]
