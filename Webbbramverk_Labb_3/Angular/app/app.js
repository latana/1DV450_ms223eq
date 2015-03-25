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
    // Tar användaren till /main om url'en inte kan hittas
config(['$routeProvider', function($routeProvider) {
  $routeProvider.otherwise({redirectTo: '/main'});
}])

.service('appService', ['$window', function($window){

        var message;

        // Sätter meddelande
      this.setLoggedIn = function (value){
        $window.sessionStorage.setItem('isLoggedIn', value)
      };

        this.logout = function(){
          $window.sessionStorage.clear();
        };

        // skickar inloggningen
      this.getIsLoggedIn = function(){
        return JSON.parse($window.sessionStorage.getItem('isLoggedIn'))
      };

        // Sätter meddelandet
        this.setMessage = function(value){
            message = value;
        };

        // Skickar meddelandet
        this.getMessage = function(){
            return message;
        };

        this.getApiUrl = function(){
            return "http://localhost:3000/api/";
        }

        this.getApiKey = function(){
            return "12345";
        }
}])

.directive('myCustomDirective', function() {
    return {
        templateUrl: 'myCustomDirective.html'
    };
});


