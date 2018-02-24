require 'rest_client'
require 'json'

class User

  attr_reader :token

  def initialize
    @token = nil
  end

  def login(loginheaders, values, site)
    response = RestClient.post site, values, loginheaders
    @token = JSON.parse(response)['token']
  end
end
