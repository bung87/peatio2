app.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state('deposits', {
      url: '/deposits'
      templateUrl: "funds/deposits.html"
    })
    .state('deposits.currency', {
      url: "/:currency"
      templateUrl: "funds/deposit.html"
      controller: 'DepositsController'
      currentAction: 'deposit'
    })
    .state('withdraws', {
      url: '/withdraws'
      templateUrl: "funds/withdraws.html"
    })
    .state('withdraws.currency', {
      url: "/:currency"
      templateUrl: "funds/withdraw.html"
      controller: 'WithdrawsController'
      currentAction: "withdraw"
    })
