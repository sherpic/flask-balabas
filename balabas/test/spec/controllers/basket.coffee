'use strict'

describe 'Controller: BasketCtrl', ->

  # load the controller's module
  beforeEach module 'showcaseApp'

  BasketCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    BasketCtrl = $controller 'BasketCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
