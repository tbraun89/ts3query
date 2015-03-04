require 'net/telnet'
require 'ts3query/errors'
require 'ts3query/query_options'
require 'ts3query/escaping'

module TS3Query
  class TS3Connection
    def initialize(params)
      connect(params)
    end

    def disconnect
      @connection.close
    end

    def method_missing(meth, *args, &block)
      result  = []
      options = ''
      params  = ''

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

      @connection.cmd('String'  => "#{meth}#{params}#{options}\r",
                      'Match'   => /error id=0 msg=ok\n/,
                      'Timeout' => 3) { |data|

        data.force_encoding 'UTF-8'

        data.split('|').each do |current|
          current_data = {}

          current.split(' ').each do |entity|
            key, value        = entity.split '='
            current_data[key] = value.is_a?(String) ? Escaping.decode(value) : nil
          end

          current_data.delete('error')
          current_data.delete('id')
          current_data.delete('msg')

          result << current_data
        end
      }

      result << {'id' => '0', 'msg' => 'ok'}

      result.delete({})
      result
    end
  end
end
