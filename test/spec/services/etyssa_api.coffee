'use strict'

describe 'Service: etyssa api', ->

  # load the service's module
  beforeEach module 'seminaire2014App'

  # instantiate service
  etyssaapi = {}
  beforeEach inject (_etyssaapi_) ->
    etyssaapi = _etyssaapi_

  it 'should do something', ->
    expect(!!etyssaapi).toBe true
