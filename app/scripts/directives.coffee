angular.module('seminaire2014App.directives', [])
  .directive "scrollIf", ->
      restrict: 'A'
      scope:
        scrollIf: '=scrollIf'
      link : (scope, element, attrs) ->
        scope.$watch "scrollIf", ->
          if scope.scrollIf
            $("html").animate({scrollTop: element[0].offsetTop - 100}, "slow")

  .directive "addClassWhenOverViewport", ($window) ->
      restrict: 'A'
      link : (scope, element, attrs) ->
        window_element = angular.element($window)
        offset_limit = element.offset().top + element.height()
        window_element.on 'scroll', ->
          if window_element.scrollTop() > offset_limit
            element.addClass(attrs.addClassWhenOverViewport)
          else
            element.removeClass(attrs.addClassWhenOverViewport)
  .directive("relayoutSearchView",
    ["$window", "leafletData", "$timeout",
    ($window, leafletData, $timeout)->
      restrict: 'A'
      link : (scope, element, attrs) ->
        results_nui = element.find(".results")
        details_nui = element.find(".details")
        results_list_width = results_nui.outerWidth(true) + 20
        fit_map_bounds_to_markers = (offset_bottom_right, zoom_on_entry_id) ->
          leafletData.getMap().then (map) ->
            leafletData.getMarkers().then (markers) ->
              if zoom_on_entry_id?
                marker = markers[zoom_on_entry_id]
                marker.openPopup()
                # set an offset
                map.setView(marker._latlng, 15)
                center_points = map.latLngToContainerPoint(marker._latlng)
                x = center_points.x + (results_list_width / 2)
                y = center_points.y + (details_nui.outerHeight(true) / 2)
                point = map.containerPointToLatLng([x, y])
                map.setView(point, 15)
              else
                if _.size(markers) > 0
                  groups = new L.featureGroup(_.values(markers))
                  map.fitBounds groups,
                    paddingBottomRight: [offset_bottom_right[0], offset_bottom_right[1]]
        fit_map_bounds_to_markers_depending_of_details_panel =  (zoom_on_entry_id) ->
          $timeout ->
            if element.find(".details").hasClass("ng-hide")
              fit_map_bounds_to_markers([results_list_width, 0], zoom_on_entry_id)
            else
              fit_map_bounds_to_markers([results_list_width, details_nui.outerHeight(true) + 20], zoom_on_entry_id)
        relayout = (zoom_on_entry_id) ->
          $timeout ->
            window_height = $(window).height()
            details_height = Math.min(window_height, details_nui.find(".details__wrapper").outerHeight(true) + 40)
            details_offset_top = window_height - details_height
            details_nui.css
              width : $(window).width() - results_list_width
              height: details_height
              right : results_nui.outerWidth(true)
              top   : details_offset_top - 45
            fit_map_bounds_to_markers_depending_of_details_panel(zoom_on_entry_id)
        # first relayout
        relayout()
        # bind events
        angular.element($window).resize -> relayout()
        # follow the results to fit the map bounds regarding the markers
        scope.$watch "results", -> fit_map_bounds_to_markers_depending_of_details_panel()
        # follow the details view to ajust the map and the details panel size
        scope.$watch "entry_selected", (entry, e) ->
          relayout(if entry? then entry.id else undefined)
    ])

# EOF
