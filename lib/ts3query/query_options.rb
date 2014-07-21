module TS3Query
  class QueryOptions
    attr_reader :options

    def initialize
      @options = []
    end

    def method_missing(meth, *args, &block)
      options << meth.to_s
    end
  end
end
