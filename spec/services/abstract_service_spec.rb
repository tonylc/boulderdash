require 'spec_helper'

class FakeService < AbstractService
  def address
    "www.domain.com"
  end

  def port
    123
  end

  def get_some_thing
    get("/")
  end

  def get_path_without_starting_slash
    get("should/fail")
  end

  def get_question_mark_in_uri_path
    get("/?a=b")
  end

  def get_ampersand_in_uri_path
    get("/a=b&c=d")
  end
end

describe AbstractService do
  let(:fake_service) { FakeService.new(Backends::Http) }

  it "should do request with domain and port" do
    FakeWeb.register_uri(:get, "http://www.domain.com:123/", :code => "200", :body => "{}")
    fake_service.get_some_thing
  end

  it "should raise error if uri_path doesn't start with a '/'" do
    lambda { fake_service.get_path_without_starting_slash }.should raise_error
  end

  it "should raise error if there is a '?' in the uri_path" do
    lambda { fake_service.get_question_mark_in_uri_path }.should raise_error
  end

  it "should raise error if there is a '&' in the uri_path" do
    lambda { fake_service.get_ampersand_in_uri_path }.should raise_error
  end
end
