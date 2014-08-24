'use strict'

###*
 # @ngdoc directive
 # @name showcaseApp.directive:spinner
 # @description
 # # spinner
###
angular.module('showcaseApp')
  .directive('spinner', ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      element.hide()
      max = $(document).width()
      delta = 12
      right = false
      setInterval (->
        if element.is ':visible'
          left = element.position().left
          if not right
            element.css 'left', left + delta
            if (left+delta) >= (max-delta-element.width())
              right =true
          else
            element.css 'left', left - delta
            if (left-delta) <= delta
              right = false

      ), 1
  )

