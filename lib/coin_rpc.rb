module CoinRPC
  class JSONRPCError < RuntimeError; end
  class ConnectionRefusedError < StandardError; end

  def self.[](currency)
    c = Currency.find_by_code(currency.to_s)
    (c.nil? || c.rpc.empty? || c.code.empty?) && raise("RPC url for #{name} not found! Please fix that in `config/currencies.yml`")
    "CoinRPC::#{c.code.upcase}".constantize.new(c)
  end

  class BaseRPC
    def initialize(c)
      @uri = URI.parse(c.rpc)
      @rest_uri = URI.parse(c[:rest_api]) if c[:rest_api]
    end

    def handle
      raise 'Not implemented'
    end

    def gettransaction(txid)
      # expect return a hash contains :confirmations models/payment_transaction.rb
      raise "Not implemented"
    end
  
    def getnewaddress(m = "payment")
      # expect return a new coin address now @deprecated
      raise "Not implemented"
    end
  
    def getbalance
      # expect return account balance as float
      raise "Not implemented"
    end
  
    def sendtoaddress(to,amount)
      raise "Not implemented"
    end
  
    def settxfee()
      raise "Not implemented"
    end
  
    def listtransactions(account, number)
      raise "Not implemented"
    end

    def validateaddress(address)
      # expect address available on node
      raise "Not implemented"
    end
  

    private

    def method_missing(name, *args)
      handle name, *args
    end
  end
end
