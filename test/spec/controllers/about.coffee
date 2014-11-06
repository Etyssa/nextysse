'use strict'

describe 'Controller: AboutCtrl', ->

  # load the controller's module
  beforeEach module 'seminaire2014App'

  AboutCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    AboutCtrl = $controller 'AboutCtrl', {
      $scope: scope
    }
