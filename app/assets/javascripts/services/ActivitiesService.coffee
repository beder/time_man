services = angular.module('services')

services.factory('activities', ['$resource',
  ($resource)->
    return $resource(
      '/api/v1/users/:userId/activities/:activityId',
      {
        userId: "@userId"
        activityId: "@id"
      },
      {
        update: {
          method: 'PUT'
        }
      }
    )
])
