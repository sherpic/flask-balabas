'use strict'

describe 'Service: spinner', ->

  # load the service's module
  beforeEach module 'showcaseApp'

  # instantiate service
  spinner = {}
  beforeEach inject (_spinner_) ->
    spinner = _spinner_

  it 'should do something', ->
    expect(!!spinner).toBe true
