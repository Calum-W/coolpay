require 'user'

describe User do

    let(:user) { User.new }

    describe "#login" do

        values = '{
            "username": "CalW",
            "apikey": "6A597CAA3755B4BE"
        }'

        headers = {
            :content_type => 'application/json'
        }

        mock_site = 'https://coolpay.herokuapp.com/api/login'


        it "sets the users token if successful" do
            user.login(headers, values, mock_site)
            expect(user.token).to be_truthy
        end

        it "raises an error if not given a username" do
          expect{
            user.login(headers, '{ "username": nil, "apikey": "6A597CAA3755B4B" }', mock_site)
          }.to raise_error(RestClient::BadRequest)
        end

        it "raises an error if not given an api key" do
          expect{
            user.login(headers, '{ "username": "CalW", "apikey": nil }', mock_site)
          }.to raise_error(RestClient::BadRequest)
        end
    end
end
