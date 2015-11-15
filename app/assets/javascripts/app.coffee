time_man = angular.module('time_man',[
  'templates',
  'ngRoute',
  'ngResource',
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
