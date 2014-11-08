angular.module('seminaire2014App').config [
  "$stateProvider", "$urlRouterProvider", "$locationProvider",
  ($stateProvider, $urlRouterProvider, $locationProvider)->
    $urlRouterProvider.otherwise("search")
    $stateProvider
      .state 'search',
        url: "/search"
        templateUrl: "scripts/views/search.html"
        controller: "SearchCtrl"
      .state 'overview',
        url: "/overview"
        templateUrl: "scripts/views/overview.html"
        controller: "OverviewCtrl"
      .state 'about',
        url: "/about"
        templateUrl: "scripts/views/about.html"
        controller: "AboutCtrl"
]

# EOF
