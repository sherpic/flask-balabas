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
      #$(".spinner").show();
      data;

    $httpProvider.defaults.transformRequest.push(spinnerFunction);
  )
  .factory 'spinner', ($q, $window,$rootScope)->
    $rootScope.messages=[]
    getMessages =->
      $.get('flashes', (data)->
        $rootScope.messages = $rootScope.messages.concat( data.messages )
        $rootScope.messages = $.unique $rootScope.messages
      )

    getBought =->
      if $rootScope.basket
        $rootScope.bought = $.map($rootScope.basket.items, (e)-> e.id )

    return (promise) ->
      promise.then(
        (response)->
          $(".spinner").hide();
          getMessages();
          getBought();
          response;
        ,
        (response) ->
          $(".spinner").hide();
          getMessages();
          getBought();
          $q.reject(response);
      )

