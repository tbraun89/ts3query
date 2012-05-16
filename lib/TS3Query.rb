require 'ts3query/ts3_connection'

module TS3Query
  
  def self.connect(params = {})
    params = {
      :address  => "127.0.0.1",
      :port     => "10011",
      :username => "serveradmin"
    }.merge(params)
    
    TS3Connection.new params
  end
  
end