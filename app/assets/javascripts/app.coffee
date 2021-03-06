time_man = angular.module('time_man',[
  'templates',
  'ngFileSaver',
  'ngRoute',
  'ngResource',
  'ngCookies',
  'flash',
  'ui.bootstrap',
  'controllers',
  'services'
])

time_man.config(['$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        redirectTo: '/activities'
      )
      .when('/activities',
        templateUrl: 'activities/index.html',
        controller: 'ActivitiesController'
      )
      .when('/sessions/new',
        templateUrl: 'sessions/new.html',
        controller: 'SessionsController'
      )
      .when('/users/new',
        templateUrl: 'registrations/new.html',
        controller: 'RegistrationsController'
      )
      .when('/users',
        templateUrl: 'users/index.html',
        controller: 'UsersIndexController'
      )
      .when('/users/:userId/activities',
        templateUrl: 'activities/index.html',
        controller: 'ActivitiesController'
      )
      .when('/settings',
        templateUrl: 'settings/edit.html',
        controller: 'SettingsController'
      )
])

time_man.run(['$rootScope', '$cookieStore', '$location', 'authentication',
  ($rootScope, $cookieStore, $location, authentication)->
    $rootScope.$on('$locationChangeStart',
      ()->
        if $location.$$path not in ['/sessions/new', '/users/new'] and not authentication.getSession()?
          $location.path('/sessions/new')
    )
])

controllers = angular.module('controllers', [])
services = angular.module('services', [])
