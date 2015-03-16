/**
 * Created by Latana on 2015-03-05.
 */
'use strict';

angular.module('myApp.main', ['ngRoute', 'ngMap'])

    .config(['$routeProvider', function($routingProvider){
        $routingProvider.when('/main',{
            templateUrl: 'main/main.html'
        });
    }])

    .controller('mainController', ['$http', '$rootScope', '$scope', '$window', 'appService', '$cookieStore', '$location',function($http, $rootScope, $scope, $window, appService, $cookieStore, $location){

        // Används för bootstrap och gör den valda menyn aktiv
        $scope.isActive = function (viewLocation){
            return viewLocation === $location.path();
        };

        // Kollar om användaren är inloggad
        $scope.isLoggedIn = appService.getIsLoggedIn();

        // Tar in det aktiva meddelandet
        $scope.message = appService.getMessage();

        var get = this;
        get.events = [];
        var getConfig = {
            headers: {
                "Authorization" : '12345',
                "Accept" : "application/json"
            }
        };

        /**
         * Hämtar ut alla taggar
         */
        $http.get('http://localhost:3000/api/tag', getConfig).success(function(data){
            get.tags = data;
        }).error(function(data, status) {
            appService.setMessage(data.error);
            get.alert = appService.getMessage();
        });

        // Tar bort ett event genom det id som kommer in
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

            // Skickar ut meddelande om deleten är lyckad.
            promise.success(function(data, status, config){

                get.events.splice(index, 1);
                appService.setMessage('The event is deleted');
                $scope.message = appService.getMessage();
            });

            // Skickar meddelande om deleten är misslyckad
            promise.error(function(data) {
                $scope.error = data.message_for_user;
            });
        };

        // Filtrering på events genom det tag-id som kommit in
        get.filterTag = function(id){

            $http.get('http://localhost:3000/api/tag/' + id, getConfig).success(function(data){
                get.events = data;
            }).error(function(data){
                $scope.alert = data.error;
            })
        };

        // Filtrering på creators genom det creator-id som kommit in
        get.filterCreators = function(id){

            $http.get('http://localhost:3000/api/creator/' + id, getConfig).success(function(data){
                get.events = data;
            }).error(function(data){
                $scope.alert = data.error;
            })
        };

        // Hämtar ut alla events
        get.getAllEvents = function(){

            $http.get("http://localhost:3000/api/event", getConfig).success(function(data) {
                get.events = data;
            }).error(function(data, status) {
                $scope.alert = data.error;
            });
        };

        // Hämtar alla creators
        get.getAllCreators = function(){

            $http.get('http://localhost:3000/api/creator', getConfig).success(function(data){
                get.creators = data;
            }).error(function(data, status) {
                $scope.alert = data.error;
            });
        };

        // Kontrollerar vem som skapad vad och ifall de ska kunna ändra det eventet
        get.checkUser = function(userName){
            return userName === $cookieStore.get('user');
        };

        get.getAllEvents();
        get.getAllCreators();
    }]);