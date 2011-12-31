require 'spec_helper'

module Backends
  describe Fake do
    before do
      @backend = Fake.new "some-domain"
    end

    describe "#construct_file_path" do
      it "should be constructed based on the uri" do
        @backend.construct_file_path("artists/:artist_id/locations/:location_id").should =~
          /some_domain\/artists_id_locations_id\.json$/
      end
    end

    it "should raise error if the constructed file path doesn't exist" do
      File.stubs(:exists?).with(/some_domain\/artists_id_locations_id\.json$/).returns(false)
      lambda { @backend.do_request("artists/:artist_id/locations/:location_id") }.should raise_exception
    end
  end
end
