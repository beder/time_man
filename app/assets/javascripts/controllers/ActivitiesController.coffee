controllers = angular.module('controllers')

controllers.controller('ActivitiesController', ['$scope', '$routeParams', '$location', '$uibModal', 'activities', 'authentication', 'users',
  ($scope, $routeParams, $location, $uibModal, activities, authentication, users)->
    $scope.search = (date_from, date_to)-> $location.path('/').search({date_from: date_from, date_to: date_to})

    $scope.add = (name, date, hours)->
      activities.save(
        null,
        {
          activity: {
            name: name,
            date: date,
            hours: hours
          }
        },
        (activity)=>
          $scope.activities.push(activity)
          @.name = null
          @.date = null
          @.hours = null
      )

    $scope.edit = (activity)->
      $scope.editingActivity = activity
      $scope.editedActivity = angular.copy(activity)

    $scope.cancel = ()->
      $scope.editingActivity = null

    $scope.editing = (activity)->
      $scope.editingActivity == activity

    $scope.save = ()->
      $scope.editingActivity.name = $scope.editedActivity.name
      $scope.editingActivity.date = $scope.editedActivity.date
      $scope.editingActivity.hours = $scope.editedActivity.hours
      activities.update(
        null,
        $scope.editingActivity,
        ()->
          $scope.editingActivity = null
      )

    $scope.delete = (activity)->
      modalInstance = $uibModal.open({
        animation: true,
        templateUrl: 'modals/deletion_confirmation.html',
        controller: 'DeletionConfirmationController',
        resolve: {
          name: ()->
            activity.name
          objectType: ()->
            'activity'
        }
      })
      modalInstance.result.then(()->
        activities.delete(
          null,
          activity,
          ()->
            $scope.activities = $scope.activities.filter (a)-> a isnt activity
        )
      )

    $scope.fulfillmentClass = (activity)->
      hoursPerDay = $scope.activities
        .filter (a)-> a.date == activity.date
        .reduce ((sum, a)-> sum + a.hours) , 0

      if hoursPerDay >= $scope.hoursPerDay then 'panel-success' else 'panel-danger'

    $scope.date_from = $routeParams.date_from

    $scope.date_to = $routeParams.date_to

    users.get(
      {
        userId: authentication.getSession().user.id
      },
      (user)->
        $scope.hoursPerDay = user.hours_per_day
    )

    activities.query(date_from: $routeParams.date_from, date_to: $routeParams.date_to, (results)-> $scope.activities = results)
])
