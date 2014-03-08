require 'ts3query/ts3_connection'

module TS3Query
  class ClientConnection < TS3Connection
    private

    def connect(params)
      begin
        @connection = Net::Telnet::new("Host" => params[:address], "Port" => params[:port])
        @connection.waitfor("Match"   => /TS3 Client\n(.*)\n/,
                            "Timeout" => 3)
      rescue
        raise ConnectionRefused, "client not available"
      end
    end
  end
end
