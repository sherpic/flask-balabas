'use strict'

###*
 # @ngdoc function
 # @name showcaseApp.controller:LoginCtrl
 # @description
 # # LoginCtrl
 # Controller of the showcaseApp
###
angular.module('showcaseApp')
  .controller 'LoginCtrl', ($rootScope,$scope, $http) ->
    $scope.loginForm = {}

    $scope.Login = ->
      $http({
        method  : 'POST',
        url     : $('#login_form').attr('action'),
        data    : $.param($scope.loginForm),
        headers : { 'Content-Type': 'application/x-www-form-urlencoded' }
      })
      .success( (data)->
        $rootScope.user = data
      )
      .error((data)->
        console.log(data)
      )

    $scope.Logout = ->
      $http.get('/user/logout')
      .success( (data)->
        $rootScope.user = undefined
      )
      .error((data)->
        console.log(data)
      )

