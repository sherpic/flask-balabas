'use strict'

###*
 # @ngdoc service
 # @name showcaseApp.spinner
 # @description
 # # spinner
 # Factory in the showcaseApp.
###



angular.module('showcaseApp')
  .config(($httpProvider) ->
    $httpProvider.responseInterceptors.push('spinner');

    spinnerFunction = (data, headersGetter)->
      return data;

    $httpProvider.defaults.transformRequest.push(spinnerFunction);
  )
  .factory 'spinner', ($q, $window,$rootScope)->
    $rootScope.messages=[]
    getMessages = ->
      $.get('flashes', (data)->
        $rootScope.messages = $rootScope.messages.concat( data.messages )
      )

    return (promise) ->
      promise.then(
        (response)->
          getMessages();
          response;
        ,
        (response) ->
          getMessages();
          $q.reject(response);
      )

