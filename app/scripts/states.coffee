angular.module('seminaire2014App').config [
  "$stateProvider", "$urlRouterProvider", "$locationProvider",
  ($stateProvider, $urlRouterProvider, $locationProvider)->
    # $locationProvider.html5Mode true
    $urlRouterProvider.otherwise("search")
    $stateProvider
      .state 'search',
        url: "/search"
        templateUrl: "scripts/views/search.html"
        controller: "SearchCtrl"
      .state 'entry',
        url: "/entry/:id"
        templateUrl: "scripts/views/entry.html"
        controller: "SearchCtrl"
      .state 'overview',
        url: "/overview"
        templateUrl: "scripts/views/overview.html"
        controller: "OverviewCtrl"
      .state 'about',
        url: "/about"
        templateUrl: "scripts/views/about.html"
        controller: "AboutCtrl"
      .state 'login',
        url: "/login"
        templateUrl: "scripts/views/login.html"
        controller: "LoginCtrl"        
      .state 'profile',
        url: "/profile"
        templateUrl: "scripts/views/profile.html"
        controller: "ProfileCtrl"             
]

# EOF
