require 'spec_helper'

module Backends
  describe Http do
    before do
      @backend = Http.new("www.google.com", 80)
    end

    describe "#get" do
      it "should do a get request to http://www.google.com/search_results/1" do
        FakeWeb.register_uri(:get, "http://www.google.com/search_results/1", :code => "200", :body => "{\"a\":1}")
        @backend.get("/search_results/:id", 1).should == {"a" => 1}
      end
    end

    describe "#post" do
      it "should do a post request with post data to http://www.google.com/we/own/you" do
        FakeWeb.register_uri(:post, "http://www.google.com/search_results/130/ids/2289", :code => "200", :body => "{\"a\":1}")
        @backend.post("/search_results/:id/ids/:id2", 130, 2289, "post_data" => true).should == {"a" => 1}
      end
    end

    describe "#put" do
      it "should do a put request with post data to http://www.google.com/we/own/you" do
        FakeWeb.register_uri(:put, "http://www.google.com/we/own/you", :code => "200", :body => "{\"a\":1}")
        @backend.put("/we/own/you", "post_data" => true).should == {"a" => 1}
      end
    end

    describe "#delete" do
      it "should do a delete request to http://www.google.com/we/own/you" do
        FakeWeb.register_uri(:delete, "http://www.google.com/we/own/you", :code => "200", :body => "{\"a\":1}")
        @backend.delete("/we/own/you").should == {"a" => 1}
      end
    end

    describe "error handling" do
      it "should by default raise an error when the status code is not 200" do
        FakeWeb.register_uri(:get, "http://www.google.com", :code => "404", :body => "{}")
        @backend.get("/").should raise_error
      end

      it "should ignore errors if the status code is explicitly ignored" do
        FakeWeb.register_uri(:get, "http://www.google.com", :code => "404", :body => "{}")
        @backend.get("/", :ignore_codes => [404])
      end
    end
  end
end
