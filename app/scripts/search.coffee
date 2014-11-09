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

      ctrl.search = =>
        if $scope.search_params.selected_category?
          categorie = $scope.search_params.selected_category.alias
        ctrl.results = Entries.query {cat: categorie, to_address:"issy", limit:200, map_optimized:yes}, (data) ->
          $scope.results = angular.copy(data)

      # loads data and provide them to the scope
      $scope.service    = Services   .get({service_name: "issy"})
      $scope.categories = Categories .query()
      # init results with 200 first
      $scope.results    = Entries    .query({limit:200, map_optimized:yes, to_address:"issy"})

      $scope.focusOnEntry = (entry) =>
        leafletData.getMarkers().then (markers) ->
          marker = markers[entry.id]
          marker.openPopup()
          # retrieve the entry if the given entry is a light version
          $scope.entry_selected = if entry.creation_date? then entry else Entries.get({entry_id:entry.id})
          # $scope.related_user    = Users.get({user_id:entry.creatorUrl.split("/").pop()})


      $scope.category_selected = ->
        if $scope.search_params.selected_category?
          $scope.search_params.motivations_selected = angular.copy($scope.search_params.selected_category.motivations)
        else 
          $scope.search_params.motivations_selected = undefined
        ctrl.search()

      # watch motivations selected and filter the results list
      $scope.$watch("search_params.motivations_selected", (new_value, old_value) ->
        if new_value? and ctrl.results?
          res = angular.copy(ctrl.results)
          res = res.filter (item) ->
            motivations_required = angular.copy($scope.search_params.motivations_selected)
            for motivation_required in motivations_required
              if parseInt(motivation_required.id) == item.motivation.id
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
              markers[result.id] = {message:result.smartTitle, lat:result.to_address.latitude, lng:result.to_address.longitude}
            angular.extend $scope,
              markers : markers
          # resize
          leafletData.getMap().then (map) ->
            # map.invalidateSize()
            leafletData.getMarkers().then (markers) ->
              if _.size(markers) > 0
                groups = new L.featureGroup(_.values(markers))
                map.fitBounds groups,
                  paddingBottomRight: [900, 0]
      , true)

      # on marker click
      $scope.$on 'leafletDirectiveMarker.click', (e, args) ->
        entity_id = parseInt(args.markerName)
        $scope.focusOnEntry(_.find($scope.results, (i)-> i.id == entity_id))
    ])

# EOF
