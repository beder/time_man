controllers = angular.module('controllers')

controllers.controller('SettingsController', ['$scope', '$location', 'users', 'authentication',
  ($scope, $location, users, authentication)->
    $scope.cancel = ()-> $location.path('/')

    $scope.save = ()->
      users.update(
        null,
        $scope.user,
        (
          ()->
            $location.path('/')
        ),
        (error)->
          errorHandler.handle(error)
      )

    users.get(
      {
        userId: authentication.getSession().user.id
      },
      (
        (user)->
          $scope.user = user
      ),
      (error)->
        errorHandler.handle(error)
    )
])
