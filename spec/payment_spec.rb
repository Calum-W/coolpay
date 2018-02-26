require 'payment'

describe Payment do

  let(:payment) { Payment.new(10.5, "31db334f-9ac0-42cb-804b-09b2f899d4d2", "GBP") }

  describe "#pay" do
    it "returns confirmation the payment is processing if successful" do
      response = '{"payment": {"id": "31db334f-9ac0-42cb-804b-09b2f899d4d2", "amount": "10.5",' \
        ' "currency": "GBP", "recipient_id": "6e7b146e-5957-11e6-8b77-86f30ca893d3", "status": "processing"}}'
      stub_request(:post, "https://coolpay.herokuapp.com/api/payments").
      with(
        body: "{'payment': {'amount': 10.5, 'currency': GBP, 'recipient_id': 31db334f-9ac0-42cb-804b-09b2f899d4d2}}",
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip, deflate',
         'Authorization'=>'Bearer mock_token',
         'Content-Length'=>'100',
         'Content-Type'=>'application/json',
         'Host'=>'coolpay.herokuapp.com',
         'User-Agent'=>'rest-client/2.0.2 (mingw32 x86_64) ruby/2.2.6p396'
          }).
          to_return(:status => 200, :body => response)
      expect { payment.send_payment("mock_token") }.
        to output("{\"payment\": {\"id\": \"31db334f-9ac0-42cb-804b-09b2f899d4d2\", \"amount\": \"10.5\"," \
          " \"currency\": \"GBP\", \"recipient_id\": \"6e7b146e-5957-11e6-8b77-86f30ca893d3\", \"status\": \"processing\"}}\n").to_stdout
    end
  end
end
