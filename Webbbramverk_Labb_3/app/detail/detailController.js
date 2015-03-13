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

    .controller('detailController', ['$http', '$scope', '$routeParams',function($http, $scope, $routeParams){

        var id = $routeParams.detailId;
        var get = this;
        get.bool = false;

        get.event = {};
        $scope.latt = null;
        $scope.long = null;

        var getConfig = {
            headers: {
                "Authorization" : '12345',
                "Accept" : "application/json"
            }
        };

        $http.get('http://localhost:3000/api/event/' + id, getConfig).success(function(data){
            get.event = data;
            get.bool = true;
        }).error(function(data, status) {
            get.alert = data.error;
        });
    }]);
