/**
 * Created by Latana on 2015-03-06.
 */
'use strict';

angular.module('myApp.logout', ['ngRoute'])

    .config(['$routeProvider', function($routingProvider){
        $routingProvider.when('/logout',{
            templateUrl: 'main/main.html',
            controller: 'logoutController'
        });
    }])


// Loggar ut användaren
    .controller('logoutController', ['appService', '$cookieStore', function(appService, $cookieStore) {

        $cookieStore.remove('user');
        appService.logout();
    }]);

