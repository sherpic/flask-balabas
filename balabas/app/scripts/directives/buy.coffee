'use strict'

###*
 # @ngdoc directive
 # @name showcaseApp.directive:buy
 # @description
 # # buy
###
angular.module('showcaseApp')
  .directive('buy', ['$rootScope','$http',($rootScope,$http)->
    restrict: 'A'
    scope:
      product: '@product'
      qty:'@qty'
    link: (scope, element, attrs) ->


      element.on 'click', ->
        $http.post("/basket/#{ scope.product }?qty=#{ scope.qty or 1 }")
        .success((data)->
          $http.get('/basket/0')
          .success((data)->
            $rootScope.basket=data
            $rootScope.bought = $.map(data.items, (e)-> e.id )
          )
        )
        .error((data)->console.log(data))


  ])

