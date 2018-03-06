module Private
    module Deposits
      class NetpaysController < ::Private::Deposits::BaseController
        include ::Deposits::CtrlNetpayable
      end
    end
  end
  