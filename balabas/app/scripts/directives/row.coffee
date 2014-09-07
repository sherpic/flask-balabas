'use strict'

###*
 # @ngdoc directive
 # @name showcaseApp.directive:row
 # @description
 # # row
###
angular.module('showcaseApp')
  .directive('row',['$rootScope', ($rootScope)->
    #templateUrl: 'views/row.html'
    restrict: 'A'
    
    link: (scope, element, attrs) ->
      scope.y = -> $(element).data('order')
      element.bind "DOMSubtreeModified1 DOMNodeInserted", ->
        if element.find('td').length == $("table[grid] th").length
          setTimeout (->$.event.trigger {type: "row-repeat-done"}), 100
          
        
      scope.cellMenu = [
        ["Copy", -> 
          $rootScope.copyCells()
          $rootScope.deselect()
        ],
        ["Paste",-> 
          $rootScope.pasteCells()
        ],
        
      ]
  ])
