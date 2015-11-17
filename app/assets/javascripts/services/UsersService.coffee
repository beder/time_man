services = angular.module('services')

services.factory('users', ['$resource',
  ($resource)->
    return $resource('/api/v1/users/:userId', { userId: "@id" })
])
