controllers = angular.module('controllers')

controllers.controller('SessionsController', ['$scope', '$location', 'sessions', 'authentication',
  ($scope, $location, sessions, authentication)->
    $scope.login = (email, password)->
      sessions.save(
        null,
        {
          user: {
            email: email,
            password: password
          }
        },
        (session)->
          authentication.setSession(session)
          $location.path('/')
      )

    $scope.signup = ()->
      $location.path('/users/new')
])
