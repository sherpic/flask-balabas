'use strict'

###*
 # @ngdoc directive
 # @name showcaseApp.directive:init
 # @description
 # # init
###
angular.module('showcaseApp')
  .directive('init', ['$rootScope', '$http', 'glob', ($rootScope, $http, glob)->
    restrict: 'A'
    link: (scope, element, attrs) ->
      
      #----------------------------------------------------
      for method in ['post', 'put', 'common']
        $http.defaults.headers[method]["X-CSRFToken"]=attrs.token

      $.ajaxSetup {
          beforeSend: (xhr, settings) ->
            if !/^(GET|HEAD|OPTIONS|TRACE)$/i.test(settings.type)
              xhr.setRequestHeader("X-CSRFToken", attrs.token)
        }
      
      #----------------------------------------------------
      if not $rootScope.basket
        glob.getCart();

      if not $rootScope.user
        glob.getUser();
        
      $rootScope.getProduct = glob.getProduct



  ])

