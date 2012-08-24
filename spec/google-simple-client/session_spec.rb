require 'spec_helper'
require 'google-simple-client/session'
module GoogleSimpleClient
  describe Session do
    describe 'initialize' do
      describe 'with required options' do
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
    end
  end
end
