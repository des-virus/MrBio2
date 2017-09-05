app.factory('WeekService', function ($http, $q, $log, $rootScope) {
    var factory = {};

    //<editor-fold defaultstate="collapsed" desc="Get: pages, companies">
    factory.getWeek = function () {
        return  $http.get('Week').then(
                function (response) {
                    return response.data;
                },
                function (response) {
                    $log.error(response.data);
                }
        );
    };
    
     
    //</editor-fold>


    

    return factory;
});