'use strict'

describe 'Service: glob', ->

  # load the service's module
  beforeEach module 'showcaseApp'

  # instantiate service
  glob = {}
  beforeEach inject (_glob_) ->
    glob = _glob_

  it 'should do something', ->
    expect(!!glob).toBe true
