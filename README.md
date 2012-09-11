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
          password: 'password',
          verbose: true
        })
    session.authenticate
    pdf = session.get 'title', 'pdf'


Supported formats are (at least): 'pdf', 'html', 'csv', 'txt' etc.

## Usage CLI

    $ google-simple-client [options] title

    Options are ...
        -f, --format FORMAT              Format of the file to get
        -v, --verbose                    Log to standard output.
        -V, --version                    Display the program version.
        -h, --help                       Display this help message.P

## Configuration

It is also possible to set the options to `Session.new` in a configuration
file called `~/.google-simple-client` or `$HOME/.google-simple-client`. The
format of the file is YAML. Example:

    #.google-simple-client

    client_id: cid
    client_secret: secret
    email: email
    password: password

Command line parameters and code parameters override the configuration file
options as expected.



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
