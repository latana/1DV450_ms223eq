/**
 * Created by Latana on 2015-03-12.
 */
'use strict';

angular.module('myApp.detail', ['ngRoute', 'ngMap'])

    .config(['$routeProvider', function($routingProvider){
        $routingProvider.when('/detail/:detailId',{
            templateUrl: 'detail/detail.html',
            controller: 'detailController'
        });
    }])

    .controller('detailController', ['$http', '$rootScope', '$scope', '$window', 'appService', 'routeParams',function($http, $rootScope, $scope, $window, appService, $routeParams){

        var id = $routeParams.detailId;
    }]);
