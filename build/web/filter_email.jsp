<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : greeting
    Created on : Feb 28, 2017, 2:17:05 PM
    Author     : admin
--%>

<!DOCTYPE html>
<html lang="en"  ng-app="app">
    <head>
        <meta charset="UTF-8">
        <title>Lọc email</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>

        <link href="css/main.css" rel="stylesheet" type="text/css"/>
        <script src="js/module/app.js" type="text/javascript"></script>
        <script src="js/controller/FilterEmailController.js" type="text/javascript"></script>


        <script type="text/javascript">
            window.fbAsyncInit = function () {
                $('#tokenStatus').html('<img src=\'images/ajax-loader.gif\' />');
                FB.init({
                    appId: '144047682858395',
                    xfbml: true,
                    version: 'v2.8'
                });
                FB.AppEvents.logPageView();
                FB.getLoginStatus(function (response) {
                    if (response.status === 'connected') {
                        FB.api(
                                '/' + $('#txtPageID').val(),
                                'GET',
                                {"fields": "access_token"},
                        function (response) {
                            console.log(response);
                            $('#txtToken').val(response.access_token);
                        });
                        $('#tokenStatus').html('<label class="label label-success">Đã kết nối</label>');
                    } else {
                        $('#tokenStatus').html('<label class="label label-danger">Lỗi kết nối</label>');
                    }

                });
            };
            (function (d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) {
                    return;
                }
                js = d.createElement(s);
                js.id = id;
                js.src = "//connect.facebook.net/en_US/sdk.js";
                fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));
        </script>

    </head>
    <body>
        <div class="container" ng-controller="FilterEmailCtrl">
            <div style="text-align: center">
                <img style="vertical-align: center; max-height: 100px;" src="images/logo.png" alt=""/>
                <div class="col-md-12"  style="text-align: center">
                    <ul class="nav nav-tabs">
                        <li><a href="">Trang chủ</a></li>
                        <li><a href="">Giới thiệu</a></li>
                        <li><a href="">Liên hệ</a></li>
                    </ul>
                </div>
            </div>

            <hr/>    




            <div class="panel panel-primary" style="margin-top: 50px    ">
                <div class="panel-heading">
                    <div class="panel-title">Trạng thái <label id="lbPageStatus" class="label"></label></div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-2 right">Page hiện tại</div>
                        <div class="col-md-7">
                            <input id="txtPageID" type="text" class="form-control " value="1743490559227498">
                        </div>
                        <div class="col-md-3">
                            <span id="tokenStatus"></span>
                        </div>
                    </div>
                    <br/>
                    <div class="row">
                        <div class="col-md-2 right">Token</div>
                        <div class="col-md-7">
                            <input type="text" class="form-control disable" ng-model="token">
                        </div>

                        <div class="col-md-3">
                            <button class="btn btn-primary" id="btnGetToken">Lấy token</button>
                        </div>
                    </div>
                    <br/>
                    
                </div>
            </div>

            <div class="panel panel-primary">
                <div class="panel-heading">
                    <div class="panel-title">Lọc email - sdt trong bài post </div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-2 right">ID bài post cần lọc</div>
                        <div class="col-md-7">
                            <input ng-model="post_id" type="text" class="form-control">
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary" ng-click="get_comment()">Lọc</button> 
                        </div>
                    </div>
                    <hr>
                    <div class="form-group" style="text-align: center">
                        <img src="images/ajax-load-vertical.gif" alt=""/>
                    </div>
                    <div class="row">
                        <p class="text-center h3"> Kết quả lọc</p>
                    </div>

                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">Tổng email lọc được:</label>
                            <div class="col-sm-9">
                                <label id="email_total">
                                    {{total_email_count}}
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">Số comment có email: </label>
                            <div class="col-sm-9">
                                <label id="email_percent">
                                    {{total_comment_have_email}} / {{total_comment}}
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">Coppy : </label>
                            <div class="col-sm-9">
                                <input id="email_strings" type="text" class="form-control" ng-bind="email_strings">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <hr>

            <footer class="footer" style="font-size:12px; text-align: center;">
                <p style="font-size:13px;">Bản quyền thuộc <b>Mr Bio</b> © 2017 - Cập nhật lần cuối: 31/08/2017</p>
                <p style="font-size:13px;">Liên hệ, báo lỗi, trợ giúp <strong>Inbox</strong>  <a href="https://www.facebook.com/dominhphong.18" target="_blank">Tại đây </a></p>
            </footer>


        </div>

    </body>
</html> 