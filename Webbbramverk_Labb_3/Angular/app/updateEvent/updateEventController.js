/**
 * Created by Latana on 2015-03-11.
 */
'use strict';

angular.module('myApp.updateEvent', ['ngRoute'])

    .config(['$routeProvider', function($routingProvider){
        $routingProvider.when('/update/:eventId',{
            templateUrl: 'updateEvent/updateEvent.html'
        });
    }])

/**
 * Uppdaterar ett event beroende på vad för id som kommer in
 */
    .controller('updateEventController', ['$routeParams', '$window', '$http', '$location', '$scope', 'appService', function($routeParams, $window, $http, $location, $scope, appService){

        var update = this;
        var id = $routeParams.eventId;

        // förbereder anropet mot apiet
        var getConfig = {
            headers: {
                "Authorization" : appService.getApiKey(),
                "Accept" : "application/json"
            }
        };

        // Anropar och hämtar ut data från apiet
        $http.get(appService.getApiUrl() + 'event/' + id, getConfig).success(function(data){
            update.title = data.title;
            update.description = data.description;
        }).error(function(data, status) {
            $scope.alert = data.error;
        });

        // Uppdaterar ett event
        update.update = function(){

            var data = {'title': update.title, 'description': update.description};
            var url = appService.getApiUrl() + 'event/' + id;

            var config = {
                headers: {
                    "userkey" : $window.sessionStorage.getItem('token'),
                    "Accept" : "application/json"
                }
            };

            var promise = $http.put(url, data, config);

            // Skickar ut ett meddelande om updaten är lyckad
            promise.success(function(data, status, headers, config){

                appService.setMessage('Uppdate success');
                $location.path('/main');
            });

            // Annars skickas ett felmeddelande från api
            promise.error(function(data) {
                $scope.error = data.message_for_user;
            });
        }
    }]);