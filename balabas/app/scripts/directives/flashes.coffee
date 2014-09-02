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

      scope.closeFlash= (index) ->
        $rootScope.messages.splice(index, 1)
        $("#flash-#{ index }").slideUp()


      setInterval (->

        len = $rootScope.messages.length
        if len
          scope.closeFlash len-1

      ),1000


  ])

