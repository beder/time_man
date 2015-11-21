controllers = angular.module('controllers')

controllers.controller('MainController', ['$scope', '$location', 'authentication',
  ($scope, $location, authentication)->
    $scope.activities = ()-> $location.path('/')

    $scope.users = ()-> $location.path('/users')

    $scope.settings = ()-> $location.path('/settings')

    $scope.login = ()-> $location.path('/sessions/new')

    $scope.signup = ()-> $location.path('/users/new')

    $scope.logout = ()->
      authentication.setSession(null)
      $location.path('/sessions/new')

    $scope.$watch(
      ()->
        session = authentication.getSession()
        $scope.loggedIn = session?
        $scope.user_name = if session? then "#{ session.user.first_name } #{ session.user.last_name }" else null
        $scope.canManageUsers = session? and session.user.role in ['manager', 'admin']
    )
])
