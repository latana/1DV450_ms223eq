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

    .controller('mainController', ['$http', '$rootScope', '$scope', '$window', 'appService', '$cookieStore',function($http, $rootScope, $scope, $window, appService, $cookieStore){

        $scope.isLoggedIn = appService.getIsLoggedIn();
        $scope.message = appService.getMessage();
        var get = this;
        get.events = [];
        var getConfig = {
            headers: {
                "Authorization" : '12345',
                "Accept" : "application/json"
            }
        };

        $http.get('http://localhost:3000/api/tag', getConfig).success(function(data){
            get.tags = data;
        }).error(function(data, status) {
            get.alert = data.error;
        });

        get.removeEvent = function(id) {

            var index = get.events.map(function(e) {return e.id;}).indexOf(id);
            var url = "http://localhost:3000/api/event/" + id;
            var config = {
                headers: {
                    "userkey" : $window.sessionStorage.getItem('token'),
                    "Accept" : "application/json"
                }
            };
            var promise = $http.delete(url, config);

            promise.success(function(data, status, config){

                get.events.splice(index, 1);
                appService.setMessage('The event is deleted');
                $scope.message = appService.getMessage();
            });

            promise.error(function(data, status, config) {
                console.log("NOT DELETED!!!");
            });
        };
        get.filterTag = function(id){

            $http.get('http://localhost:3000/api/tag/' + id, getConfig).success(function(data){
                get.events = data;
            }).error(function(data){
                get.alert = data.error;
            })
        };

        get.filterCreators = function(id){

            $http.get('http://localhost:3000/api/creator/' + id, getConfig).success(function(data){
                get.events = data;
            }).error(function(data){
                get.alert = data.error;
            })
        };

        get.getAllEvents = function(){

            $http.get("http://localhost:3000/api/event", getConfig).success(function(data) {
                get.events = data;
            }).error(function(data, status) {
                get.alert = data.error;
            });
        };

        get.getAllCreators = function(){

            $http.get('http://localhost:3000/api/creator', getConfig).success(function(data){
                get.creators = data;
            }).error(function(data, status) {
                get.alert = data.error;
            });
        };

        get.checkUser = function(userName){
            return userName === $cookieStore.get('user');
        };
        get.getAllEvents();
        get.getAllCreators();
    }]);