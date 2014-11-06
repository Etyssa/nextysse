'use strict'

###*
 # @ngdoc service
 # @name etyssa
 # @description
###
ETYSSA_API_TOKEN = "35d4c695-7286-47bd-a5d0-686d42c28e40"
angular.module('etyssa', [])
  .factory('Services', ["$resource", ($resource) ->
    # AngularJS will instantiate a singleton by calling "new" on this function
    $resource 'http://api.scriptysse.fr:8080/rest/services/argentan?token=:token'                , {token:ETYSSA_API_TOKEN}, {
      query:
        method: 'GET'
        isArray: no
    }
  ])
  .factory('Categories', ["$resource", ($resource) ->
    $resource 'http://api.scriptysse.fr:8080/rest/services/argentan/categories?token=:token'     , {token:ETYSSA_API_TOKEN}, {
      query:
        method: 'GET'
        isArray: yes
    }
  ])
  .factory('Search', ["$resource", ($resource) ->
    $resource 'http://api.scriptysse.fr:8080/rest/services/argentan/search?cat=:cat&token=:token', {token:ETYSSA_API_TOKEN}, {
      query:
        method: 'GET'
        isArray: yes
    }
  ])

# EOF
