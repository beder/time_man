controllers = angular.module('controllers')

controllers.controller('DeletionConfirmationController', ['$scope', '$uibModalInstance', 'objectType', 'name',
  ($scope, $uibModalInstance, objectType, name)->
    $scope.objectType = objectType
    $scope.name = name

    $scope.ok = ()->
      $uibModalInstance.close('ok')

    $scope.cancel = ()->
      $uibModalInstance.dismiss('cancel')
])
