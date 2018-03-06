module Deposits
    module CtrlNetpayable
    extend ActiveSupport::Concern

    included do
        before_filter :fetch
    end

    def create
        next_id = Deposit.maximum(:id).next rescue 1
        @deposit = model_kls.new(deposit_params)
        @deposit.id = next_id
        result = {}
        case channel.currency
        when "cny"

            path = "/deposits/postpay/wx_callback?id=#{next_id}"
            notify_url = "#{ENV['URL_SCHEMA']}://#{ENV['URL_HOST']}#{path}"
            params = {
            body: '测试商品',
            out_trade_no: next_id,
            total_fee: 1,
            spbill_create_ip: '127.0.0.1',
            notify_url: notify_url,
            trade_type: 'NATIVE', # could be "JSAPI", "NATIVE" or "APP",
            }
            result = WxPay::Service.invoke_unifiedorder(params) rescue {}
        end
        if @deposit.save
        render json: result.merge!(deposit_params).merge!({
                id:@deposit.id,
                created_at:@deposit.created_at
        })
        else
        render text: @deposit.errors.full_messages.join, status: 403
        end
    end

    def destroy
        @deposit = current_user.deposits.find(params[:id])
        @deposit.cancel!
        render nothing: true
    end

    private

    def fetch
        Rails.logger.info(current_user.inspect)
        Rails.logger.info(channel.inspect)
        @account = current_user.get_account(channel.currency)
        @model = model_kls
        # @fund_sources = current_user.fund_sources.with_currency(channel.currency)
        @assets = model_kls.where(member: current_user).order(:id).reverse_order.limit(10)
    end

    def deposit_params
        params[:deposit][:currency] = channel.currency
        params[:deposit][:member_id] = current_user.id
        params[:deposit][:account_id] = @account.id
        params.require(:deposit).permit( :amount, :currency, :account_id, :member_id)
    end
    end
end
  