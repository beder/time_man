controllers = angular.module('controllers')

controllers.controller('SessionsController', ['$rootScope', '$scope', '$routeParams', '$location', '$cookieStore', '$http', 'sessions',
  ($rootScope, $scope, $routeParams, $location, $cookieStore, $http, sessions)->
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
          $rootScope.globals = {
            currentSession: session
          }
          $http.defaults.headers.common['Authorization'] = "Token token=#{$rootScope.globals.currentSession.token}"
          $cookieStore.put('globals', $rootScope.globals);
          $location.path('/')
      )

    $scope.signup = ()->
      $location.path('/users/new')
])
