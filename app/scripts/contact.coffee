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
  ["$scope", "$timeout", "Message", "notify",
  ($scope, $timeout, Message, notify) ->
    $scope.loading = no
    $scope.answerToEntry = (entry) ->
      $scope.loading = yes
      Message.save {receiver:entry.creator, entry:entry.id, body:$scope.answer}, (data) ->
        $scope.loading           = no
        $scope.contact_form.show = no
        $scope.answer            = ""
        notify({message:"Message envoyé à #{entry.creator_nickname}", classes:["alert-success"]})
      , (error) ->
        notify({message:"Une erreur est survenue.", classes:["alert-danger"]})
        console.error "error", error
  ])

# EOF
