module Withdraws
  class Netpay < ::Withdraw
    include ::AasmAbsolutely
    include ::Withdraws::Coinable
  end
end
