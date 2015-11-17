time_man = angular.module('time_man',[
  'templates',
  'ngRoute',
  'ngResource',
  'ngCookies',
  'controllers',
  'services'
])

time_man.config(['$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: 'index.html',
        controller: 'ActivitiesController'
      )
      .when('/sessions/new',
        templateUrl: 'sessions/new.html',
        controller: 'SessionsController'
      )
      .when('/users/new',
        templateUrl: 'users/new.html',
        controller: 'UsersController'
      )
])

time_man.run(['$rootScope', '$location', '$cookieStore', '$http',
  ($rootScope, $location, $cookieStore, $http)->
    $rootScope.globals = $cookieStore.get('globals') or {}
    if $rootScope.globals.currentSession?
      $http.defaults.headers.common['Authorization'] = "Token token=#{$rootScope.globals.currentSession.token}"

    $rootScope.$on('$locationChangeStart',
      ()->
        if $location.$$path not in ['/sessions/new', '/users/new'] and not $rootScope.globals.currentSession?
          $location.path('/sessions/new')
    )
])

controllers = angular.module('controllers', [])
services = angular.module('services', [])
