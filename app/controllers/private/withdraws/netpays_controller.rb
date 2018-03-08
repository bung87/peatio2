module Private
  module Withdraws
    class NetpaysController < ::Private::Withdraws::BaseController
      include ::Withdraws::Withdrawable
    end
  end
end
