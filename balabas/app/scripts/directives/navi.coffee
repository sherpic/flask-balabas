'use strict'

###*
 # @ngdoc directive
 # @name showcaseApp.directive:navi
 # @description
 # # navi
###
angular.module('showcaseApp')
  .directive('navi', ['$location',($location)->
    restrict: 'A'
    link: (scope, element, attrs) ->

      a = element.find('li > a')
      li = element.find('li')

      scope.$on '$locationChangeSuccess', ->
        li.removeClass 'active'
        path = $location.path()

        if path != '/'
          link = a.filter -> $(@).attr('href').indexOf(path) != -1
        else
          link = a.filter -> $(@).attr('href') == '#'

        link.parent().addClass 'active'
  ])

