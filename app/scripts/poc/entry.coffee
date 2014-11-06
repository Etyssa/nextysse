'use strict'

###*
 # @ngdoc function
 # @name seminaire2014App.controller:EntryCtrl
 # @description
 # # EntryCtrl
 # Controller of the seminaire2014App
###
angular.module('seminaire2014App')
  .controller('EntryCtrl', ["$scope", "$route", "Entry", "User", ($scope, $route, Entry, User) ->
    # loads data and provide them to the scope
    $scope.entry = Entry.query({entry_id:$route.current.params.id})
    Entry.query {entry_id:$route.current.params.id}, (entry) ->
        user_id      = entry.creatorUrl.split("/").pop()
        $scope.entry = entry
        $scope.user  = User.query({user_id: user_id})
  ])