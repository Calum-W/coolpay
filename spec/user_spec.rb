require 'user'

describe User do

  let(:user) { User.new }

  before(:each) do
    response = '{"token":"e815858f-e670-445b-b3c2-bbb6cf1586cc"}'
    stub_request(:post, "https://coolpay.herokuapp.com/api/login").
    with(
      body: "{\"username\":\"username\",\"apikey\":\"apikey\"}",
            headers: {
           'Accept'=>'*/*',
           'Accept-Encoding'=>'gzip, deflate',
           'Content-Length'=>'41',
           'Content-Type'=>'application/json',
           'Host'=>'coolpay.herokuapp.com',
           'User-Agent'=>'rest-client/2.0.2 (mingw32 x86_64) ruby/2.2.6p396'
            }).
        to_return(:status => 200, :body => response)
  end

  describe "#login" do
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

  describe "#list_recipients" do
    it "prints a hash of recipients" do
      response = '{"recipients":[{"name":"Jake McFriend","id":"61587f02-ca6f-4b64-b3c9-1d35985d0415"}]}'
      stub_request(:get, "https://coolpay.herokuapp.com/api/recipients").
      with(
        headers: {
          :content_type => 'application/json',
          :authorization => 'Bearer e815858f-e670-445b-b3c2-bbb6cf1586cc'
         }).
          to_return(:status => 200, :body => response)
      user.login("username", "apikey")
      expect { user.list_recipients }.
        to output("{\"name\"=>\"Jake McFriend\", \"id\"=>\"61587f02-ca6f-4b64-b3c9-1d35985d0415\"}\n").to_stdout
    end

    it "raises an error if the user isn't logged in" do
      expect { user.list_recipients }.to raise_error "Login required"
    end
  end

  describe "#search_recipients" do
    it "prints a hash of recipients matching the name given" do
      response = '{"recipients":[{"name":"Jake McFriend","id":"61587f02-ca6f-4b64-b3c9-1d35985d0415"}]}'
      stub_request(:get, "https://coolpay.herokuapp.com/api/recipients?name=Jake McFriend").
      with(
        headers: {
          :content_type => 'application/json',
          :authorization => 'Bearer e815858f-e670-445b-b3c2-bbb6cf1586cc'
         }).
          to_return(:status => 200, :body => response)
      user.login("username", "apikey")
      expect { user.search_recipients("Jake McFriend") }.
        to output("{\"name\"=>\"Jake McFriend\", \"id\"=>\"61587f02-ca6f-4b64-b3c9-1d35985d0415\"}\n").to_stdout
    end

    it "raises an error if the user isn't logged in" do
      expect { user.search_recipients("Jake McError") }.to raise_error "Login required"
    end
  end

  describe "#pay" do
    it "raises an error if the user isn't logged in" do
      expect { user.pay(10, "Jake McError") }.to raise_error "Login required"
    end
  end

  describe "#list_payments" do
    it "prints a hash of payments" do
      response = '{"payments": [{"id": "31db334f-9ac0-42cb-804b-09b2f899d4d2", "amount": "10.50",' \
        ' "currency": "GBP", "recipient_id": "6e7b146e-5957-11e6-8b77-86f30ca893d3", "status": "paid"}]}'
      stub_request(:get, "https://coolpay.herokuapp.com/api/payments").
      with(
        headers: {
          :content_type => 'application/json',
          :authorization => 'Bearer e815858f-e670-445b-b3c2-bbb6cf1586cc'
         }).
          to_return(:status => 200, :body => response)
      user.login("username", "apikey")
      expect { user.list_payments }.to output("{\"id\"=>\"31db334f-9ac0-42cb-804b-09b2f899d4d2\", \"amount\"=>\"10.50\"," \
        " \"currency\"=>\"GBP\", \"recipient_id\"=>\"6e7b146e-5957-11e6-8b77-86f30ca893d3\", \"status\"=>\"paid\"}\n").to_stdout
    end

    it "raises an error if the user isn't logged in" do
      expect { user.list_payments }.to raise_error "Login required"
    end
  end
end
