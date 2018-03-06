module Private
  class FundsController < BaseController
    layout 'funds'

    before_action :auth_activated!
    before_action :auth_verified!
    before_action :two_factor_activated!

    def index
      gen_address
      @deposit_channels = DepositChannel.all
      @withdraw_channels = WithdrawChannel.all
      @currencies = Currency.all.sort
      @deposits = current_user.deposits
      @accounts = current_user.accounts.enabled.sort_by {|t| Currency.find_by(code:t.currency).sort_order }
      @withdraws = current_user.withdraws
      @fund_sources = current_user.fund_sources
      @banks = Bank.all
      gon.jbuilder
    end
    
    private
    def gen_address
      current_user.accounts.each do |account|
        currency_obj = account.currency_obj
        currency_obj = Hashie::Mash.new({coin:false}) if not currency_obj #dirty data
        next if not currency_obj.coin?

        if account.payment_addresses.blank?
          account.payment_addresses.create(currency: account.currency)
        else
          address = account.payment_addresses.last
          address.gen_address if address.address.blank?
        end
      end
      # render nothing: true
    end

  end
end

