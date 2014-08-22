'use strict'

describe 'Controller: MyrouteCtrl', ->

  # load the controller's module
  beforeEach module 'showcaseApp'

  MyrouteCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    MyrouteCtrl = $controller 'MyrouteCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
