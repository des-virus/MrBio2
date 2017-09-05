function extractEmails(text)
{
    return text.match(/([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9._-]+)/gi);
}



var func_get_post_comment = function (response) {
    var posts = response.data;
    for (var i = 0; i < posts.length; i++) {
        $('#bodyPost').append('<tr><td>ID: <b>' + posts[i].id + '</b><br/><p>Nội dung:<b> ' + posts[i].message + '</span></b></td><td id=\"' + posts[i].id + '\"> </td></tr>');
        getComment(posts[i].id);
    }
    if (posts.length > 0) {
        nextPage = response.paging.next;
        $.get(nextPage, func_get_post_comment, "json");
    }
};
var func_filter_email_phone = function (response) {
    console.log(response);
    var comments = response.data;
    if (!isUndefined(comments)) {
        for (var i = 0; i < comments.length; i++) {
            var emails = '';
            if (extractEmails(comments[i].message) !== null) {
                emails = extractEmails(comments[i].message).join(', ');
            }
            $('#bodyFilter').append('<tr><td id=\"' + comments[i].id + '\">ID: <b>' + comments[i].id + '</b><br/>Tên:<b>' + comments[i].from.name + '</b><br/><p>Nội dung:<b> ' + comments[i].message + '</span></b></td><td id=\"email' + comments[i].id + '\">' + emails + '</td><td>' + '</td></tr>');
            FB.api(
                    '/' + comments[i].id + '/comments',
                    'GET',
                    {},
                    function (response) {
                        var getCommentReplies = function (response) {

                            var replies = response.data;
                            for (var i = 0; i < replies.length; i++) {
                                var emails = '';
                                if (extractEmails(replies[i].message) !== null) {
                                    emails = extractEmails(replies[i].message).join(', ');
                                }
                                $('#' + comments[i].id).append(' <b><span id=\"' + replies[i].id + '\"> ---> ' + replies[i].from.name + '</span></b>: ' + replies[i].message + '<br/>');
                                $('#email' + comments[i].id).append(', ' + emails);
                            }
                            if (replies.length > 0) {
                                nextPage = response.paging.next;
                                $.get(nextPage, getCommentReplies, "json"); //optional: $.getJSON can be use instead
                            }
                        };
                        var replies = response.data;
                        console.log('get replies');
                        console.log(response);
                        for (var i = 0; i < replies.length; i++) {
                            var emails = '';
                            if (extractEmails(replies[i].message) !== null) {
                                emails = extractEmails(replies[i].message).join(', ');
                            }
                            $('#' + comments[i].id).append(' <b><span id=\"' + replies[i].id + '\"> ---> ' + replies[i].from.name + '</span></b>: ' + replies[i].message + '<br/>');
                            $('#email' + comments[i].id).append(', ' + emails);
                        }
                        if (replies.length > 0) {
                            nextPage = response.paging.next;
                            $.get(nextPage, getCommentReplies, "json"); //optional: $.getJSON can be use instead
                        }
                    });
        }
        if (comments.length > 0) {
            nextPage = response.paging.next;
            $.get(nextPage, func_filter_email_phone, "json");
        }
    }
};

function getComment(postID) {
    var comments = [];
    FB.api(
            postID + '/comments',
            'GET',
            {},
            function (response) {

                var getComment = function (response) {
                    comments = comments.concat(response.data);
                    
                    if (comments.length > 0) {
                        nextPage = response.paging.next;
                        $.get(nextPage, getComment, "json"); //optional: $.getJSON can be use instead
                    }
                };
                comments = response.data;
                
                if (comments.length > 0) {
                    nextPage = response.paging.next;
                    $.get(nextPage, getComment, "json"); //optional: $.getJSON can be use instead
                }
                
                console.log(comments);
            });
}
function getCommentReply(commentID) {
    FB.api(
            '/' + commentID + '/comments',
            'GET',
            {},
            function (response) {
                var getCommentReplies = function (response) {
                    var comments = response.data;
                    for (var i = 0; i < comments.length; i++) {
                        $('#' + commentID).append('<b><span id=\"' + comments[i].id + '\"> ---> ' + comments[i].from.name + '</span></b>: ' + comments[i].message + '<br/>');
                        $.ajax({
                            type: 'POST',
                            url: 'TestServlet',
                            data: {'mode': 'insert_comment',
                                'customer_id': comments[i].from.id,
                                'customer_name': comments[i].from.name,
                                'comment_id': comments[i].id,
                                'comment_parent_id': commentID,
                                'post_id': '',
                                'comment_content': comments[i].message,
                                'comment_date': comments[i].created_time,
                                'comment_type': '0',
                                'comment_status': '1',
                                'order_id': '0'},
                            success: function (response) {
                                console.log('success');
                            },
                            error: function () {
                                console.log('error');
                            }
                        });
                    }
                    if (comments.length > 0) {
                        nextPage = response.paging.next;
                        $.get(nextPage, getCommentReplies, "json"); //optional: $.getJSON can be use instead
                    }
                };
                var comments = response.data;
                for (var i = 0; i < comments.length; i++) {
                    $('#' + commentID).append(' <b><span id=\"' + comments[i].id + '\"> ---> ' + comments[i].from.name + '</span></b>: ' + comments[i].message + '<br/>');
                    $.ajax({
                        type: 'POST',
                        url: 'TestServlet',
                        data: {'mode': 'insert_comment',
                            'customer_id': comments[i].from.id,
                            'customer_name': comments[i].from.name,
                            'comment_id': comments[i].id,
                            'comment_parent_id': commentID,
                            'post_id': '',
                            'comment_content': comments[i].message,
                            'comment_date': comments[i].created_time,
                            'comment_type': '0',
                            'comment_status': '1',
                            'order_id': '0'},
                        success: function (response) {
                            console.log('success');
                        },
                        error: function () {
                            console.log('error');
                        }
                    });
                }
                if (comments.length > 0) {
                    nextPage = response.paging.next;
                    $.get(nextPage, getCommentReplies, "json"); //optional: $.getJSON can be use instead
                }
            });
}