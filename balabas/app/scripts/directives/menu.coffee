'use strict'

###*
 # @ngdoc directive
 # @name showcaseApp.directive:menu
 # @description
 # # menu
###
angular.module('showcaseApp')
  .directive('contextMenu',['$parse', '$rootScope', ($parse, $rootScope) ->
    renderContextMenu = ($scope, event, options)->
      $ = (not $) and angular.element or $  
      $(event.currentTarget).addClass('context')
      $contextMenu = $('<div>')
      $contextMenu.addClass('dropdown clearfix')  
      
      $ul = $('<ul>')
      $ul.addClass('dropdown-menu')
      $ul.attr({ 'role': 'menu' })
      $ul.css({
        display: 'block',
        position: 'absolute',
        left: event.pageX + 'px',
        top: event.pageY + 'px'
      })
      
      angular.forEach options, (item, i) ->
        
        $li = $('<li>')
        
        if not item
          $li.addClass('divider');  
        else
          $a = $('<a>');
          $a.attr({ tabindex: '-1'});
          $a.text(item[0]);
          $li.append($a);
          
          $a.on 'mouseenter', ->
            if item[0].toLowerCase() == 'paste'
              if $rootScope.getPasteSel and $rootScope.grid_buffer
                $rootScope.getPasteSel().addClass('danger')
          $a.on 'mouseleave', ->
            if item[0].toLowerCase() == 'paste'
              if $rootScope.getPasteSel and $rootScope.grid_buffer
                $rootScope.getPasteSel().removeClass('danger')
                    
          $li.on 'click', ->
            $scope.$apply -> item[1].call($scope, $scope);
          
          $ul.append($li);
       
      $contextMenu.append($ul)
          
      $contextMenu.css({
        width: '100%',
        height: '100%',
        position: 'absolute',
        top: 0,
        left: 0,
        zIndex: 9999
      })
        
      $(document).find('body').append($contextMenu);
        
      $contextMenu.on("click", (e)->
        $(event.currentTarget).removeClass('context');
        $contextMenu.remove();
      ).on('contextmenu', (event)->
        $(event.currentTarget).removeClass('context');
        event.preventDefault();
        $contextMenu.remove();
      );
        
    return ($scope, element, attrs) ->
        element.on 'contextmenu', (event) ->
            event.stopPropagation()
            
            $scope.$apply( -> 
                event.preventDefault();
                options = $scope.$eval(attrs.contextMenu);
                if (options instanceof Array)
                  renderContextMenu($scope, event, options);
            )
  ])
