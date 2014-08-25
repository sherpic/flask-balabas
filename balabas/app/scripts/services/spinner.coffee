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
      $("div[spinner]").show();
      data;

    $httpProvider.defaults.transformRequest.push(spinnerFunction);
  )
  .factory 'spinner', ($q, $window,$rootScope)->
    $rootScope.messages=[]
    getMessages = ->
      $.get('flashes', (data)->
        $rootScope.messages = $rootScope.messages.concat( data.messages )
        $rootScope.messages = $.unique $rootScope.messages
      )

    return (promise) ->
      promise.then(
        (response)->
          $("div[spinner]").hide();
          getMessages();
          response;
        ,
        (response) ->
          $("div[spinner]").hide();
          getMessages();
          $q.reject(response);
      )

