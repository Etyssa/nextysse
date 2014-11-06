'use strict'

###*
 # @ngdoc function
 # @name seminaire2014App.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the seminaire2014App
###
angular.module('seminaire2014App')
  .controller('MainCtrl', ["$scope", "Services", "Categories", "Search", ($scope, Services, Categories, Search) ->

    $scope.search = (selected_category) ->
      $scope.results = Search.query {cat: selected_category}

    # loads data and provide them to the scope
    # Categories.query (data) -> $scope.categories = data
    # Services  .query (data) -> $scope.service    = data
    $scope.categories = Categories .query()
    $scope.service    = Services   .query()
  ])