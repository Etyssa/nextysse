'use strict'

###*
 # @ngdoc function
 # @name seminaire2014App.controller:columnCtrl
 # @description
 # # ColumnControl
 # Controller of the seminaire2014App
###
angular.module('seminaire2014App', [])
  .controller('ColumnCtrl',
    ["$scope","Services", "Entries", "Categories", "Profile", "Message","Tags"
    ($scope, Services, Entries, Categories, Profile, Message, Tags) ->
      console.log "ColumnCtrl!"
      ctrl = this
      # loads data and provide them to the scope
      $scope.service    =   Services       .get({service_name: "issy"})
      $scope.portrait   =   Profile       .query()
      $scope.messages   =   Message        .query()
      $scope.categories =   Categories     .query()
      $scope.tags       =   Tags           .query()
      $scope.columns = []

      # group by type columns
      ctrl.addColumn = (type, data) =>
        console.log type, data
        $scope.columns.push  { type  : type,  result : data }    

      ctrl.relayout = () =>
        console.log 'relayout'

      ctrl.addColumns "messages", $scope.messages
      ctrl.addColumn "categories", $scope.categories
      ctrl.addColumn "portrait",  $scope.portrait
      ctrl.addColumn "pingpong", $scope.tags

      console.log $scope.columns
  ])