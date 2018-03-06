module Deposits
    class Netpay < ::Deposit
      include ::AasmAbsolutely
      include ::Deposits::Netpayable
    #   include ::FundSourceable
  
      def charge!(txid)
        with_lock do
          submit!
          accept!
          touch(:done_at)
          update_attribute(:txid, txid)
        end
      end
  
    end
  end
  