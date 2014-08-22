'use strict'

###*
 # @ngdoc directive
 # @name showcaseApp.directive:flashes
 # @description
 # # flashes
###
angular.module('showcaseApp')
  .directive('flashes',['$interval', '$http', '$compile', ($interval,$http,$compile)->
    templateUrl : '/views/flashes.html',
    restrict: 'E'
    link: (scope, element, attrs) ->

      scope.messages = []

      scope.closeme = (message) ->
        index=scope.messages.indexOf(message)
        scope.messages.splice(index, 1)

      getMessages = ->
        $http.get('flashes')
          .success( (data)->
            scope.messages = scope.messages.concat( data.messages )
          )
          .error( (data)-> console.log(data) )

      inteval = $interval(getMessages, 5000)



  ])

