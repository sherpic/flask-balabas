'use strict'

describe 'Service: Basket', ->

  # load the service's module
  beforeEach module 'showcaseApp'

  # instantiate service
  Basket = {}
  beforeEach inject (_Basket_) ->
    Basket = _Basket_

  it 'should do something', ->
    expect(!!Basket).toBe true
