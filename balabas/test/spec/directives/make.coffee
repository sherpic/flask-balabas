'use strict'

describe 'Directive: make', ->

  # load the directive's module
  beforeEach module 'showcaseApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<make></make>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the make directive'
