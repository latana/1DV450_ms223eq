'use strict';

// Declare app level module which depends on views, and components
angular.module('myApp', [
  'ngRoute',
  'myApp.login',
  'myApp.main',
  'myApp.logout',
    'myApp.createEvent',
    'myApp.detail',
  'myApp.updateEvent',
  'myApp.version'
]).
config(['$routeProvider', function($routeProvider) {
  $routeProvider.otherwise({redirectTo: '/main'});
}])

.service('appService', ['$window', function($window){

        var message;

      this.setLoggedIn = function (value){
        $window.sessionStorage.setItem('isLoggedIn', value)
      };

      this.getIsLoggedIn = function(){
        return JSON.parse($window.sessionStorage.getItem('isLoggedIn'))
      };

        this.setMessage = function(value){
            message = value;
        };

        this.getMessage = function(){
            return message;
        };
}]);
