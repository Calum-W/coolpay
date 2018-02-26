require 'user'
require 'spec_helper'

describe User do

  let(:user) { User.new }

  before(:each) do
    response = '{"token":"e815858f-e670-445b-b3c2-bbb6cf1586cc"}'
    stub_request(:post, "https://coolpay.herokuapp.com/api/login").
    with(
     body: "{'username': username, 'apikey': apikey}",
     headers: {
    'Content-Type'=>'application/json',
     }).
        to_return(:status => 200, :body => response)
  end

  describe "#login" do
    it "sets the user's username" do
      user.login("username", "apikey")
      expect(user.token).to eq("e815858f-e670-445b-b3c2-bbb6cf1586cc")
    end

    it "sets the user's token" do
      user.login("username", "apikey")
      expect(user.token).to eq("e815858f-e670-445b-b3c2-bbb6cf1586cc")
    end
  end
end
