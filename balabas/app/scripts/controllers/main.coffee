'use strict'

###*
 # @ngdoc function
 # @name showcaseApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the showcaseApp
###
angular.module('showcaseApp')
  .controller 'MainCtrl', ($scope,$rootScope, $http) ->

    $scope.five = 5
    $scope.four = 4

    if not $rootScope.basket
      $http.get('/basket/0')
      .success((data)->
        $rootScope.basket=data
      )

