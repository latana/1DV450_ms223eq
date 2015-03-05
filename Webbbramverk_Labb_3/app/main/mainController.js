/**
 * Created by Latana on 2015-03-05.
 */
'use strict'

angular.module('myApp.main', ['ngRoute'])

    .config(['$routeProvider', function($routingProvider){
        $routingProvider.when('/main',{
            templateUrl: 'main/main.html',
            controller: 'mainController'
        });
    }])

    .controller('mainController', ['$http', '$scope', function($http, $scope){

        var getEvent = this;

        var getConfig = {
            headers: {
                "Authorization" : '12345',
                "Accept" : "application/json"
            }
        };

        $http.get("http://localhost:3000/api/event", getConfig).success(function(data) {
            console.log(data);
            getEvent.events = data;
        }).error(function(data, status) {
            //console.log(data);
            getEvent.alert = data.error;
        });

        // Havent implemented this (should try to do a DELETE and send the correct token )
        // No need for more validation here since the server is checking the token
        getEvent.removeEvent = function(event) {
            console.log(event);
        };

    }]);