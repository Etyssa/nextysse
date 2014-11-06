'use strict'

###*
 # @ngdoc function
 # @name seminaire2014App.controller:OverviewCtrl
 # @description
 # # OverviewCtrl
 # Controller of the seminaire2014App
###
angular.module('seminaire2014App')
  .controller('OverviewCtrl', ["$scope", "leafletBoundsHelpers", "Services", ($scope, leafletBoundsHelpers, Services) ->
    
    angular.extend $scope,
      # france borders
      bounds:
        northEast:
          lat: 53.9560855309879
          lng: 18.852539062499996
        southWest:
          lat: 39.63953756436671
          lng: -9.2724609375
      center: { lat: 46.797811548, lng:6.852539062499996, zoom: 5 }
      # defaults:
        # scrollWheelZoom : false
        # crs             : 'Simple'
        # maxZoom         : 2
      # tiles:
      #   url: "http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}"
      markers: {}

    Services.query (data) ->
      $scope.services = data
      markers         = {}
      # iterate over services to create an propulse marker on the map
      for service in data
        if parseInt(service.status) == 2
          markers[service.nickname.replace(/-/g, "")] = {message:service.nickname, lat:service.place.latitude, lng:service.place.longitude}
      angular.extend $scope,
        markers : markers
  ])

# EOF
