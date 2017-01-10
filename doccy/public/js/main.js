(function () {
    'use strict';

    var legalRequestKey = "doccy v5YeRR5f";
    var nanobar = new Nanobar(); //ToDo: singleton

    //noinspection JSUnresolvedFunction
    angular
        .module("app")
        .controller("StayTunedController", StayTunedController)
        .controller("AboutController", AboutController)
        .controller("DocumentsController", DocumentsController)
        .controller("DetailsController", DetailsController)
        .controller("SuggestDocumentController", SuggestDocumentController)
        .service("DocumentsService", DocumentsService)
        .directive("httpvalidator", HttpValidator)
        .directive('file', function () {
            return {
                scope: {
                    file: '='
                },
                link: function (scope, el, attrs) {
                    el.bind('change', function (event) {
                        var file = event.target.files[0];
                        scope.file = file ? file : undefined;
                        scope.$apply();
                    });
                }
            };
        });

    function HttpValidator() {
        return {
            require: 'ngModel',
            link: function (scope, elm, attrs, ctrl) {
                ctrl.$validators.httpvalidator = function (modelValue, viewValue) {
                    return true;
                };
                scope.$watch('suggestDocumentForm.' + attrs.name + '.$valid', function (validity) {
                    elm[0].setCustomValidity(validity ? "" : scope.invalidFields[attrs.name]);
                });
            }
        };
    }

    StayTunedController.$inject = ["$scope", "$http"];
    function StayTunedController($scope, $http) {
        $scope.subscriberSendResult = {
            sent: false,
            message: ""
        };
        $scope.subscribe = function subscribe(subscriberEmail) {
            nanobar.go(90);
            $http({
                method: "POST",
                url: "/api/subscribers",
                contentType: "application/json; charset=utf-8",
                data: {
                    email: subscriberEmail
                },
                headers: {
                    "Authorization": legalRequestKey
                }
            }).then(function () {
                $("#beforeSubscribe").hide();
                $("#okSubscribe").show();
                nanobar.go(100);
            }, function (response) {
                $scope.subscriberSendResult.sent = true;
                nanobar.go(100);
                if (response.status == 500) {
                    $scope.subscriberSendResult.message = "Упс, что-то пошло не так, но мы всё скоро исправим!";
                } else {
                    $scope.subscriberSendResult.message = response.statusText;
                }
            });
        }
    }

    AboutController.$inject = ["$scope"];
    function AboutController($scope) {
    }

    DocumentsController.$inject = ["$scope", "DocumentsService", "$routeParams"];
    function DocumentsController($scope, documentsService, $routeParams) {
        $scope.pagination = {
            pages: [1],
            page: $routeParams.hasOwnProperty("page") ? $routeParams.page : 1,
            itemsPerPage: 20
        };
        $scope.documents = [];
        $scope.renderTags = function renderTags(tags) {
            return Object.keys(tags).sort().join(", ");
        };
        $scope.loadPage = function (page) {
            $scope.pagination.page = page;
            documentsService.getDocuments(
                ($scope.pagination.page - 1) * $scope.pagination.itemsPerPage,
                $scope.pagination.itemsPerPage
            ).then(
                function (data) {
                    $scope.documents = data;
                }
            );
            documentsService.getCount().then(
                function (data) {
                    var pages = Math.floor(Math.max(1, (data - 1) / $scope.pagination.itemsPerPage + 1));
                    $scope.pagination.pages = Array.apply(null, new Array(pages)).map(function (_, i) {
                        return i + 1;
                    });
                }
            );
        };
        $scope.loadPage($scope.pagination.page);
    }

    DocumentsService.$inject = ["$http"];
    function DocumentsService($http) {
        return {
            getDocuments: getDocuments,
            getCount: getCount,
            getDocument: getDocument
        };
        function handleSuccess(response) {
            return response.data;
        }

        function getDocuments(offset, limit) {
            var request = $http({
                method: "GET",
                url: "/api/documents" + "?offset=" + offset + "&limit=" + limit,
                headers: {
                    "Authorization": legalRequestKey
                }
            });
            return request.then(handleSuccess, handleSuccess);
        }

        function getDocument(id) {
            var request = $http({
                method: "GET",
                url: "/api/documents/" + id,
                headers: {
                    "Authorization": legalRequestKey
                }
            });
            return request.then(handleSuccess, handleSuccess);
        }

        function getCount() {
            var request = $http({
                method: "GET",
                url: "/api/documents/count",
                headers: {
                    "Authorization": legalRequestKey
                }
            });
            return request.then(handleSuccess, handleSuccess);
        }
    }

    DetailsController.$inject = ["$scope", "DocumentsService", "$routeParams"];
    function DetailsController($scope, documentsService, $routeParams) {
        $scope.doc = null;
        documentsService.getDocument($routeParams.documentId).then(
            function (data) {
                $scope.doc = data;
            }
        );
        $scope.renderTags = function renderTags(tags) {
            return Object.keys(tags).sort().join(", ");
        };
    }

    SuggestDocumentController.$inject = ["$scope", "$http"];
    function SuggestDocumentController($scope, $http) {
        $scope.tag = "";
        $scope.suggestionSendResult = {
            sent: false,
            successfully: false,
            message: ""
        };
        $scope.document = {
            title: "",
            summary: "",
            url: "",
            email: "",
            tags: {}
        };
        $scope.invalidFields = {};
        $scope.addTag = function addTag() {
            $scope.document.tags[$scope.tag] = null;
            $scope.tag = "";
        };
        $scope.delTag = function delTag(tag) {
            delete $scope.document.tags[tag];
        };
        $scope.suggestDocument = function suggestDocument(data) {
            nanobar.go(90);
            $http({
                method: "POST",
                url: "/api/suggestions",
                headers: {
                    'Content-Type': undefined, //not 'multipart/form-data'
                    "Authorization": legalRequestKey
                },
                data: {
                    file: $scope.file,
                    suggestion: JSON.stringify(data)
                },
                transformRequest: function (data, headersGetter) {
                    var formData = new FormData();
                    angular.forEach(data, function (value, key) {
                        if (key == "suggestion")
                            formData.append(key, new Blob(
                                [value],
                                {type: "application/json"}
                                )
                            );
                        else
                            formData.append(key, value);
                    });
                    var headers = headersGetter();
                    delete headers['Content-Type'];
                    return formData;
                }
            }).then(function () {
                $scope.suggestionSendResult.sent = true;
                $scope.suggestionSendResult.successfully = true;
                $scope.suggestionSendResult.message = "Ваше предложение успешно отправлено и будет добавлено в документы после модерации.";
                $scope.document = {
                    title: "",
                    summary: "",
                    url: "",
                    email: "",
                    tags: {}
                };
                $scope.tag = "";
                $scope.invalidFields = {};
                nanobar.go(100);
            }, function (response) {
                $scope.suggestionSendResult.sent = true;
                $scope.suggestionSendResult.successfully = false;
                $scope.invalidFields = {};
                nanobar.go(100);
                if (response.status == 500) {
                    $scope.suggestionSendResult.message = "Упс, что-то пошло не так, но мы всё скоро исправим!";
                } else if (response.status == 400) {
                    for (var i = 0; i < response.data.length; i++) {
                        var key = response.data[i].path.replace("SuggestionRestService.create.arg0.", "");
                        if (key in $scope.suggestDocumentForm) {
                            $scope.suggestDocumentForm[key].$setValidity("httpvalidator", false);
                            $scope.invalidFields[key] = response.data[i].message;
                        }
                    }
                    $scope.suggestionSendResult.message = "Некорректный формат данных.";
                    var form = document.forms[$scope.suggestDocumentForm.$name];
                    setTimeout(function () {
                        form.reportValidity();
                    }, 0);
                } else {
                    $scope.suggestionSendResult.message = response.statusText;
                }
            });
        }
    }
})();