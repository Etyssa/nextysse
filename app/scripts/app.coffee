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
    'seminaire2014App.directives'
    'etyssa'
    'ngAnimate'
    'ngCookies'
    'ngResource'
    'ngRoute'
    'ngSanitize'
    'ngTouch'
    'leaflet-directive'
    'ui.router'
  ])
  .run(["$rootScope", "api", ($rootScope, api) ->
    api.init({email:"Peters.Coline@gmail.com", password:"RUCMZDMH"})
    $rootScope.$on '$viewContentLoaded', () ->
      $(document).foundation()
  ])

# EOF
