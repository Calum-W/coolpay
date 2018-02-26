require 'user'

describe User do

  let(:user) { User.new }

  describe "#login" do
    before(:each) do
      response = '{"token":"e815858f-e670-445b-b3c2-bbb6cf1586cc"}'
      stub_request(:post, "https://coolpay.herokuapp.com/api/login").
      with(
       body: "{'username': username, 'apikey': apikey}",
       headers: {
      'Content-Type' => 'application/json',
       }).
          to_return(:status => 200, :body => response)
    end

    it "sets the user's username" do
      user.login("username", "apikey")
      expect(user.username).to eq("username")
    end

    it "sets the user's token" do
      user.login("username", "apikey")
      expect(user.token).to eq("e815858f-e670-445b-b3c2-bbb6cf1586cc")
    end
  end

  describe "#add_recipient" do
    it "raises an error if the user isn't logged in" do
      expect { user.add_recipient("Jake McError") }.to raise_error "Login required"
    end
  end
end
