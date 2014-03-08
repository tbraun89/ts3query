require 'net/telnet'

class TS3Connection
  def initialize(params)
    connect(params)
  end

  def disconnect
    @connection.close
  end

  def method_missing(meth, *args, &block)
    result  = []
    options = ""
    params  = ""

    if block
      query_options = QueryOptions.new
      yield query_options

      query_options.options.each do |opt|
        options += " -#{opt}"
      end
    end

    if args.first
      args.first.each do |key, value|
        params += " #{key}=#{value}"
      end
    end

    @connection.cmd("String"  => "#{meth}#{params}#{options}\r",
                    "Match"   => /error id=0 msg=ok\n/,
                    "Timeout" => 3) { |data|
      data.force_encoding 'UTF-8'
      data.split("|").each do |current|
        current_data = {}
        current.split(" ").each do |entity|
          current_data[entity.split("=")[0]] = entity.split("=")[1]
        end
        current_data.delete("error")
        current_data.delete("id")
        current_data.delete("msg")

        result << current_data
      end
    }
    result << {"id" => "0", "msg" => "ok"}
    result.delete({})
    result
  end

  private

  def connect(params)
    begin
      @connection = Net::Telnet::new("Host" => params[:address], "Port" => params[:port])
      @connection.waitfor("Match"   => /TS3\n(.*)\n/,
                          "Timeout" => 3)
    rescue
      raise ConnectionRefused, "server not available"
    end

    begin
      @connection.cmd("String"  => "login client_login_name=#{params[:username]} client_login_password=#{params[:password]}\r",
                      "Match"   => /error id=0 msg=ok\n/,
                      "Timeout" => 3)
    rescue
      raise ConnectionRefused, "wrong user data"
    end
  end
end

class QueryOptions
  def initialize
    @options = []
  end

  def method_missing(meth, *args, &block)
    options << meth.to_s
  end

  def options
    @options
  end
end

class ConnectionRefused < StandardError
end