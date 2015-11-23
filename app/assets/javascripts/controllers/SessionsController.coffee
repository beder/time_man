controllers = angular.module('controllers')

controllers.controller('SessionsController', ['$scope', '$location', 'sessions', 'authentication', 'errorHandler',
  ($scope, $location, sessions, authentication, errorHandler)->
    $scope.login = (email, password)->
      sessions.save(
        null,
        {
          user: {
            email: email,
            password: password
          }
        },
        (
          (session)->
            authentication.setSession(session)
            $location.path('/')
        ),
        (error)->
          errorHandler.handle(error)
      )

    $scope.signup = ()->
      $location.path('/users/new')
])
