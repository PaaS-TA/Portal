<%@page contentType="text/html" pageEncoding="UTF-8" %>
<div style="margin: 0px; border: 1px solid #dddddd;">
    <div style="height: 50px; background-color: #f5f7f8; line-height: 50px;">
        <div style=" float: left; margin-left: 20px;font-weight: bold;">
            로그
        </div>
        <div style=" float: right">
            <div style="margin-right: 20px;"><a href="#none" onClick="LogTabinit();"><span
                    class="glyphicon glyphicon-refresh" aria-hidden="true"></span></a></div>
        </div>
    </div>
    <div id="addRouteBox" style="background-color: white; margin-left: 20px; margin-bottom: 10px;">
        <div id="log" style="margin-left: 5px;font-size: small;color:#979696">
        </div>
    </div>
</div>
<script>
    var $log = $("#log"),
            str,
            html;

    function LogTabinit() {

        var param = {
            guid: currentAppGuid,
            name: currentApp
        };
        var options = {
            url: "/log/getRecentLogs",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                $log.empty();

                $.each(data.log, function (key, dataobj) {

                    str = dataobj + '<br>';
                    html = $.parseHTML(str);
                    $log.append(html);
                });
            },
            error: function (xhr, status, error) {
                //alert("xhr:"+xhr+",status:"+status+ ",error:"+error);
                showAlert("fail", JSON.parse(xhr.responseText).message);
            },
            complete: function () {
                showAlert('success', currentApp + "의 최근로그를 조회하였습니다.");
            }

        };
        $.ajax(options);
    }
</script>