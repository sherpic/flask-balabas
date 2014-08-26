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

      for method in ['post', 'put', 'common']
        $http.defaults.headers[method]["X-CSRFToken"]=attrs.token

      $.ajaxSetup {
          beforeSend: (xhr, settings) ->
            if !/^(GET|HEAD|OPTIONS|TRACE)$/i.test(settings.type)
              xhr.setRequestHeader("X-CSRFToken", attrs.token)
        }

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

