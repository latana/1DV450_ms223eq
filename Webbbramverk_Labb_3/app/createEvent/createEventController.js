/**
 * Created by Latana on 2015-03-11.
 */
'use strict';

angular.module('myApp.createEvent', ['ngRoute'])

    .config(['$routeProvider', function($routingProvider){
        $routingProvider.when('/createEvent',{
            templateUrl: 'createEvent/createEvent.html',
            controller: 'createEventController'
        });
    }])

    .controller('createEventController', ['$http', '$rootScope', '$scope', '$window', 'appService', '$location', function($http, $rootScope, $scope, $window, appService, $location){

        var latt;
        var long;

        var create = this;

        create.create = function(){

            navigator.geolocation.getCurrentPosition(function(resp){
                latt = resp.coords.latitude;
                long = resp.coords.longitude;
                var position = {long: long, latt: latt};

                var event = {title: create.title, description: create.description};
                var tags = {name: create.tagName};
                var data = {event:event, tags:tags, position: position};
                var url = 'http://localhost:3000/api/event';

                var config = {
                    headers: {
                        "userkey" : $window.sessionStorage.getItem('token'),
                        "Accept" : "application/json"
                    }
                };

                var promise = $http.post(url, data, config);

                promise.success(function(data, status, headers, config){
                    appService.setMessage('Create success');
                    $location.path('/main');
                });

                promise.error(function(data, status, headers, config) {
                    $scope.message = data.error;
                });

            });
        }
    }]);
