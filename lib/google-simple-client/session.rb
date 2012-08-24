require 'yaml'
require 'google/api_client'
require 'mechanize'

require 'google-simple-client/error'

module GoogleSimpleClient
  class Session
    OAUTH_SCOPE = 'https://www.googleapis.com/auth/drive.readonly'
    REDIRECT_URI = 'urn:ietf:wg:oauth:2.0:oob'

    def initialize options = {}
      @options = {
        redirect_uri: REDIRECT_URI,
        scope: OAUTH_SCOPE,
        client_id: nil,
        client_secret: nil,
        email: nil,
        password: nil
      }
      init_file_options = read_options_from_init_file
      @options.merge!(init_file_options)
      @options.merge!(options)
      raise Error.new("Missing option error #{@options.inspect}") unless @options.values.all?
    end

    def read_options_from_init_file
      file = find_init_file
      if file
        hash = YAML.load_file(file)
        hash.each_with_object({}){|(k,v), h| h[k.to_sym] = v}
      else
        {}
      end
    end

    def find_init_file
      return '.google-simple-client' if File.exist?('.google-simple-client')
      return "#{ENV['HOME']}/.google-simple-client" if File.exist?("#{ENV['HOME']}/.google-simple-client")
    end

    def authenticate
      init_client
      uri = @client.authorization.authorization_uri
      code = scrape_web_and_return_code(uri)
      @client.authorization.code = code
      @client.authorization.fetch_access_token!
    end

    def init_client
     @client = Google::APIClient.new

     @client.authorization.client_id = @options[:client_id]
     @client.authorization.client_secret = @options[:client_secret]
     @client.authorization.scope = @options[:scope]
     @client.authorization.redirect_uri = @options[:redirect_uri]
    end

    def scrape_web_and_return_code uri
      agent = Mechanize.new

      # Start loggin in
      page = agent.get(uri)

      # Login
      form = page.form_with(:id => 'gaia_loginform')
      form.Email = @options[:email]
      form.Passwd = @options[:password]
      page = agent.submit(form)

      # Accept
      accept_form = page.forms[0]
      raise Error.new("Cannot obtain code from #{page.title}") unless accept_form
      page = agent.submit(accept_form)

      # Code is the string after the =
      code = page.title.split('=')[1]
      raise Error.new("Cannot obtain code from #{page.title}") unless code
      code
    end
  end

end
