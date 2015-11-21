services = angular.module('services')

services.factory('authentication', ['$rootScope', '$cookieStore', '$http',
  ($rootScope, $cookieStore, $http)->
    new class Authentication
      constructor: ->
        $rootScope.globals = $cookieStore.get('globals') or {}
        @setSession($rootScope.globals.currentSession)

      setSession: (session)->
        @session = session
        $rootScope.globals = {
          currentSession: session
        }
        $cookieStore.put('globals', $rootScope.globals)
        $http.defaults.headers.common['Authorization'] = if session? then "Token token=#{session.token}" else null

      getSession: ->
        @session
])
