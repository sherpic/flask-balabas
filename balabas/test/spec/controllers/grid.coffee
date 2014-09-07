'use strict'

describe 'Controller: GridCtrl', ->

  # load the controller's module
  beforeEach module 'showcaseApp'

  GridCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    GridCtrl = $controller 'GridCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
