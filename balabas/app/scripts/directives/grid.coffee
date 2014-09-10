'use strict'

###*
 # @ngdoc directive
 # @name showcaseApp.directive:grid
 # @description
 # # grid
###
angular.module('showcaseApp')
  .directive('grid', ['$rootScope',($rootScope)->
    restrict: 'A'
    link: (scope, element, attrs) ->
      s=(q)-> element.find(q)
      #--------------------------------------------------------------------
      scope.titleMenu = [
        ["Buy", (scop)-> alert]
      ]
      
      $(document).on "tbody-repeat-done", ->
        #resize =->
        #  s('td').css 'width', s('tbody').width() / s('thead > tr > th ').length
        #resize()
        #$(document).resize resize
      
      element.bind "DOMSubtreeModified1 DOMNodeInserted DOMNodeRemoved", ->
        if s('tr').length > $rootScope.grid.length - 2
          setTimeout (->$.event.trigger {type: "tbody-repeat-done"}), 100
        
        s('td .edit').off 'keyup'
        s('td .edit').on 'keyup', ->
            $(@).height 0 ;
            $(@).height @scrollHeight;
          
        #rowTrigger = s 'td:nth-child(1)'
        #rowTrigger.off 'mousedown'
        #rowTrigger.on 'mousedown', (ev)->
        #  console.log ev
        #  selectRow(ev, this)
          
        cell = s('td')
        cell.off 'mousedown'
        cell.on 'mousedown', (ev)-> 
          selectCell(ev,this)
        
        cell.on 'dblclick', (ev) -> editCell(ev, this)
        
        s('.edit').off 'mousedown'
        s('.edit').on 'mousedown', (ev)->
          ev.stopPropagation()
            
            
      
      #$(document).on 'resize', ->
      #  s('th').css 'width', s('tbody').width() / s('thead > tr > th ').length
      
      #---------------------------------------
      
      left_pressed = false
      element.mousedown (ev)->
          if ev.which == 1
            ev.preventDefault()
            left_pressed = true
      element.mouseup (ev)->
          if ev.which == 1
            left_pressed = false
            
      element.on 'mousemove', (ev)->
        ev.preventDefault()
        if left_pressed
          el = $(ev.target).closest('td')
          ev.ctrlKey = true
          selectCell(ev,el)
      
      s('.content').on 'click', (ev)->
        ev.stopPropagation()
      
      
      #---------------------------------------
      # selection manipulate
      SetCaretAtEnd = (elem) ->
        len = elem.value.length;
        elem.focus()
        elem.selectionStart = len
        elem.selectionEnd = len
        elem.focus()
          
      editCell = (ev, el)->
        s('.content').removeClass("hidden")
        s('.edit').addClass('hidden')
        
        #$(el).find('.edit').css 'width', '100%'
        $(el).css 'width', $(el).find('.edit').width()+5
        $(el).addClass("selected")
        
        $(el).find('.content').addClass('hidden')
        $(el).find('.edit').removeClass('hidden')
        
        setTimeout (->SetCaretAtEnd( $(el).find('.edit')[0] ) ), 20
        
      selectRow=(ev,el)->
        s('.content').removeClass("hidden")
        s('.edit').addClass('hidden')
        ev.stopPropagation()
        #if !ev.ctrlKey and !ev.shiftKey and ev.button != 2
        deselect()
        if ev.button!=2
          s(".col-selected").removeClass('active col-selected')
          s(".cell-selected").removeClass('active cell-selected')
          $(el).parent().find('td')
            .addClass('active')
            .addClass('row-selected') 
        
      
      head = s 'thead > tr > th'
      
      last_col_index = 0 
      head.each (i,e)->
        e = $ e
        span = Number(e.attr 'colspan')
        
        range = [i+last_col_index-1]
        if span
          last_col_index = i + span
          range = [(last_col_index - span + 1)..last_col_index]
          if !i
            range = [(last_col_index - span)...last_col_index]
          
        e.on 'click', (ev)->
          console.log range
          selectColumn(ev,range)
      
      selectColumn=(ev, range)->
        deselect()
        
        for index in range
          column = s "td:nth-child(#{index+1})"
          s(".row-selected").removeClass('active row-selected')
          s(".cell-selected").removeClass('active cell-selected')
          column.addClass('active').addClass('col-selected')
        
      selectCell=(ev,el)->
        
        if $(el).find('.content').hasClass('hidden')
          return
        
        s('.content').removeClass("hidden")
        s('.edit').addClass('hidden')
        
        if ev.button == 2 and s('td.active').length == 1
          deselect()
        
        down = s('td').not( $(el).parent().prevAll('tr').find('td') )
        
        if scope.lastCell# and ev.button != 2
          active = s('td.active')
          
          moveX = down.index(el)
          moveY = s('tbody tr').index($(el).parent()[0])
          
          right = moveX > scope._moveX
          Xmove = !(moveX == scope._moveX)
          $rootScope.moveX = null if !Xmove
          top = moveY < scope._moveY
          Ymove = !(moveY == scope._moveY)
          $rootScope.moveY = null if !Ymove
          
          
          if right and Xmove
            console.log "Move to right"
            $rootScope.moveX = 'right'
            X = moveX + 2
            endX = s("thead > tr > th").length
            X = moveX 
            if $(el).hasClass('active')
              console.log [ X..1 ]
              deselectX([ X..1 ])
          
          else if !right and Xmove
            console.log "Move to left"
            $rootScope.moveX = 'left'
            endX = s("thead > tr > th").length
            X = moveX+2 
            if $(el).hasClass('active')
              deselectX([ X..endX ])
            
          
          if top and Ymove
            console.log "Move to top"
            $rootScope.moveY = 'top'
            if $(el).hasClass('active')
              deselect(down.not($(el).parent().find('td')))
          
          else if !top and Ymove
            console.log "Move to bottom"
            $rootScope.moveY = 'bottom'
            if $(el).hasClass('active')
              deselect(s('tbody td').not(down))
        
          
        if !ev.ctrlKey and !ev.shiftKey and ev.button != 2
          deselect()
        
        $(el).addClass('active')# if ev.button != 2
        s(".cell-selected").removeClass('cell-selected')
        getSelection().addClass('active cell-selected selected')
        getSelection().not(el).removeClass('selected')
        
        
        # Use them in the future
        scope.lastCell = el
        scope._moveX = down.index(el)
        scope._moveY = s('tbody tr').index($(el).parent()[0])
        
        
      
      deselectX = (Xrange)->
        if Xrange
          for i in Xrange
            deselect( s("td:nth-child(#{i})") )
      
      deselect = $rootScope.deselect = (sel)-> 
        s(sel or 'td').removeClass('active');
        s(sel or 'td').removeClass("selected")
        s('td .edit').addClass("hidden")
        s('td .content').removeClass("hidden")
        
        
      getSelection = ->
        rows = s("tbody tr") 
        
        r_first = s('td.active:first').parent().index()
        r_last = s('td.active:last').parent().index()
        
        rows = rows.filter (i)-> i >= r_first
        rows = rows.not(s('td.active:last').parent().nextAll("tr"))
        
        last = 0
        rows.each (i,e)->
          _last = $(@).find('td.active:last').index()
          if _last > last
            last = _last
        
        indexes = []
        rows.each (i,e)->
          index = $(@).find('td.active').index() 
          if index!=-1
            indexes.push index
        indexes.sort()
        first = indexes[0]
        
        cells = rows.find('td')
        rows.each (i,e)->
          td1 = $(e).find('td').filter( (i)-> i > last)
          td2 = $(e).find('td').filter( (i)-> i < first)
          cells = cells.not(td1).not(td2)
        #console.log cells
        
        return cells
        
      #---------------------------------------
      # copy-paste
      uniq=$rootScope.uniq=(array)->
        n = []
        for i in array
          if i not in n
            n.push(i)
        return n.sort()
      
      getData=(el)->
        x = Number( $(el).attr('x') )
        y = Number( $(el).attr('y') )
        return {"x":x, "y":y}
        
      copyCells = $rootScope.copyCells = ->
        
        $rootScope.grid_buffer = []
        cells = s('.active')
        
        $.each cells, (i,e)->
          x = Number( $(e).attr('x') )
          y = Number( $(e).attr('y') )
          $rootScope.grid_buffer.push({
            xy:"#{x}:#{y}",
            cell:$rootScope.grid[y][x]
          })
      
      getPasteSel = $rootScope.getPasteSel =->
        buffer =-> $rootScope.grid_buffer
        diff = getData(s('td.selected'))
        rangeX = []
        rangeY = []
        for item in buffer()
          rangeX.push( item.xy.trim().split(':')[0] )
          rangeY.push( item.xy.trim().split(':')[1] )
        
        rangeX = uniq(rangeX)
        rangeY = uniq(rangeY)
        
        #console.log rangeX, rangeY
        
        selection = s('td.selected').add s('td.selected').nextAll("td:lt(#{rangeX.length-1})")
        parentY = selection.parent().add s('td.selected').parent().nextAll("tr:lt(#{rangeY.length-1})")
        
        all = []
        parentY.each (i,e)->
          $(e).find('td').each (id, el) ->
            if id == s('td.selected').index()
              selection = selection.add $(el)
              selection = selection.add $(el).nextAll("td:lt(#{rangeX.length - 1})")
        #console.log selection 
            
        return $(selection)
        
      pasteCells = $rootScope.pasteCells =->
         
        buffer = $rootScope.grid_buffer
        
        if !buffer.length
          return
        
        if buffer.length>1
          paste = getPasteSel()
          paste.each (i,e)->
            value = buffer[i]
            y = Number( $(e).attr('y') )
            x = Number( $(e).attr('x') )
            for k,v of value.cell
                $rootScope.grid[y][x][k] = v   
        else
          targ = getData(s('td.selected'))
          x = targ.x
          y = targ.y
          console.log y
          for k,v of buffer[0].cell
              $rootScope.grid[y][x][k] = v
        
        setTimeout (-> s('.danger').removeClass('danger')), 600
      
      
      #---------------------------------------
      # key map
      keydown_lock = false
      $(window).keydown (ev)->
        if keydown_lock
          return
        keydown_lock = true
        setTimeout (->keydown_lock = false), 80
        
        cell = s('td.active').first()
        cell = cell[0] and cell or s('tbody td:first')
        
        row = cell.closest('tr')
        row = row[0] and row or s('tbody tr:first')
        
        key = ev.keyCode
        
        keys = {
          enter: 13,
          bksp:8,
          alt: 18,
          altr: 17,
          tab:9,
          
          up: 38,
          down: 40,
          left: 37,
          right: 39,
          
          esc: 27,
          del: 46,
          
          f1: 112,
          f2: 113,
          
          c:68,
          v:86,
          x:88,
          y:89,
          z:90
          
        }
        
        #----------------------------------
        if key == keys.enter
          if !cell.find('.content').hasClass('hidden')
            editCell(ev,cell)
        
        #----------------------------------
        #Navigation
        setActive=(next)->      
          if cell.find('.content').hasClass('hidden')
            selectCell(ev, next)
            next.trigger('dblclick')
          else
            selectCell(ev, next)  
          next.focus()
        
        #->right
        if key == keys.right
          key = keys.tab
        if key == keys.tab
          next = cell.next('td')
          if next.index() == -1
            row = row.next('tr')
            next = row.find('td:first')
            if row.index() == -1
              next = s('td').first() 
          
          setActive(next)
          return
        
        #<-left
        if key == keys.left
          prev = cell.prev('td')
          if prev.index() == -1
            row = row.prev('tr')
            prev = row.find('td:last')
            if row.index() == -1
              prev = s('td').last() 
          setActive(prev)
          return
        
        #^ up
        if key == keys.up
          row = row.prev('tr')
          if row.index() == -1
            row = s('tbody tr').last()
          prev = $ row.find('td')[ cell.index() ]
          setActive(prev)
          return
        
        #_ down
        if key == keys.down
          row = row.next('tr')
          if row.index() == -1
            row = s('tbody tr').first()
          next = $ row.find('td')[ cell.index() ]
          setActive(next)
          return
        
           
          
        
        
      
          
          
      
      
      
          
  ])
