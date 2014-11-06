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
      .when '/about',
        templateUrl: 'scripts/poc/views/about.html'
        controller: 'AboutCtrl'
      .otherwise
        redirectTo: '/'
