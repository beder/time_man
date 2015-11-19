controllers = angular.module('controllers')

controllers.controller('ActivityDeletionConfirmationController', ['$scope', '$uibModalInstance', 'name',
  ($scope, $uibModalInstance, name)->
    $scope.name = name

    $scope.ok = ()->
      $uibModalInstance.close('ok')

    $scope.cancel = ()->
      $uibModalInstance.dismiss('cancel')
])
