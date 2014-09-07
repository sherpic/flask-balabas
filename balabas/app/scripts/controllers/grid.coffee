'use strict'

###*
 # @ngdoc function
 # @name showcaseApp.controller:GridCtrl
 # @description
 # # GridCtrl
 # Controller of the showcaseApp
###
angular.module('showcaseApp')
  .controller 'GridCtrl', ($scope,$rootScope) ->
    
    #########- Datetime
    $scope.today=->
      $scope.dt = new Date()
    $scope.today()
    
    $scope.clear=->
      $scope.dt = null

    $scope.disabled=(date, mode)->
      ( mode == 'day' and ( date.getDay() == 0 or date.getDay() == 6 ) )

    $scope.toggleMin=->
      if not $scope.minDate
        $scope.minDate = new Date()
    $scope.toggleMin()
    
    $scope.open = ($event)->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.opened = true
    
    $scope.dateOptions = {
      formatYear: 'yy'
      startingDay: 1
    }
    
    $scope.initDate = new Date('2016-15-20');
    $scope.formats = ['dd-MMMM-yyyy', 'yyyy/MM/dd', 'dd.MM.yyyy', 'shortDate'];
    $scope.format = $scope.formats[0];
    
    #########- Rows
    $rootScope.grid= [
      [{title:"title"},{title:"title"},{title:"title"},{title:"title"},{title:"title"},{title:"title"},],
      [{title:"title"},{title:"title"},{title:"title"},{title:"title"},{title:"title"},{title:"title"},],
      [{title:"title"},{title:"title"},{title:"title"},{title:"title"},{title:"title"},{title:"title"},],
      [{title:"title"},{title:"title"},{title:"title"},{title:"title"},{title:"title"},{title:"title"},],
      [{title:"title"},{title:"title"},{title:"title"},{title:"title"},{title:"title"},{title:"title"},],
      [{title:"title"},{title:"title"},{title:"title"},{title:"title"},{title:"title"},{title:"title"},]
    ]
    
    
