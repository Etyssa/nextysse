'use strict'

###*
 # @ngdoc function
 # @name seminaire2014App.controller:LoginCtrl
 # @description
 # # LoginCtrl
 # Controller of the seminaire2014App
###
angular.module('seminaire2014App')
  .controller('ContactCtrl',
  ["$scope", "$timeout", "Message",
  ($scope, $timeout, Message) ->
    $scope.loading = no
    $scope.answerToEntry = (entry) ->
      $scope.loading = yes
      Message.save {receiver:entry.creator, entry:entry.id, body:$scope.answer}, (data) ->
        $scope.loading           = no
        $scope.contact_form.show = no
        $scope.answer            = ""
      , (error) ->
        console.error "error", error
  ])

# EOF
