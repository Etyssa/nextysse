'use strict'

###*
 # @ngdoc function
 # @name seminaire2014App.controller:ProfileCtrl
 # @description
 # # ProfileCtrl
 # Controller of the seminaire2014App
###
angular.module('seminaire2014App')
  .controller('ProfileCtrl',
    ["$scope", "Profile", "Categories", "Entries", "Users", "leafletData", "$http",
    ($scope, Profile, Categories, Entries, Users, leafletData, $http) ->
      ctrl = this
      $scope.profile = Profile.get()
      $scope.results =  $scope.profile["entries"]

      $scope.search_params = {}
      $scope.visited_results = {}
      $scope.categories = Categories .query()


      $scope.onCategorySelected = ->
        # init the motivation filter
        if $scope.search_params.selected_category?
          $scope.search_params.motivations_selected = angular.copy($scope.search_params.selected_category.motivations)
        else 
          $scope.search_params.motivations_selected = undefined
        # search entries in this category
        ctrl.search()

      $scope.toggleMotivation = (motivation) ->
        for m, i in $scope.search_params.motivations_selected
          if m.alias == motivation.alias
            return $scope.search_params.motivations_selected.splice(i, 1)
        $scope.search_params.motivations_selected.push(motivation)

      $scope.add = -> 
        console.log "ADD !" 
        if $scope.search_params.selected_category?
          category = $scope.search_params.selected_category.alias      
          $scope.search_params.motivations_selected
          console.log  "add in "+category
          ctrl.results = Entries.save({  
              user        : $scope.profile.id,
              title : angular.copy($scope.search_params.title),
              cat: category,
              to_address  : "issy"}, (data) ->
                console.log data 
                Entries.get({entry_id:data.new_entry}, (entry)->  
                  entries = $scope.profile.entries
                  entries.push entry
                  $scope.profile.entries = entries
                  $scope.results = $scope.profile.entries
                )
          )
          

      $scope.remove = ->
        console.log "REMOVE !" 

      $scope.onTitleChange = ->
        $scope.search_params.title = $scope.title 


      $scope.focusOnEntry = (entry) =>
        $scope.visited_results[entry.id] = true
        # retrieve the entry if the given entry is a light version
        if entry.creation_date?
          $scope.entry_selected = entry
        else
          Entries.get({entry_id:entry.id}, (entry)-> $scope.entry_selected = entry)
        $scope.related_user   = Users.get({user_id:entry.creatorNickname})

      $scope.onCategorySelected = ->
        # init the motivation filter
        if $scope.search_params.selected_category?
          $scope.search_params.motivations_selected = angular.copy($scope.search_params.selected_category.motivations)
        else 
          $scope.search_params.motivations_selected = undefined
        # deselect any selected entry
        $scope.entry_selected = undefined
        # search entries in this category
      
    ])
