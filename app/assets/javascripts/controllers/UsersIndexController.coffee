controllers = angular.module('controllers')

controllers.controller('UsersIndexController', ['$scope', '$routeParams', '$location', '$uibModal', 'users',
  ($scope, $routeParams, $location, $uibModal, users)->
    $scope.add = (first_name, last_name, role, email, hours_per_day, password, password_confirmation)->
      users.save(
        null,
        {
          user: {
            first_name: first_name,
            last_name: last_name,
            role: role,
            email: email,
            hours_per_day: hours_per_day,
            password: password,
            password_confirmation: password_confirmation
          }
        },
        (user)=>
          $scope.users.push(user)
          @first_name = null
          @last_name = null
          @role = null
          @email = null
          @hours_per_day = null
          @password = null
          @password_confirmation = null
      )

    $scope.edit = (user)->
      $scope.editingUser = user
      $scope.editedUser = angular.copy(user)

    $scope.cancel = ()->
      $scope.editingUser = null

    $scope.editing = (user)->
      $scope.editingUser == user

    $scope.save = ()->
      $scope.editingUser.first_name = $scope.editedUser.first_name
      $scope.editingUser.last_name = $scope.editedUser.last_name
      $scope.editingUser.role = $scope.editedUser.role
      $scope.editingUser.email = $scope.editedUser.email
      $scope.editingUser.hours_per_day = $scope.editedUser.hours_per_day
      users.update(
        null,
        $scope.editingUser,
        ()->
          $scope.editingUser = null
      )

    $scope.delete = (user)->
      modalInstance = $uibModal.open({
        animation: true,
        templateUrl: 'modals/deletion_confirmation.html',
        controller: 'DeletionConfirmationController',
        resolve: {
          name: ()->
            "#{user.first_name} #{user.last_name}"
          objectType: ()->
            'user'
        }
      })
      modalInstance.result.then(()->
        users.delete(
          null,
          user,
          ()->
            $scope.users = $scope.users.filter (a)-> a isnt user
        )
      )

    users.query(
      null,
      (results)->
        $scope.users = results
    )
])
