angular.module('seminaire2014App')
  .directive "scrollIf", ->
      restrict: 'A'
      scope:
        scrollIf: '=scrollIf'
      link : (scope, element, attrs) ->
        scope.$watch "scrollIf", ->
          if scope.scrollIf
            $("html").animate({scrollTop: element[0].offsetTop - 100}, "slow")

# EOF
