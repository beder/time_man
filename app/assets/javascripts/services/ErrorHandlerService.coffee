services = angular.module('services')

services.factory('errorHandler', ['Flash'
  (Flash)->
    {
      handle: (error)->
        if error.data? and error.data.messages?
          Flash.create('danger', message) for message in error.data.messages
        else
          Flash.create('danger', error.statusText)
    }
])
