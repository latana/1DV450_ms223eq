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

        update.update = function(){

            var data = {'description': update.description};
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