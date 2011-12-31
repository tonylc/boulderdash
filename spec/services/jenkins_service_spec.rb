require 'spec_helper'

class TestBackend
  def intialize(address, port)
    @address, @port = address, port
  end
end

describe JenkinsService do
  let(:backend) { mock }
  let(:jenkins_service) { JenkinsService.new(TestBackend) }

  before do
    TestBackend.stubs(:new => backend)
  end

  it "should make call to /job/:job_name/lastBuild/api/json" do
    backend.expects(:get).with("/job/:job_name/lastBuild/api/json", "boulderdash")
    jenkins_service.get_last_build("boulderdash")
  end
end
