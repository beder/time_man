controllers = angular.module('controllers')

controllers.controller('SettingsController', ['$scope', '$location', 'users', 'authentication',
  ($scope, $location, users, authentication)->
    $scope.cancel = ()-> $location.path('/')

    $scope.save = ()->
      users.update(
        null,
        $scope.user,
        ()->
          $location.path('/')
      )

    users.get(
      {
        userId: authentication.getSession().user.id
      },
      (user)->
        $scope.user = user
    )
])
