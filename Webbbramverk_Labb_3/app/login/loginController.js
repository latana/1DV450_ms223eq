/**
 * Created by Latana on 2015-03-05.
 */
'use strict';

angular.module('myApp.login', ['ngRoute'])

.config(['$routeProvider', function($routingProvider){
    $routingProvider.when('/login',{
        templateUrl: 'login/login.html',
        controller: 'loginController'
    });
}])

    .factory('message', function(){
        return{}
    })

.controller('loginController', ['$http', '$scope', '$location', function($http, $scope, $location, message){

        var auth = this;
        $scope.message = message;
        auth.login = function(){

            var data = {'user': auth.user, 'password' : auth.password};
            $scope.isLoggedIn = false;

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

                $scope.message = "Success";
                console.log($scope.message);
                $scope.token = data.auth_token;
                $scope.isLoggedIn = true;
                $location.path('/main')

            });

            promise.error(function(data, status, headers, config) {

                $scope.message = data.error;
                $scope.token = null;
                $scope.isLoggedIn = false;
            });
        }

    }]);