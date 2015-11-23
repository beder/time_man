controllers = angular.module('controllers')

controllers.controller('RegistrationsController', ['$scope', '$location', 'registrations', 'authentication', 'errorHandler'
  ($scope, $location, registrations, authentication, errorHandler)->
    $scope.signup = (first_name, last_name, email, password, password_confirmation)->
      registrations.save(
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
        (
          (registration)->
            authentication.setSession(registration.session)
            $location.path('/')
        ),
        (error)->
          errorHandler.handle(error)
      )

    $scope.login = ()-> $location.path('/sessions/new')
])
