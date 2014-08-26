'use strict'

###*
 # @ngdoc directive
 # @name showcaseApp.directive:init
 # @description
 # # init
###
angular.module('showcaseApp')
  .directive('init', ['$rootScope', '$http', ($rootScope, $http)->
    restrict: 'A'
    link: (scope, element, attrs) ->

      if not $rootScope.basket
        $http.get('/basket/0')
        .success((data)->
          $rootScope.basket=data
          $rootScope.bought = $.map(data.items, (e)-> e.id )
        )

      if not $rootScope.user
        $http.get('/user/data')
        .success((data)->
          $rootScope.user=data
        )
  ])

