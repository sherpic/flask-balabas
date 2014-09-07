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
    'ngTouch',
    "ui.bootstrap"
  ])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
      .when '/basket',
        templateUrl: 'views/basket.html'
        controller: 'BasketCtrl'
      .when '/login',
        templateUrl: 'views/login.html'
        controller: 'LoginCtrl'
      .when '/register',
        templateUrl: 'views/register.html'
        controller: 'RegisterCtrl'
      .when '/grid',
        templateUrl: 'views/grid.html'
        controller: 'GridCtrl'
      .otherwise
        redirectTo: '/'

