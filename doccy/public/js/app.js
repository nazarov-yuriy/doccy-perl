(function () {
    'use strict';

    //noinspection JSUnresolvedFunction
    angular
        .module("app", ["ngRoute"])
        .config(config);

    config.$inject = ["$routeProvider"];
    function config($routeProvider) {
        $routeProvider
            .when("/", {
                controller: "StayTunedController",
                templateUrl: "view/stay-tuned.html",
                controllerAs: "vm"
            })
            .when("/about", {
                controller: "AboutController",
                templateUrl: "view/about.html",
                controllerAs: "vm"
            })
            .when("/documents", {
                controller: "DocumentsController",
                templateUrl: "view/documents.html",
                controllerAs: "vm"
            })
            .when("/documents/:page", {
                controller: "DocumentsController",
                templateUrl: "view/documents.html",
                controllerAs: "vm"
            })
            .when("/details/:documentId", {
                controller: "DetailsController",
                templateUrl: "view/details.html",
                controllerAs: "vm"
            })
            .when("/suggest-document", {
                controller: "SuggestDocumentController",
                templateUrl: "view/suggest-document.html",
                controllerAs: "vm"
            })
            .otherwise({redirectTo: "/"});
    }
})();