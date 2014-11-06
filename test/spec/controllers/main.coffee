'use strict'

describe 'Controller: MainCtrl', ->

  # load the controller's module
  beforeEach module 'seminaire2014App'

  MainCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    MainCtrl = $controller 'MainCtrl', {
      $scope: scope
    }

  it 'should attach a list of categories to the scope', ->
    expect(scope.categories.length).toBe 3
