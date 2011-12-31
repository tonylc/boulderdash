module ApplicationHelper
  def build_job_link(job_name)
    link_to('Build', Boulderdash::Application::JENKINS_ROOT_URI.merge("job/#{job_name}/build?delay=0sec").to_s)
  end
end
