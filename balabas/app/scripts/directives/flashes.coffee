'use strict'

###*
 # @ngdoc directive
 # @name showcaseApp.directive:flashes
 # @description
 # # flashes
###
angular.module('showcaseApp')
  .directive('flashes',['$rootScope', ($rootScope)->
    templateUrl : '/views/flashes.html',
    restrict: 'E'
    link: (scope, element, attrs) ->

      scope.close_me = (index) ->
        $rootScope.messages.splice(index, 1)
        $("#flash-#{ index }").fadeOut()

      setInterval (->

        len = $rootScope.messages.length
        if len
          scope.close_me len-1

      ),1000


  ])

