require 'spec_helper'
require 'google-simple-client/session'

module GoogleSimpleClient
  describe Session do
    describe 'initialize' do
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
    end
  end
end
