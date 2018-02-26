require 'recipient'

describe Recipient do

  let(:recipient) { Recipient.new('Jake McStubby') }

  describe "#add" do
    before(:each) do
      response = '{"recipient": {"name": "Jake McStubby", "id": "e9a0336b-d81d-4009-9ad1-8fa1eb43418c"}}'
      stub_request(:post, "https://coolpay.herokuapp.com/api/recipients").
         with(
           body: "{'recipient': {'name': Jake McStubby}}",
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip, deflate',
          'Authorization'=>'Bearer mock_token',
          'Content-Length'=>'38',
          'Content-Type'=>'application/json',
          'Host'=>'coolpay.herokuapp.com',
          'User-Agent'=>'rest-client/2.0.2 (mingw32 x86_64) ruby/2.2.6p396'
           }).
          to_return(:status => 200, :body => response)
    end

    it "sets the id of the recipient" do
      recipient.add("mock_token")
      expect(recipient.id).to eq("e9a0336b-d81d-4009-9ad1-8fa1eb43418c")
    end
  end
end
