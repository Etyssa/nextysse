'use strict'

###*
 # @ngdoc function
 # @name seminaire2014App.controller:SearchCtrl
 # @description
 # # SearchCtrl
 # Controller of the seminaire2014App
###
angular.module('seminaire2014App')
  .controller('SearchCtrl',
    ["$scope", "Services", "Categories", "Entries", "Users", "leafletData",
    ($scope, Services, Categories, Entries, Users, leafletData) ->
      ctrl = this
      $scope.search_params = {}
      $scope.visited_results = {}

      ctrl.search = =>
        if $scope.search_params.selected_category?
          categorie = $scope.search_params.selected_category.alias
        ctrl.results = Entries.query {cat: categorie, to_address:"issy", limit:200, map_optimized:yes}, (data) ->
          $scope.results = angular.copy(data)

      # loads data and provide them to the scope
      $scope.service    = Services   .get({service_name: "issy"})
      $scope.categories = Categories .query()
      # init results with 200 first
      ctrl.search()

      $scope.isMotivationSelected = (motivation) ->
        _.some($scope.search_params.motivations_selected, (item) -> item.alias == motivation.alias)

      $scope.toggleMotivation = (motivation) ->
        for m, i in $scope.search_params.motivations_selected
          if m.alias == motivation.alias
            return $scope.search_params.motivations_selected.splice(i, 1)
        $scope.search_params.motivations_selected.push(motivation)

      $scope.toggleAllFilter = ->
        if $scope.search_params.motivations_selected.length == $scope.search_params.selected_category.motivations.length
          $scope.search_params.motivations_selected = []
        else
          $scope.search_params.motivations_selected = angular.copy($scope.search_params.selected_category.motivations)

      $scope.focusOnEntry = (entry) =>
        leafletData.getMarkers().then (markers) ->
          marker = markers[entry.id]
          marker.openPopup()
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
        # search entries in this category
        ctrl.search()

      # watch motivations selected and filter the results list
      $scope.$watch("search_params.motivations_selected", (new_value, old_value) ->
        if new_value? and ctrl.results?
          res = angular.copy(ctrl.results)
          res = res.filter (item) ->
            if item.motivations?
              motivations_required = angular.copy($scope.search_params.motivations_selected)
              for motivation_required in motivations_required
                for motivation in item.motivations
                  if parseInt(motivation_required.id) == motivation.id
                    return yes
          $scope.results = res
      , true)

      # map
      angular.extend $scope,
        tiles:
          url: "https://stamen-tiles-{s}.a.ssl.fastly.net/toner/{z}/{x}/{y}.png"
        defaults:
          scrollWheelZoom : false
        markers : {}
      $scope.$watch("results", (new_value, old_value) ->
          markers = {}
          # update map data
          if new_value?
            for result in new_value
              markers[result.id] = {message:result.smart_title, lat:result.to_address.latitude, lng:result.to_address.longitude}
            angular.extend $scope,
              markers : markers
      , true)

      # on marker click
      $scope.$on 'leafletDirectiveMarker.click', (e, args) ->
        entity_id = parseInt(args.markerName)
        $scope.focusOnEntry(_.find($scope.results, (i)-> i.id == entity_id))
  ])

# EOF
