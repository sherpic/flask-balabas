'use strict'

###*
 # @ngdoc directive
 # @name showcaseApp.directive:anav
 # @description
 # # anav
###
angular.module('showcaseApp')
  .directive('anav', ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      a = element.find('li > a')
      li = element.find('li')
      a.on 'click', ->
        li.removeClass 'active'
        $(@).parent().addClass 'active'
  )

