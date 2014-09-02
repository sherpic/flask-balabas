'use strict'

###*
 # @ngdoc service
 # @name showcaseApp.glob
 # @description
 # # glob
 # Factory in the showcaseApp.
###
angular.module('showcaseApp')
  .factory 'glob', ($http, $rootScope)->
    
    {
      getCart: ->
        $http.get('/basket/0')
        .success((data)=>
            $rootScope.basket=data
            @getBought()
        )
        .error((data)->console.log(data))
      
      getBought:->
        if $rootScope.basket
          $rootScope.bought = $.map($rootScope.basket.items, (e)-> e.id )
      
      getUser: ->
        $http.get('/user/data').success((data)->
          $rootScope.user=data
        ).error((data)->console.log(data))
      
      getProduct:(id)-> 
        
        if $rootScope.basket
          for i in $rootScope.basket.items
            if i.id == id
              return i
          return {}
    }
