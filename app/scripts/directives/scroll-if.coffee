angular.module('seminaire2014App')
  .directive "scrollIf", ->
      restrict: 'A'
      scope:
        scrollIf: '=scrollIf'
      link : (scope, element, attrs) ->
        scope.$watch "scrollIf", ->
          if scope.scrollIf
            window.scrollTo(0, element[0].offsetTop - 100)

# EOF
