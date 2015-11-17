controllers = angular.module('controllers')

controllers.controller('ActivitiesController', ['$scope', '$routeParams', '$location', '$resource', 'activities',
  ($scope, $routeParams, $location, $resource, activities)->
    $scope.search = (date_from, date_to)-> $location.path('/').search({date_from: date_from, date_to: date_to})

    $scope.date_from = $routeParams.date_from
    $scope.date_to = $routeParams.date_to
    activities.query(date_from: $routeParams.date_from, date_to: $routeParams.date_to, (results)-> $scope.activities = results)
])
