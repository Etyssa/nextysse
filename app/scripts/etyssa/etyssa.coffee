'use strict'

###*
 # @ngdoc service
 # @name etyssa
 # @description
###

angular.module('etyssa', ["etyssa.config"])
  .factory('Services',   ["$resource", "GENERAL_CONFIG", ($resource, GENERAL_CONFIG) ->
    $resource "#{GENERAL_CONFIG.API_HOST}/rest/services/:service_name/?token=:token"      , {token:GENERAL_CONFIG.ETYSSA_API_TOKEN}, {
      query :
        method            : "GET"
        isArray           : yes
        transformResponse : (data, headersGetter) -> return angular.fromJson(data).services
    }
  ])
  .factory('Categories', ["$resource", "GENERAL_CONFIG", ($resource, GENERAL_CONFIG) ->
    $resource "#{GENERAL_CONFIG.API_HOST}/rest/services/issy/categories?token=:token"       , {token:GENERAL_CONFIG.ETYSSA_API_TOKEN}, {}
  ])
  .factory('Search',     ["$resource", "GENERAL_CONFIG", ($resource, GENERAL_CONFIG) ->
    $resource "#{GENERAL_CONFIG.API_HOST}/rest/services/issy/search?cat=:cat&token=:token"  , {token:GENERAL_CONFIG.ETYSSA_API_TOKEN}, {}
  ])
  .factory('Entries',    ["$resource", "GENERAL_CONFIG", ($resource, GENERAL_CONFIG) ->
    $resource "#{GENERAL_CONFIG.API_HOST}/rest/services/issy/entries/:entry_id?token=:token", {token:GENERAL_CONFIG.ETYSSA_API_TOKEN}, {}
  ])
  .factory('Users',      ["$resource", "GENERAL_CONFIG", ($resource, GENERAL_CONFIG)  ->
    $resource "#{GENERAL_CONFIG.API_HOST}/rest/services/issy/users/:user_id?token=:token"   , {token:GENERAL_CONFIG.ETYSSA_API_TOKEN}, {}
  ])
  .factory('Profile',    ["$resource", "GENERAL_CONFIG", ($resource, GENERAL_CONFIG)  ->
    $resource "#{GENERAL_CONFIG.API_HOST}/rest/me/?token=:token"                            , {token:GENERAL_CONFIG.ETYSSA_API_TOKEN}, {}
  ])
  .factory('Message',    ["$resource", "GENERAL_CONFIG", ($resource, GENERAL_CONFIG)  ->
    $resource "#{GENERAL_CONFIG.API_HOST}/rest/messages/?token=:token"                      , {token:GENERAL_CONFIG.ETYSSA_API_TOKEN}, {}
  ])

angular.module('etyssa').factory('api',
  ["$http", "$cookies",
  ($http, $cookies) ->
    init: (credential) ->
      $http.defaults.headers.common['email']    = credential.email
      $http.defaults.headers.common['password'] = CryptoJS.SHA1(credential.password)
])

angular.module('etyssa').factory('httpInterceptor', 
  ["$q", "$window", "$location",
  ($q, $window, $location) ->
    (promise) ->
      success = (response) ->
        response
      error = (response) ->
        console.warn "httpInterceptor", response.status, response.status
        $q.reject(response)
      return promise.then(success)
])
# EOF
