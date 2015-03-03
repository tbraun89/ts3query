require 'ts3query/server_connection'
require 'ts3query/client_connection'

module TS3Query
  DEFAULT_SERVER_PARAMS = {
    address:  '127.0.0.1',
    port:     '10011',
    username: 'serveradmin'
  }

  DEFAULT_CLIENT_PARAMS = {
    address: '127.0.0.1',
    port:    '25639'
  }

  def self.server_connect(params = {})
    ServerConnection.new(DEFAULT_SERVER_PARAMS.merge(params))
  end

  def self.client_connect(params = {})
    ClientConnection.new(DEFAULT_CLIENT_PARAMS.merge(params))
  end
end
