module Private
    module Deposits
        class PostPay  < ::ApplicationController
            def wx_callback
                result = Hash.from_xml(request.body.read)["xml"]
                id = params[:id]
                @deposit = Deposit.find_by(type:"Deposits::Netpay",id:id)
                if WxPay::Sign.verify?(result)
                    
                    @deposit.submit!
                    @deposit.accepted!
                    render :json => {return_code: "SUCCESS"}
                else
                    @deposit.submit!
                    @deposit.reject!
                    render :json => {return_code: "FAIL", return_msg: "签名失败"}
                end
            end
        end
    end
end
  