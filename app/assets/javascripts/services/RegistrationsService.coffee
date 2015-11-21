services = angular.module('services')

services.factory('registrations', ['$resource',
  ($resource)->
    return $resource('/api/v1/registrations')
])
