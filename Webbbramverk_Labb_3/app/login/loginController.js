/**
 * Created by Latana on 2015-03-05.
 */
'use strict';

angular.module('myApp.login', ['ngRoute', 'ngCookies'])

.config(['$routeProvider', function($routingProvider){
    $routingProvider.when('/login',{
        templateUrl: 'login/login.html',
        controller: 'loginController'
    });
}])

.controller('loginController', ['$http', '$scope', '$location', '$rootScope', '$cookieStore', '$window', 'appService', function($http, $scope, $location, $rootScope, $cookieStore, $window, appService){

        var auth = this;
        auth.login = function(){

            var data = {'user': auth.user, 'password' : auth.password};

            var url = "http://localhost:3000/api/auth";
            var config = {
                headers: {
                    "user" : data.user,
                    "password" : data.password,
                    "Accept" : "application/json"
                }
            };

            var promise = $http.post(url, data, config);

            promise.success(function(data, status, headers, config){

                $cookieStore.put('user', config.headers.user);
                $window.sessionStorage.setItem('token', data.auth_token);
                $scope.message = "Success";
                appService.setLoggedIn(true);
                $location.path('/main');
            });

            promise.error(function(data, status, headers, config) {

                $scope.error = data.error;
                $window.sessionStorage.setItem('token', false);
                $window.sessionStorage.setItem('isLoggedIn', false);
            });
        }
    }]);