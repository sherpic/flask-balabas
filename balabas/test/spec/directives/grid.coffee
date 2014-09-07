'use strict'

describe 'Directive: grid', ->

  # load the directive's module
  beforeEach module 'showcaseApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<grid></grid>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the grid directive'
