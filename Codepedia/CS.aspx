﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CS.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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

  $(document).ready(function () {
      $('#Button1').click(function (e) {
      e.preventDefault();
      var aData= [];
      aData[0] = $("#ddlSelectYear").val(); 
      $("#contentHolder").empty();
      var jsonData = JSON.stringify({ aData:aData});
      $.ajax({
          type: "POST",
          //getListOfCars is my webmethod   
          url: "CS.aspx/getListOfCars",
          data: jsonData,
          contentType: "application/json; charset=utf-8",
          dataType: "json", // dataType is json format
          success: OnGetList,
          error: OnErrorCall
      });
    });
  });

  function OnErrorCall(response) { console.log(error); }

  function OnGetList(response) {
      var items = response.d;
      var fragment = "<ul>"
      $.each(items, function (index, val) {

          var carName = val.carName;
          var carRating = val.carRating;
          var carYear = val.carYear;
          fragment += "<li> " + carName + " :: " + carRating + " - " + carYear + "</li>";
      });
      $("#contentHolder").append(fragment);
  }

    </script>   
</head>
<body style="font-family: Arial; font-size: 10pt">
    <form id="form1" runat="server">
        <div>
            Your Name : 
           
            <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
            <input id="btnGetTime" type="button" value="Show Current Time"
                onclick="ShowCurrentTime()" />
        </div>

        <div>
            <select id="ddlSelectYear">
                <option>2014</option>
                <option>2015</option>
            </select>
            <asp:Button ID="Button1" runat="server" Text="Button" />
            &nbsp;
       <div id="contentHolder">
       </div>
        </div>
    </form>
</body>
</html>
