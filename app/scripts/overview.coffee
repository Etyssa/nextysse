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
          url: "http://c.tile.stamen.com/watercolor/{z}/{x}/{y}.jpg"
        markers: {}

      Services.query (services) ->
        $scope.services = services
        markers         = {}
        # iterate over services to create an propulse marker on the map
        for service in services
          if parseInt(service.status) == 2
            markers[service.nickname.replace(/-/g, "")] = {message:service.nickname, lat:service.place.latitude, lng:service.place.longitude}
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
