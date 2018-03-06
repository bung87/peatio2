# required
WxPay.appid = ENV['WX_APP_ID']
WxPay.key = ENV["WX_PAY_KEY"]
WxPay.mch_id = ENV["WX_MCH_ID"]
# WxPay.debug_mode = true # default is `true`
# WxPay.sandbox_mode = false # default is `false`

# cert, see https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=4_3
# using PCKS12
# WxPay.set_apiclient_by_pkcs12(File.read(pkcs12_filepath), pass)
#
# # if you want to use `generate_authorize_req` and `authenticate`
# WxPay.appsecret = 'YOUR_SECRET'

# optional - configurations for RestClient timeout, etc.
WxPay.extra_rest_client_options = {timeout: 2, open_timeout: 3}