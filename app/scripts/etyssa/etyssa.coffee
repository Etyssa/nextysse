'use strict'

###*
 # @ngdoc service
 # @name etyssa
 # @description
###
ETYSSA_API_TOKEN = "35d4c695-7286-47bd-a5d0-686d42c28e40"
angular.module('etyssa', [])
  .factory('Services',   ["$resource", ($resource) ->
    $resource 'http://api.scriptysse.fr:8080/rest/services/:service_name/?token=:token'            , {token:ETYSSA_API_TOKEN}, {}
  ])
  .factory('Categories', ["$resource", ($resource) ->
    $resource 'http://api.scriptysse.fr:8080/rest/services/argentan/categories?token=:token'       , {token:ETYSSA_API_TOKEN}, {}
  ])
  .factory('Search',     ["$resource", ($resource) ->
    $resource 'http://api.scriptysse.fr:8080/rest/services/argentan/search?cat=:cat&token=:token'  , {token:ETYSSA_API_TOKEN}, {}
  ])
  .factory('Entry',      ["$resource", ($resource) ->
    $resource 'http://api.scriptysse.fr:8080/rest/entries/:entry_id?token=:token'                  , {token:ETYSSA_API_TOKEN}, {}
  ])
  .factory('User',      ["$resource", ($resource) ->
    $resource 'http://api.scriptysse.fr:8080/rest/users/:user_id?token=:token'                     , {token:ETYSSA_API_TOKEN}, {}
  ])

# EOF
