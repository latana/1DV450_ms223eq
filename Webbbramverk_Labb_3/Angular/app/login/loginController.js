/**
 * Created by Latana on 2015-03-05.
 */
'use strict';

angular.module('myApp.login', ['ngRoute', 'ngCookies'])

.config(['$routeProvider', function($routingProvider){
    $routingProvider.when('/login',{
        templateUrl: 'login/login.html'
    });
}])

/**
 *  Gör ett anrop mot apiet med datan som användaren matat in.
 *  Systemet hämtar upp rätt och felmeddelanden.
 */
.controller('loginController', ['$http', '$scope', '$location', '$cookieStore', '$window', 'appService', function($http, $scope, $location, $cookieStore, $window, appService){

        var auth = this;

        /**
         * Anropas när man vill logga in. Ansvaret läggs på apiet.
         */
        auth.login = function(){

            var data = {'user': auth.user, 'password' : auth.password};

            var url = appService.getApiUrl() + "auth";
            var config = {
                headers: {
                    "user" : data.user,
                    "password" : data.password,
                    "Accept" : "application/json"
                }
            };

            var promise = $http.post(url, data, config);

            // Är inloggningen lyckad så tas användaren till main page
            promise.success(function(data, status, headers, config){

                $cookieStore.put('user', config.headers.user);
                $window.sessionStorage.setItem('token', data.auth_token);
                $scope.message = "Success";
                appService.setLoggedIn(true);
                $location.path('/main');
            });

            promise.error(function(data) {

                $scope.error = data.error;
                appService.logout();
            });
        }
    }]);