module Deposits
  module CtrlCoinable
    extend ActiveSupport::Concern

    def gen_address
      account = current_user.get_account(channel.currency)
      @address = account.payment_addresses.find_or_create_by currency: account.currency 
      @address.gen_address if @address.address.blank?
      render json:{address:@address.address}

      # if !account.payment_address.transactions.empty?
      #   @address = account.payment_addresses.create currency: account.currency
      #   @address.gen_address if @address.address.blank?
      #   render nothing: true
      # else
      #   render text: t('.require_transaction'), status: 403
      # end

    end

  end
end
