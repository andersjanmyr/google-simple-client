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

    it 'raises error with  invalid credentials' do
      session = GoogleSimpleClient::Session.new({email: 'missing'})
      expect {
        session.authenticate
      }.to raise_error GoogleSimpleClient::Error
    end
  end
end
