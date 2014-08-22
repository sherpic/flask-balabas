'use strict'

###*
 # @ngdoc overview
 # @name showcaseApp
 # @description
 # # showcaseApp
 #
 # Main module of the application.
###
angular
  .module('showcaseApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch'
  ])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
      .when '/myroute',
        templateUrl: 'views/myroute.html'
        controller: 'MyrouteCtrl'
      .otherwise
        redirectTo: '/'
