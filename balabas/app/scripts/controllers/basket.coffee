'use strict'

###*
 # @ngdoc function
 # @name showcaseApp.controller:BasketCtrl
 # @description
 # # BasketCtrl
 # Controller of the showcaseApp
###
angular.module('showcaseApp')
  .controller 'BasketCtrl', ($scope, $rootScope, $http) ->

    $scope.basket = {}

    get_cart = ->
      $http.get('/basket/0')
      .success((data)->
        $rootScope.basket=data
        $scope.basket = $rootScope.basket
      )
      .error((data)->console.log(data))

    get_cart()

    remove_item=(id)->
      $http.delete("/basket/#{id}?all=1")
      .success((data)->
        get_cart()
      )
      .error((data)->console.log(data))

    $scope.remove = (id)-> remove_item(id)

    $scope.update_qty = (id, qty)->
      $http.post("/basket/#{ id }?qty=#{ qty or 1 }")
      .success((data)->
        get_cart()
      )
      .error((data)->console.log(data))

