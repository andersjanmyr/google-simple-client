# GoogleSimpleClient

Simplifies the usage of google-api-client and provides a command line tool for
finding and getting documents from Google Drive.


## Installation

Add this line to your application's Gemfile:

    gem 'google-simple-client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install google-simple-client

## Register an App with Google Drive

Enable [Google drive](https://developers.google.com/drive/register).
Make sure that you enable both the `Drive API` and the `Drive SDK`.

## Usage API

    session = GoogleSimpleClient::Session.new({
          client_id: 'cid',
          client_secret: 'secret',
          email: 'email',
          password: 'password'
        })
    session.authenticate
    pdf = session.get 'title', 'pdf'

## Usage CLI

    $ google-simple-client [options] command 


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
