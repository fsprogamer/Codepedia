using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Web.Configuration;

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod]
    public static string GetCurrentTime(string name)
    {
        return "Hello " + name + Environment.NewLine + "The Current Time is: " 
        + DateTime.Now.ToString();
    }
    [System.Web.Services.WebMethod]
    public static string ServerSideMethod() {
        return "Message from server.";
    }
    //Created a class 
    public class Cars
    {
        public string carName;
        public string carRating;
        public string carYear;
    }

    [System.Web.Services.WebMethod]
    public static List<Cars> getListOfCars(List<string> aData)
    {
        SqlDataReader dr;
        List<Cars> carList = new List<Cars>();

        using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["constr"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "spGetCars";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@makeYear", aData[0]);
                con.Open();
                dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        string carname = dr["carName"].ToString();
                        string carrating = dr["carRating"].ToString();
                        string makingyear = dr["carYear"].ToString();

                        carList.Add(new Cars
                        {
                            carName = carname,
                            carRating = carrating,
                            carYear = makingyear
                        });
                    }
                }
            }
        }
        return carList;
    }
}

/*
  $(document).ready(function () {
              $('#<%=Button1.ClientID %>').click(function () {
               $.ajax({
                      type: "POST",
                      url: "CS.aspx/getListOfCars",
                      data: "{'aData': '2014'}",
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      async: true,
                      cache: false,
                      success: function (msg) {
                          $('#contentHolder').text(msg.d);
                     }
                 })
                 return false;
             });
        });

*/
