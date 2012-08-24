require 'spec_helper'

require 'google-simple-client'

describe 'session integration' do
  before do
    File.exist?("#{ENV['HOME']}/.google-simple-client").should be
  end

  describe '#authenticate' do
    it 'works with valid credentials' do
      session = GoogleSimpleClient::Session.new
      session.authenticate
    end
  end
end
