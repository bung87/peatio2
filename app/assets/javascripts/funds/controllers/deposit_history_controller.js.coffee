app.controller 'DepositHistoryController', ($scope, $stateParams, $http,$timeout) ->
  # ctrl = @
  $scope.predicate = '-id'
  $scope.currency = $stateParams.currency
  $scope.account = Account.findBy('currency', $scope.currency)
  $scope.deposits = $scope.account.deposits().slice(0, 3)
  $scope.newRecord = (deposit) ->
    if deposit.aasm_state == "submitting" then true else false

  $scope.noDeposit = ->
    $scope.deposits.length == 0

  $scope.refresh = ->
    $scope.deposits = $scope.account.deposits().slice(0, 3)

  $scope.cancelDeposit = (deposit) ->
    deposit_channel = DepositChannel.findBy('currency', deposit.currency)
    $http.delete("/deposits/#{deposit_channel.resource_name}/#{deposit.id}")
      .then ( ->
          deposit.aasm_state = "cancelled"
          $.publish 'deposit:update'
        ),
        (responseText) ->
          $.publish 'flash', { message: responseText }

  $scope.canCancel = (state) ->
    ['submitting'].indexOf(state) > -1

  do $scope.event = ->
    Deposit.bind "create update destroy", ->
      $scope.refresh()
