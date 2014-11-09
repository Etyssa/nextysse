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

# EOF
