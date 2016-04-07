require 'test_helper'

describe ExpediaApi::Client do
  describe "initialize" do
    it "returns a client object" do
      assert_equal ExpediaApi::Client, ExpediaApi::Client.new.class
    end
  end

  describe "get_list" do
    it "returns a response class item" do
      stub_request(:get, "https://ews.expedia.com/wsapi/rest/hotel/v1/search?format=json&key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => [], :headers => {})
      assert_equal ExpediaApi::HotelResponseList, ExpediaApi::Client.new.get_list.class
    end
    it "returns an empty array if no data is returned" do
      stub_request(:get, "https://ews.expedia.com/wsapi/rest/hotel/v1/search?format=json&key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => [], :headers => {})
      assert_equal 0, ExpediaApi::Client.new.get_list.entries.length
    end
    it "includes an exception if one is risen" do
      stub_request(:any, "https://ews.expedia.com/wsapi/rest/hotel/v1/search?format=json&key").to_raise(Faraday::ConnectionFailed)
      assert_equal true, ExpediaApi::Client.new.get_list.error?
      assert ExpediaApi::Client.new.get_list.exception
    end
  end
end
