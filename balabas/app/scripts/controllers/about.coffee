'use strict'

###*
 # @ngdoc function
 # @name showcaseApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the showcaseApp
###
angular.module('showcaseApp')
  .controller 'AboutCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
