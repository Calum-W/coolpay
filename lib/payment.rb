require 'rest_client'
require 'json'

class Payment

  def initialize(amount, recipient, currency)
    @amount = amount
    @recipient = recipient
    @currency = currency
  end

  def send_payment(token)
    values = "{'payment': {'amount': #{@amount}, 'currency': #{@currency}, 'recipient_id': #{@recipient}}}"
    headers = {
      :content_type => 'application/json',
      :authorization => "Bearer #{token}"
    }
    response = RestClient.post 'https://coolpay.herokuapp.com/api/payments', values, headers
    puts response
  end
end
