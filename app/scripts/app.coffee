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
    'etyssa'
    'ngAnimate'
    'ngCookies'
    'ngResource'
    'ngRoute'
    'ngSanitize'
    'ngTouch'
    'leaflet-directive'
    'checklist-model'
    'ui.router'
  ])
  .run ($rootScope) ->
    $rootScope.$on '$viewContentLoaded', () ->
      $(document).foundation()

# EOF
