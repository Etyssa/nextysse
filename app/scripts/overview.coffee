'use strict'

###*
 # @ngdoc function
 # @name seminaire2014App.controller:OverviewCtrl
 # @description
 # # OverviewCtrl
 # Controller of the seminaire2014App
###
angular.module('seminaire2014App')
  .controller('OverviewCtrl', 
    ["$scope", "Services", "leafletData", "$timeout" ,
    ($scope, Services, leafletData, $timeout) ->
      angular.extend $scope,
        tiles:
          url: "https://stamen-tiles-{s}.a.ssl.fastly.net/watercolor/{z}/{x}/{y}.png"
        markers: {}

      Services.query (services) ->
        $scope.services = services
        markers         = {}
        # iterate over services to create an propulse marker on the map
        for service in services
          if parseInt(service.status) == 2
            markers[service.city.replace(/-/g, "")] = {message:service.city, lat:service.address.latitude, lng:service.address.longitude}
            # Could be better to dispaly the city name
            # markers[service.place.city.replace(/-/g, "")] = {message:service.place.city, lat:service.place.latitude, lng:service.place.longitude}
        angular.extend $scope,
          markers : markers
        # when markers are ready
        $timeout(->
          leafletData.getMap().then (map) ->
            leafletData.getMarkers().then (markers) ->
              if _.size(markers) > 0
                groups = new L.featureGroup(_.values(markers))
                map.fitBounds(groups)
        )
    ])

# EOF
