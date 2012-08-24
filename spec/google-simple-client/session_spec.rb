require 'spec_helper'
require 'google-simple-client/session'

module GoogleSimpleClient
  describe Session do
    describe '#initialize' do
      describe 'with all required options' do
        session = Session.new({
          client_id: 'cid',
          client_secret: 'secret',
          email: 'email',
          password: 'password'
        })

        it 'is properly initialized' do
          session.should be
        end
      end

      describe 'with missing required options' do
        it 'raises error when a required option is missing' do
          expect {
            Session.new({
              client_secret: 'secret',
              email: 'email',
              password: 'password'
            })
          }.to raise_error Error
        end
      end

      describe 'with options in init file' do
        before do
          File.open('.google-simple-client', 'w') do |f|
            f.puts('client_id: cid')
            f.puts('client_secret: secret')
            f.puts('email: email')
            f.puts('password: password')
          end
        end

        it 'uses the options from the local file' do
          Session.new
        end

        after do
          File.delete('.google-simple-client')
        end
      end
    end
  end
end
