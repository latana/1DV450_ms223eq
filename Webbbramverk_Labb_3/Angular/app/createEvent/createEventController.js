/**
 * Created by Latana on 2015-03-11.
 */
'use strict';

angular.module('myApp.createEvent', ['ngRoute'])

    .config(['$routeProvider', function($routingProvider){
        $routingProvider.when('/createEvent',{
            templateUrl: 'createEvent/createEvent.html'
        });
    }])
/**
 * Skapar ett event från formuläret i createEvent.html
 */
    .controller('createEventController', ['$http', '$rootScope', '$scope', '$window', 'appService', '$location', function($http, $rootScope, $scope, $window, appService, $location){

        var latt;
        var long;

        var create = this;

        create.create = function() {

            /**
             * Kontrollerar om användarens webläsare har stöd för geolocation och i så fall görs en put mot apiet.
             * Annars skickas ett meddelande ut.
             */
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (resp) {

                    //Förbereder anropet till apiet.

                    latt = resp.coords.latitude;
                    long = resp.coords.longitude;
                    var position = {long: long, latt: latt};

                    var event = {title: create.title, description: create.description};
                    var tags = {name: create.tagName};
                    var data = {event: event, tags: tags, position: position};
                    var url = 'http://localhost:3000/api/event';

                    var config = {
                        headers: {
                            "userkey": $window.sessionStorage.getItem('token'),
                            "Accept": "application/json"
                        }
                    };

                    var promise = $http.post(url, data, config);

                    // Om det lyckats tas man till main och ett meddelande matas ut
                    promise.success(function (data, status, headers, config) {
                        appService.setMessage('Create success');
                        $location.path('/main');
                    });

                    // Om det misslyckas så matas ett meddelande ut.
                    promise.error(function (data) {
                        $scope.error = data.error;
                    });

                    // Tar hand om felet som har uppstått med geolocation och skickat ut ett passande meddelande.
                }, function(error){
                    $scope.$apply(function(){
                        switch(error.code) {
                            case error.PERMISSION_DENIED:
                                $scope.error = "You must accept the request for Geolocation.";
                                break;
                            case error.POSITION_UNAVAILABLE:
                                $scope.error = "Location information is unavailable.";
                                break;
                            case error.UNKNOWN_ERROR:
                                $scope.error = "An unknown error occurred.";
                                break;
                        }
                    });
                });
            }
            else{
                $scope.error = "You must accept google to track your location to create an event";
            }
        }

    }]);
