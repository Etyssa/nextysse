'use strict'

###*
 # @ngdoc function
 # @name seminaire2014App.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the seminaire2014App
###
angular.module('seminaire2014App')
  .controller('MainCtrl', ["$scope", "Services", "Categories", "Entries", "leafletData", ($scope, Services, Categories, Entries, leafletData) ->
    ctrl = this
    $scope.search_params = {}

    ctrl.search = =>
        if $scope.search_params.selected_category?
            categorie = $scope.search_params.selected_category.alias
        ctrl.results = Entries.query {cat: categorie}, (data) ->
            $scope.results = angular.copy(data)

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

    $scope.category_selected = =>
        $scope.search_params.motivations_selected = angular.copy($scope.search_params.selected_category.motivations)
        @search()

    # loads data and provide them to the scope
    $scope.service    = Services   .get({service_name: "issy"})
    $scope.categories = Categories .query()

    # map
    angular.extend $scope,
      center  : { lat: 48.82268881260476, lng:2.2460174560546875, zoom: 12 }
      markers : {}
    $scope.$watch("results", (new_value, old_value) ->
        # resize
        leafletData.getMap().then (map) -> map.invalidateSize()
        markers = {}
        # update map data
        if new_value?
            for result in new_value
                markers[result.id] = {message:result.smartTitle, lat:result.to_address.latitude, lng:result.to_address.longitude}
            angular.extend $scope,
                markers : markers
    , true)

  ])

# EOF
