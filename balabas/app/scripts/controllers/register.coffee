'use strict'

###*
 # @ngdoc function
 # @name showcaseApp.controller:RegisterCtrl
 # @description
 # # RegisterCtrl
 # Controller of the showcaseApp
###
angular.module('showcaseApp')
  .controller 'RegisterCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
