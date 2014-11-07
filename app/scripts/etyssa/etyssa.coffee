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
  .factory('User',      ["$resource", "GENERAL_CONFIG", ($resource, GENERAL_CONFIG)  ->
    $resource "#{GENERAL_CONFIG.API_HOST}/rest/services/issy/users/:user_id?token=:token"   , {token:GENERAL_CONFIG.ETYSSA_API_TOKEN}, {}
  ])

# EOF
