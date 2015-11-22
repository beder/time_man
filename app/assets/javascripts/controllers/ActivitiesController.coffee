controllers = angular.module('controllers')

controllers.controller('ActivitiesController', ['$scope', '$routeParams', '$location', '$uibModal', 'FileSaver', 'Blob', 'activities', 'authentication', 'users', 'report',
  ($scope, $routeParams, $location, $uibModal, FileSaver, Blob, activities, authentication, users, report)->
    $scope.search = (date_from, date_to)-> $location.path($location.path()).search({date_from: date_from, date_to: date_to})

    $scope.add = (name, date, hours)->
      activities.save(
        {
          userId: $scope.userId
        },
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
        {
          userId: $scope.userId
        },
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
          {
            userId: $scope.userId
          },
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

    $scope.download = ->
      blob = new Blob(
        [
          report.build($scope.userName, $scope.date_from, $scope.date_to, $scope.activities)
        ],
        {
          type: 'text/html'
        }
      )
      FileSaver.saveAs(blob, 'activity_report.html')

    $scope.userId = $routeParams.userId || authentication.getSession().user.id

    $scope.date_from = $routeParams.date_from

    $scope.date_to = $routeParams.date_to

    users.get(
      {
        userId: $scope.userId
      },
      (user)->
        currentUser = "#{$scope.userId}" == "#{authentication.getSession().user.id}"
        $scope.userName = "#{user.first_name} #{user.last_name}"
        $scope.hoursPerDay = user.hours_per_day
        $scope.title = if currentUser then 'Activities' else "#{$scope.userName}'s activities"
    )

    activities.query(
      {
        userId: $scope.userId,
        date_from: $routeParams.date_from,
        date_to: $routeParams.date_to
      },
      (results)->
        $scope.activities = results
    )
])
