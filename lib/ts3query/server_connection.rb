require 'ts3query/ts3_connection'

module TS3Query
  class ServerConnection < TS3Connection
    private

    def connect(params)
      begin
        @connection = Net::Telnet::new('Host' => params[:address], 'Port' => params[:port])
        @connection.waitfor('Match'   => /TS3\n(.*)\n/,
                            'Timeout' => 3)
      rescue
        raise(ConnectionRefused, 'server not available')
      end

      begin
        @connection.cmd('String'  => "login client_login_name=#{params[:username]} client_login_password=#{params[:password]}\r",
                        'Match'   => /error id=0 msg=ok\n/,
                        'Timeout' => 3)
      rescue
        raise(ConnectionRefused, 'wrong user data')
      end
    end
  end
end
