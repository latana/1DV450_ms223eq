/**
 * Created by Latana on 2015-03-12.
 */
'use strict';

angular.module('myApp.detail', ['ngRoute', 'ngMap'])

    .config(['$routeProvider', function($routingProvider){
        $routingProvider.when('/detail/:detailId',{
            templateUrl: 'detail/detail.html'
        });
    }])

/**
 *  Tar in ett id från urlen och med det gör ett anrop mot apiet för att hämta det rätta eventet.
 */
    .controller('detailController', ['$http', '$scope', '$routeParams', 'appService',function($http, $scope, $routeParams, appService){

        var id = $routeParams.detailId;
        var get = this;
        get.bool = false;

        get.event = {};

        var getConfig = {
            headers: {
                "Authorization" : appService.getApiKey(),
                "Accept" : "application/json"
            }
        };

        $http.get(appService.getApiUrl() + 'event/' + id, getConfig).success(function(data){
            get.event = data;
            get.bool = true;
        }).error(function(data, status) {
            $scope.alert = data.error;
        });
    }]);
