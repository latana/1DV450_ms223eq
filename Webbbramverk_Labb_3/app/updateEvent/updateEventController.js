/**
 * Created by Latana on 2015-03-11.
 */
'use strict';

angular.module('myApp.updateEvent', ['ngRoute'])

    .config(['$routeProvider', function($routingProvider){
        $routingProvider.when('/update/:eventId',{
            templateUrl: 'updateEvent/updateEvent.html',
            controller: 'updateEventController'
        });
    }])

    .controller('updateEventController', ['$routeParams', '$window', '$http', '$location', '$scope', 'appService', function($routeParams, $window, $http, $location, $scope, appService){

        var update = this;
        var id = $routeParams.eventId;

        var getConfig = {
            headers: {
                "Authorization" : '12345',
                "Accept" : "application/json"
            }
        };

        $http.get('http://localhost:3000/api/event/' + id, getConfig).success(function(data){
            update.title = data.title;
            update.description = data.description;
        }).error(function(data, status) {
            update.alert = data.error;
        });

        update.update = function(){

            var data = {'title': update.title, 'description': update.description};
            var url = 'http://localhost:3000/api/event/' + id;

            var config = {
                headers: {
                    "userkey" : $window.sessionStorage.getItem('token'),
                    "Accept" : "application/json"
                }
            };

            var promise = $http.put(url, data, config);

            promise.success(function(data, status, headers, config){

                appService.setMessage('Uppdate success');
                $location.path('/main');
            });

            promise.error(function(data, status, headers, config) {

                $scope.message = data.error;
            });
        }

    }]);