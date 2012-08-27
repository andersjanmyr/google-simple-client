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
      @verbose = @options.delete(:verbose)
      raise Error.new("Missing option error #{@options.inspect}") unless @options.values.all?
    end

    def authenticate
      init_client
      uri = @client.authorization.authorization_uri
      code = scrape_web_and_return_code(uri)
      @client.authorization.code = code
      @client.authorization.fetch_access_token!
      @drive = @client.discovered_api('drive', 'v2')
    end

    def get(title, format)
      files = find_files(title)
      return "No files found for title #{title}" if files.empty?
      if format
        files.map { |f| download_file(f, format) }
      else
        files.map { |f| f.title }
      end
    end

    private

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
      log "Logging into #{uri}"
      page = agent.get(uri)
      log page.title

      # Login
      form = page.form_with(:id => 'gaia_loginform')
      form.Email = @options[:email]
      form.Passwd = @options[:password]
      log "Submitting form"
      page = agent.submit(form)
      log page.title

      # Accept
      accept_form = page.forms[0]
      raise Error.new("Cannot obtain code from #{page.title}") unless accept_form
      log "Accepting form"
      page = agent.submit(accept_form)
      log page.title

      # Code is the string after the =
      code = page.title.split('=')[1]
      raise Error.new("Cannot obtain code from #{page.title}") unless code
      log "Retrieved code: #{code}"
      code
    end


    def find_files(title)
      log "Searching for '#{title}'"
      result = @client.execute(
        :api_method => @drive.files.list,
        :parameters => { :q => "title contains '#{title}'" }
      )
      raise Error.new(result.data['error']['message']) if result.status != 200
      files = result.data
      log "Found #{files.items.size} files"
      files.items
    end

    def download_file(file, format)
      url = file.export_links['application/pdf']
      raise Error.new("Cannot download file #{file}") unless url
      fetch_url = url.sub('pdf', format)
      log "Fetching file: #{fetch_url}"
      result = @client.execute(:uri => fetch_url)
      raise Error.new(result.data['error']['message']) unless result.status == 200

      log result.body
      return result.body
    end

    def log text
      puts text if @verbose
    end
  end
end
