/**
 * Created by Latana on 2015-03-05.
 */
'use strict';

angular.module('myApp.main', ['ngRoute', 'ngMap'])

    .config(['$routeProvider', function($routingProvider){
        $routingProvider.when('/main',{
            templateUrl: 'main/main.html',
            controller: 'mainController'
        });
    }])

    .controller('mainController', ['$http', '$rootScope', '$scope', '$window', 'appService',function($http, $rootScope, $scope, $window, appService){

        $scope.isLoggedIn = appService.getIsLoggedIn();
        $scope.message = appService.getMessage();
        var getEvent = this;
        var getConfig = {
            headers: {
                "Authorization" : '12345',
                "Accept" : "application/json"
            }
        };

        $http.get("http://localhost:3000/api/event", getConfig).success(function(data) {
            getEvent.events = data;
        }).error(function(data, status) {
            getEvent.alert = data.error;
        });

        getEvent.removeEvent = function(id) {

            var index = getEvent.events.map(function(e) {return e.id;}).indexOf(id);
            var url = "http://localhost:3000/api/event/" + id;
            var config = {
                headers: {
                    "userkey" : $window.sessionStorage.getItem('token'),
                    "Accept" : "application/json"
                }
            };
            var promise = $http.delete(url, config);

            promise.success(function(data, status, config){

                getEvent.events.splice(index, 1);
                appService.setMessage('The event is deleted');
                $scope.message = appService.getMessage();
            });

            promise.error(function(data, status, config) {
                console.log("NOT DELETED!!!");
            });

        };
    }]);