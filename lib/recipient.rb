require 'rest_client'
require 'json'

class Recipient

  attr_reader :name, :id

  def initialize(name)
    @name = name
  end

  def add(token)
    values = "{
               'recipient': {
                 'name': #{@name}
                }
               }"

    headers = {
      :content_type => 'application/json',
      :authorization => 'Bearer ' + token
    }

    response = RestClient.post 'https://coolpay.herokuapp.com/api/recipients', values, headers
    @id = JSON.parse(response)['recipient']['id']
  end
end
