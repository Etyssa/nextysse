'use strict'

###*
 # @ngdoc function
 # @name seminaire2014App.controller:OverviewCtrl
 # @description
 # # OverviewCtrl
 # Controller of the seminaire2014App
###
angular.module('seminaire2014App')
  .controller('OverviewCtrl', ["$scope", "Services", ($scope, Services) ->
    $scope.services = Services.index()
  ])
