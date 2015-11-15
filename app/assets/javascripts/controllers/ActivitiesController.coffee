controllers = angular.module('controllers')

controllers.controller('ActivitiesController', ['$scope', '$routeParams', '$location', '$resource'
  ($scope, $routeParams, $location, $resource)->
    $scope.search = (date_from, date_to)-> $location.path('/').search({date_from: date_from, date_to: date_to})
    Activity = $resource('/api/v1/activities/:activityId', { activityId: "@id" })

    $scope.date_from = $routeParams.date_from
    $scope.date_to = $routeParams.date_to
    Activity.query(date_from: $routeParams.date_from, date_to: $routeParams.date_to, (results)-> $scope.activities = results)
])
