/**
 * Created by Latana on 2015-03-05.
 */
'use strict';

angular.module('myApp.main', ['ngRoute'])

    .config(['$routeProvider', function($routingProvider){
        $routingProvider.when('/main',{
            templateUrl: 'main/main.html',
            controller: 'mainController'
        });
    }])

    .controller('mainController', ['$http', '$rootScope', '$scope', '$window', function($http, $rootScope, $scope, $window){

        var getEvent = this;
        $scope.isLoggedIn = $window.sessionStorage.getItem('isLoggedIn');
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
                    "userkey" : $rootScope.token,
                    "Accept" : "application/json"
                }
            };
            var promise = $http.delete(url, config);

            promise.success(function(data, status, config){

                getEvent.events.splice(index, 1);
                console.log("it is deleted");
            });

            promise.error(function(data, status, config) {

                console.log("NOT DELETED!!!");
            });

        };

    }]);