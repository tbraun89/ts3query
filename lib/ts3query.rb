require 'ts3query/server_connection'
require 'ts3query/client_connection'

module TS3Query

  DefaultServerParams = {
    :address  => "127.0.0.1",
    :port     => "10011",
    :username => "serveradmin"
  }

  DefaultClientParams = {
    :address  => "127.0.0.1",
    :port     => "25639"
  }

  def self.connect(params = {})
    warn "DEPRECATED(#{Kernel.caller.first}) use TS3Query.server_connect instead of TS3Query.connect"
    server_connect params
  end

  def self.server_connect(params = {})
    ServerConnection.new DefaultServerParams.merge(params)
  end

  def self.client_connect(params = {})
    ClientConnection.new DefaultClientParams.merge(params)
  end

end
