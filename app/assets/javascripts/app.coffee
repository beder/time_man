time_man = angular.module('time_man',[
  'templates',
  'ngRoute',
  'controllers'
])

time_man.config(['$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: 'index.html',
        controller: 'ActivitiesController'
      )
])

activities = [
  {
    id: 1
    name: 'User registration and authentication'
    date: new Date('2015-01-02')
    hours: 12
  },
  {
    id: 2
    name: 'Activity management'
    date: new Date('2015-03-04')
    hours: 12
  },
  {
    id: 3
    name: 'User settings'
    date: new Date('2015-05-06')
    hours: 12
  },
  {
    id: 4
    name: 'Highlighting of under performance'
    date: new Date('2015-07-08')
    hours: 12
  },
  {
    id: 5
    name: 'Roles'
    date: new Date('2015-09-10')
    hours: 12
  }
]

controllers = angular.module('controllers', [])
controllers.controller('ActivitiesController', ['$scope', '$routeParams', '$location'
  ($scope, $routeParams, $location)->
    $scope.search = (date_from, date_to)-> $location.path('/').search({date_from: date_from, date_to: date_to})

    DAY = 1000 * 60 * 60 * 24
    $scope.date_from = $routeParams.date_from
    $scope.date_to = $routeParams.date_to
    results = activities
    results = results.filter (activity)-> !$scope.date_from || (Math.round((activity.date.getTime() - (new Date($scope.date_from)).getTime())) / DAY) >= 0
    results = results.filter (activity)-> !$scope.date_to || (Math.round((activity.date.getTime() - (new Date($scope.date_to)).getTime())) / DAY) <= 0
    $scope.activities = results
])
