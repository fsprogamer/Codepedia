using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Web.Configuration;

namespace Codepedia
{
    public partial class myFunction : System.Web.UI.Page
    {
        //Created a class 
        public class Cars
        {
            public string carName;
            public string carRating;
            public string carYear;
        }

        [System.Web.Services.WebMethod]
        public List<Cars> getListOfCars(List<string> aData)
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

        //protected void Page_Load(object sender, EventArgs e)
        //{

        //}
    }
}