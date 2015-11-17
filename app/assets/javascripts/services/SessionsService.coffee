services = angular.module('services')

services.factory('sessions', ['$resource',
  ($resource)->
    return $resource('/api/v1/sessions')
])
