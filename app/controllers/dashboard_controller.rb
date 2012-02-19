class DashboardController < ApplicationController
  def index
    @jobs.each do |job_name|
      jenkins_service.get_last_build(job_name)
    end
  end
end
