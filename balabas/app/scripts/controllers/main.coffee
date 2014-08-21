'use strict'

###*
 # @ngdoc function
 # @name showcaseApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the showcaseApp
###
angular.module('showcaseApp')
  .controller 'MainCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
