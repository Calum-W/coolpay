# Coolpay

### Scenario
Coolpay is a new company that allows to easily send money to friends through their API.

You work for Fakebook, a successful social network. You’ve been tasked to integrate Coolpay inside Fakebook. A/B tests show that users prefer to receive money than pokes!

You can find Coolpay documentation here: http://docs.coolpayapi.apiary.io/

You will write a small app that uses Coolplay API in Ruby. The app should be able do the following:

- Authenticate to Coolpay API
- Add recipients
- Send them money
- Check whether a payment was successful

### My process
This was my first time working with an API in Ruby, so before writing any code, I spent a lot of time reading about how to begin and best practices.

I also played around with the Coolpay API to become familiar with exactly how it works. If this had meant making persistent and irreversible changes to an account on any other API, I wouldn't have done this. However, the Coolpay API exists only as a tool for tech tests, so I decided it was acceptable to send all of my virtual money to Jake McFriend and others in order to better understand it (and to feature test later).

After diagramming to help myself visualise the app, I began by creating a user that needed to login (calling the api using the rest-client gem). I then made a Recipient class, which could be instantiated by the user, and then a method to list recipients. Next I followed a similar pattern with a Payment class, allowing them to be instantiated (and sent) by the user, as well as listed. Lastly, I refactored my methods to be more DRY and make certain information private.

Throughout this process, I followed TDD principles and stubbed all API calls using the Webmock gem.

### Next steps
My time was limited in building this app, as I had received three tech tests on the same day. Given more time, I would like to do at least three more things:
1. Refactor by creating another class which would handle all the API calls. This class could contain the url and headers, and would be passed an endpoint upon instantiation.
2. Include more specific error messages and testing for them.
3. Make a method that prints the information output by list_recipients and list_payments methods in a more aesthetically pleasing way.

### How to run
This app can be run in the command line. Run 'bundle install' for any gem dependencies before doing the following:
**Tests** - Enter 'rspec' in the command line
**App** - Run irb then require the file ‘user.rb’
