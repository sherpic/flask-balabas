'use strict'

###*
 # @ngdoc directive
 # @name showcaseApp.directive:buy
 # @description
 # # buy
###
angular.module('showcaseApp')
  .directive('buy', ['$rootScope','$http','glob',($rootScope,$http, glob)->
    restrict: 'E'
    templateUrl:'views/buy.html'
    scope:
      product: '@product'
      qty:'@qty'
      yet:'@in'
    link: (scope, element, attrs) ->
      
      scope.buy = (qty)->
        
        $http.post("/basket/#{ scope.product }?qty=#{ qty or scope.qty or 1 }")
          .success((data)-> glob.getCart())
          .error((data)->console.log(data))
      
      scope.remove = ->
        $http.delete("/basket/#{ scope.product }?all=1")
          .success((data)-> glob.getCart() )
          .error((data)->console.log(data) )
      

  ])

