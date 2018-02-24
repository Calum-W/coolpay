require 'user'

describe User do

    let(:user) { User.new }

    describe "#login" do

        values = '{
            "username": "CalW",
            "apikey": "6A597CAA3755B4B"
        }'

        headers = {
            :content_type => 'application/json'
        }

        mock_site = 'https://private-anon-002603c7c9-coolpayapi.apiary-mock.com/api/login'


        it "sets the users token if successful" do
            user.login(headers, values, mock_site)
            expect(user.token).to be_truthy
        end
    end
end
