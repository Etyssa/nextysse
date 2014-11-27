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
    'cgNotify'
  ])
  .run(["$rootScope", "api", ($rootScope, api) ->
    api.init({email:"olivoelement", password:"coucou"})
    $rootScope.$on '$viewContentLoaded', () ->
      $(document).foundation()
  ])

# EOF
