class JenkinsService < AbstractService
  def initialize(backend)
    @backend_client = backend
  end

  def get_last_build(job_name)
    get("/job/:job_name/lastBuild/api/json", job_name)
  end

  def address
    ServiceResolver.jenkins_uri
  end
end
