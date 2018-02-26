require 'rest_client'
require 'json'

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
    recipient = Recipient.new(name)
    recipient.add(@token)
  end
end
