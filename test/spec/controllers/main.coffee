'use strict'

describe 'Controller: SearchCtrl', ->

  # load the controller's module
  beforeEach module 'seminaire2014App'

  SearchCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    SearchCtrl = $controller 'SearchCtrl', {
      $scope: scope
    }

  it 'should attach a list of categories to the scope', ->
    expect(scope.categories.length).toBe 3
