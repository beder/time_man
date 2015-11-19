services = angular.module('services')

services.factory('activities', ['$resource',
  ($resource)->
    return $resource(
      '/api/v1/activities/:activityId',
      {
        activityId: "@id"
      },
      {
        update: {
          method: 'PUT'
        }
      }
    )
])
