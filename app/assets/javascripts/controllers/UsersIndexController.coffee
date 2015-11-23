controllers = angular.module('controllers')

controllers.controller('UsersIndexController', ['$scope', '$routeParams', '$location', '$uibModal', 'users', 'authentication', 'errorHandler',
  ($scope, $routeParams, $location, $uibModal, users, authentication, errorHandler)->
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
        (
          (user)=>
            $scope.users.push(user)
            @first_name = null
            @last_name = null
            @role = null
            @email = null
            @hours_per_day = null
            @password = null
            @password_confirmation = null
        ),
        (error)->
          errorHandler.handle(error)
      )

    $scope.edit = (user)->
      $scope.editingUser = user
      $scope.editedUser = angular.copy(user)

    $scope.cancel = ()->
      $scope.editingUser = null

    $scope.editing = (user)->
      $scope.editingUser == user

    $scope.save = ()->
      users.update(
        null,
        $scope.editedUser,
        (
          (user)->
            $scope.editingUser.first_name = user.first_name
            $scope.editingUser.last_name = user.last_name
            $scope.editingUser.role = user.role
            $scope.editingUser.email = user.email
            $scope.editingUser.hours_per_day = user.hours_per_day
            $scope.editingUser = null
        ),
        (error)->
          errorHandler.handle(error)
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
          (
            ()->
              $scope.users = $scope.users.filter (a)-> a isnt user
          ),
          (error)->
            errorHandler.handle(error)
        )
      )

    $scope.activities = (user)-> $location.path("/users/#{user.id}/activities")

    $scope.currentUser = (user)-> "#{user.id}" == "#{authentication.getSession().user.id}"

    users.get(
      {
        userId: authentication.getSession().user.id
      },
      (
        (user)->
          $scope.admin = user.role == 'admin'
      ),
      (error)->
        errorHandler.handle(error)
    )

    users.query(
      null,
      (
        (results)->
          $scope.users = results
      ),
      (error)->
        errorHandler.handle(error)
    )
])
