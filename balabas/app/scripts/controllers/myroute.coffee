'use strict'

###*
 # @ngdoc function
 # @name showcaseApp.controller:MyrouteCtrl
 # @description
 # # MyrouteCtrl
 # Controller of the showcaseApp
###
angular.module('showcaseApp')
  .controller 'MyrouteCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
