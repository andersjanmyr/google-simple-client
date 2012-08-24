
module GoogleSimpleClient
  class Session
    OAUTH_SCOPE = 'https://www.googleapis.com/auth/drive.readonly'
    REDIRECT_URI = 'urn:ietf:wg:oauth:2.0:oob'

    def initialize options
      @options = {
        redirect_uri: REDIRECT_URI,
        scope: OAUTH_SCOPE,
        client_id: nil,
        client_secret: nil,
        email: nil,
        password: nil
      }
      @options.merge!(options)
      raise "Missing option error #{@options.inspect}" unless @options.values.all?
    end
  end

end
