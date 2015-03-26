do () ->
    config_data =
      GENERAL_CONFIG:
        ETYSSA_API_TOKEN : "a5ec51cb-8590-4a50-b797-9fbbaf50854a"
        API_HOST         : "http://api.scriptysse.fr:8181"

    # set the properties in constants into the etyssa.config module
    config_module = angular.module('etyssa.config', [])
    angular.forEach config_data, (key,value) ->
      config_module.constant(value,key)

# EOF
