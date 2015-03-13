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

    .controller('logoutController', ['$location', '$window', 'appService', '$cookieStore', function($location, $window, appService, $cookieStore) {

        $cookieStore.remove('user');
        appService.setLoggedIn(false);
    }]);

