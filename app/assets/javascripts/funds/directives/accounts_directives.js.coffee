app.directive 'accounts', ->
  return {
    restrict: 'E'
    templateUrl: "funds/accounts.html"
    scope: { localValue: '=accounts' }
    controller: ($scope, $state) ->
     
      if window.location.hash == ""
        $state.transitionTo("deposits.currency", {currency: Account.first().currency})

      $scope.accounts = Account.all()

      # Might have a better way
      # #/deposits/eur
      $scope.selectedCurrency = window.location.hash.split('/')[2] || Account.first().currency
      $scope.currentAction = window.location.hash.split('/')[1] || 'deposits'
      $scope.currency = $scope.selectedCurrency

      $scope.isSelected = (currency) ->
        $scope.selectedCurrency == currency

      $scope.isDeposit = ->
        $scope.currentAction == 'deposits'

      $scope.isWithdraw = ->
        $scope.currentAction == 'withdraws'

      $scope.deposit = (account) ->
        $state.transitionTo("deposits.currency", {currency: account.currency})
        $selectedCurrency = account.currency
        $currentAction = "deposits"

      $scope.withdraw = (account) ->
        $state.transitionTo("withdraws.currency", {currency: account.currency})
        $selectedCurrency = account.currency
        $currentAction = "withdraws"

      do $scope.event = ->
        Account.bind "create update destroy", ->
          $scope.$apply()

    controllerAs: 'accountsCtrl'
  }

