controllers = angular.module('controllers')

controllers.controller('UsersController', ['$rootScope', '$scope', '$http', '$location', '$cookieStore', 'users', 'sessions',
  ($rootScope, $scope, $http, $location, $cookieStore, users, sessions)->
    $scope.signup = (first_name, last_name, email, password, password_confirmation)->
      users.save(
        null,
        {
          user: {
            first_name: first_name,
            last_name: last_name,
            email: email,
            password: password,
            password_confirmation: password_confirmation
          }
        },
        ()->
          sessions.save(
            null,
            {
              user: {
                email: email,
                password: password
              }
            },
            (session)->
              $rootScope.globals = {
                currentSession: session
              }
              $http.defaults.headers.common['Authorization'] = "Token token=#{$rootScope.globals.currentSession.token}"
              $cookieStore.put('globals', $rootScope.globals);
              $location.path('/')
          )
      )

    $scope.login = ()-> $location.path('/sessions/new')
])
