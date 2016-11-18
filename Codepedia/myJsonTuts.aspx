<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="myJsonTuts.aspx.cs" Inherits="Codepedia.myJsonTuts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="scripts/jquery-2.2.3.min.js" type="text/javascript"></script>
    <script type="text/javascript">      
            function ShowCurrentTime() {
                $.ajax({
                    type: "POST",
                    url: "CS.aspx/GetCurrentTime",
                    data: '{name: "' + $("#<%=txtUserName.ClientID%>")[0].value + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response.d);
                }
            });
        }
            function OnSuccess(response) {
                alert(response.d);
            }
            function OnErrorCall(response) { alert(error); }
    </script>
    <script type="text/javascript">
        $("#myButton").on("click", function (e) {
            e.preventDefault();
            var aData= [];
            aData[0] = $("#ddlSelectYear").val(); 
            $("#contentHolder").empty();
            var jsonData = JSON.stringify({ aData:aData});
            $.ajax({
                type: "POST",
                //getListOfCars is my webmethod   
                url: "myFunction.asmx/getListOfCars", 
                data: jsonData,
                contentType: "application/json; charset=utf-8",
                dataType: "json", // dataType is json format
                success: OnSuccess,
                error: OnErrorCall
            });
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <select id="ddlSelectYear">
                <option>2014</option>
                <option>2015</option>
            </select>
            <button id="myButton">Get Car Lists</button>
            <div id="contentHolder"></div>
        </div>

        <div>
            Your Name : 
            <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
            <input id="btnGetTime" type="button" value="Show Current Time"
                onclick="ShowCurrentTime()" />
        </div>
    </form>
</body>
</html>
