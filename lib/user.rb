require 'rest_client'
require 'json'
require 'recipient'
require 'payment'

class User

  attr_reader :token, :username

  def initialize
    @token = nil
  end

  def login(username, apikey)
    @username = username
    @apikey = apikey
    loginheaders = {:content_type => 'application/json'}
    values = "{'username': #{@username}, 'apikey': #{@apikey}}"
    response = RestClient.post 'https://coolpay.herokuapp.com/api/login', values, loginheaders
    @token = JSON.parse(response)['token']
  end

  def add_recipient(name)
    check_user
    recipient = Recipient.new(name)
    recipient.add(@token)
  end

  def list_recipients
    check_user
    headers = {
      :content_type => 'application/json',
      :authorization => 'Bearer ' + @token
    }
    response = RestClient.get 'https://coolpay.herokuapp.com/api/recipients', headers
    puts JSON.parse(response)['recipients']
  end

  def search_recipients(name)
    check_user
    headers = {
      :content_type => 'application/json',
      :authorization => 'Bearer ' + @token
    }
    response = RestClient.get "https://coolpay.herokuapp.com/api/recipients?name=#{name}", headers
    puts JSON.parse(response)['recipients']
  end

  def pay(amount, recipient)
    check_user
    payment = Payment.new(amount, recipient)
    payment.send_payment
  end

  private
  def check_user
    fail "Login required" if @token == nil
  end
end
