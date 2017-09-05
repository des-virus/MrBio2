<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : greeting
    Created on : Feb 28, 2017, 2:17:05 PM
    Author     : admin
--%>

<!DOCTYPE html>
<html lang="en" ng-app="app">
    <head>
        <meta charset="UTF-8">
        <title>Lọc email</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>


        <link href="css/main.css" rel="stylesheet" type="text/css"/>
        <script src="js/module/app.js" type="text/javascript"></script>
        <script src="js/controller/IndexController.js" type="text/javascript"></script>

        <script type="text/javascript">
            window.fbAsyncInit = function () {
                FB.init({
                    appId: '144047682858395',
                    xfbml: true,
                    version: 'v2.8'
                });
                FB.AppEvents.logPageView();
                FB.getLoginStatus(function (response) {
                    if (response.status == 'connected') {
                        //window.location.href = "filter_email.jsp";
                    } else {

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
                js.src = "//connect.facebook.net/vi_VN/sdk.js";
                fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));


            function myCallback(response) {
                console.log(response);
            }

            function login() {
                FB.login(function (response) {
                    if (response.status == 'connected') {
                        //window.location.href = "filter_email.jsp";
                    }
                }, {scope: 'public_profile, email, publish_pages, pages_messaging, publish_actions, manage_pages, read_page_mailboxes'});
            }
        </script>

    </head>
    <body>
        <div class="container" ng-controller="IndexCtrl">
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




            <div class="panel panel-primary" style="margin-top: 50px">
                <div class="panel-heading">
                    <div class="panel-title"><i class="fa fa-magic" aria-hidden="true"></i>   Cấp quyền cho ứng dụng</div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="text-center">
                            Đang kiểm tra trạng thái đăng nhập
                        </div>
                    </div>
                    <div class="row" id="check">
                        <div class="form-group" style="text-align: center">
                            <img src="images/ajax-load-vertical.gif" alt=""/>
                        </div>
                    </div>
                    <div class="row" ng-show="">
                        <div class="col-xs-12" style="text-align: center">
                            <div id="status">Để tiếp tục sử dụng bạn vui lòng nhấn vào nút "<strong>tiếp tục</strong>".<br><img src="images/down.gif"></div>
                            <center>
                                <div class="btn btn-primary" onclick="login()"> Tiếp tục</div>
                            </center>
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