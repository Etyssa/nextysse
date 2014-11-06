'use strict'

###*
 # @ngdoc overview
 # @name seminaire2014App
 # @description
 # # seminaire2014App
 #
 # Main module of the application.
###
angular
  .module('seminaire2014App', [
    'etyssa',
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch'
  ])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'scripts/poc/views/main.html'
        controller: 'MainCtrl'
      .when '/overview',
        templateUrl: 'scripts/poc/views/overview.html'
        controller: 'OverviewCtrl'
      .when '/entry/:id',
        templateUrl: 'scripts/poc/views/entry.html'
        controller: 'EntryCtrl'
      .when '/about',
        templateUrl: 'scripts/poc/views/about.html'
        controller: 'AboutCtrl'
      .otherwise
        redirectTo: '/'
