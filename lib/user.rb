require 'rest_client'
require 'json'
require_relative 'recipient'
require_relative 'payment'

class User

  attr_reader :token, :username

  def initialize
    @token = nil
  end

  def login(username, apikey)
    @username = username
    values = {username: @username, apikey: apikey}.to_json
    response = RestClient.post 'https://coolpay.herokuapp.com/api/login', values, login_headers
    @token = JSON.parse(response)['token']
  end

  def add_recipient(name)
    check_user
    recipient = Recipient.new(name)
    recipient.add(@token)
  end

  def list_recipients
    check_user
    response = RestClient.get 'https://coolpay.herokuapp.com/api/recipients', default_headers
    puts JSON.parse(response)['recipients']
  end

  def search_recipients(name)
    check_user
    response = RestClient.get "https://coolpay.herokuapp.com/api/recipients?name=#{name}", default_headers
    puts JSON.parse(response)['recipients']
  end

  def pay(amount, recipient, currency = "GBP")
    check_user
    payment = Payment.new(amount, recipient, currency)
    payment.send_payment(@token)
  end

  def list_payments
    check_user
    response = RestClient.get 'https://coolpay.herokuapp.com/api/payments', default_headers
    puts JSON.parse(response)['payments']
  end

  private
  def check_user
    fail "Login required" if @token == nil
  end

  def login_headers
    {:content_type => 'application/json'}
  end

  def default_headers
    {
      :content_type => 'application/json',
      :authorization => "Bearer #{@token}"
    }
  end
end
