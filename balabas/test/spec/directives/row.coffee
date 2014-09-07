'use strict'

describe 'Directive: row', ->

  # load the directive's module
  beforeEach module 'showcaseApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<row></row>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the row directive'
