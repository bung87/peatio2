module Deposits
    module Netpayable
      extend ActiveSupport::Concern
  
      included do
        validates :amount, presence: true
        delegate :accounts, to: :channel
      end
    end
  end
  