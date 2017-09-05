function extractEmails(text)
{
    return text.match(/([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9._-]+)/gi);
}

function isUndefined(obj) {
    if (obj === 'undefined' && typeof obj === 'undefined') {
        return true;
    }
    return false;
}


app.controller('FilterEmailCtrl', function ($scope, $rootScope, $filter) {
    $scope.token = '';
    $scope.emails = [];
    $scope.email_strings = '';
    $scope.email_display = '';
    $scope.total_comment_have_email = 0;
    $scope.total_comment = 0;
    $scope.total_email_count = 0;
    $scope.post_id = '1743490559227498_1869480176628535';

    $scope.get_comment = function () {
        $scope.emails = [];
        $scope.email_strings = '';
        $scope.total_comment_have_email = 0;
        $scope.total_comment = 0;
        $scope.total_email_count = 0;

        var func_filter_email_phone = function (response) {
            var comments = response.data;
            if (!isUndefined(comments)) {
                for (var i = 0; i < comments.length; i++) {
                    $scope.total_comment++;
                    if (extractEmails(comments[i].message) !== null) {
                        $scope.emails = $scope.emails.concat(extractEmails(comments[i].message));
                        $scope.total_comment_have_email++;
                    }
                }
                if (comments.length > 0) {
                    var nextPage = response.paging.next;
                    $.get(nextPage, func_filter_email_phone, "json");
                }
            }
             $scope.total_email_count = $scope.emails.length;
            $('#email_total').html($scope.total_email_count);
            $('#email_strings').val($scope.emails.join(', '));
            $('#email_percent').html($scope.total_email_count + ' / ' + $scope.total_comment);
            $scope.email_strings = $scope.emails.join(', ');

            console.log("start log total email: " + $scope.email_strings);
        };

        FB.api($scope.post_id + '/comments',
                'GET',
                {},
                func_filter_email_phone
                );

        setTimeout(function () {

        }, 3000);
    };



});
