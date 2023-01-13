//Model Class
using Microsoft.AspNetCore.Mvc;
using Npgsql;
using System.Data;
using WebApplication6.Models;
using WebApplication6.RepositoryLayer;
using WebApplication6.ServiceLayer;

namespace WebApplication6.Models
{
    public class PatientList
    {
        public List<Patient>? PatientdataList { get; set; }
    }

    public class Patient
    {
        public string? First_Name { get; set; } = null;
        public string? Middle_Name { get; set; } = null;
        public string? Last_Name { get; set; } = null;
        public DateTime? DOB { get; set; } = null;
        public int? SEX { get; set; } = null;

        private bool is_deleted { get; }
        private DateTime? CreatedOn { get; }
        private DateTime? ModifiedOn { get; }
    }

    public class RequestPatientData
    {
        public int? Patient_id { get; set; } = null;
        public string? First_Name { get; set; } = null;
        public string? Middle_Name { get; set; } = null;
        public string? Last_Name { get; set; } = null;
        public DateTime? DOB { get; set; } = null;
        public int? SEX { get; set; } = null;
        public int? PageNumber { get; set; } = null;
        public int? PageSize { get; set; } = null;
        public string? OrderBy { get; set; } = null;

    }
}


//Repository Layer

//Repository Layer class file

using WebApplication6.Models;
using Microsoft.AspNetCore.Mvc;
using Npgsql;
using System.Data;

namespace WebApplication6.RepositoryLayer
{
    public class WebApplicationRL : IWebApplicationRL
    {
        private readonly IConfiguration _configuration;
        private string sqlDataSource;
        public WebApplicationRL(IConfiguration configuration)
        {
            _configuration = configuration;
            sqlDataSource = _configuration.GetConnectionString("DBcon");
        }

        public Task<PatientList> Get(int id)
        {
            PatientList pl = new PatientList
            {
                PatientdataList = new List<Patient>()
            };

            DataTable table = new();
            try
            {
                string query = @"
                    select * from patientget(@id)
                ";

                NpgsqlDataReader myReader;
                using (NpgsqlConnection myCon = new NpgsqlConnection(sqlDataSource))
                {
                    myCon.Open();
                    using (NpgsqlCommand myCommand = new NpgsqlCommand(query, myCon))
                    {
                        myCommand.Parameters.AddWithValue("id", id);
                        myReader = myCommand.ExecuteReader();
                        table.Load(myReader);

                        for (int i = 0; i < table.Rows.Count; i++)
                        {
                            DataRow dr = table.Rows[i];
                            pl.PatientdataList.Add(new Patient
                            {
                                First_Name = dr["fname"].ToString(),
                                Middle_Name = dr["mname"].ToString(),
                                Last_Name = dr["lname"].ToString(),
                                DOB = DateTime.Parse(dr["dob"].ToString()),
                                SEX = (int)dr["SEX"]
                            });
                        }

                        myReader.Close();
                        myCon.Close();
                    }

                }
            }
            catch (Exception ex)
            {
                //return Task.FromResult(new JsonResult(ex));
            }
            return Task.FromResult(pl);
        }


        public Task<int> Post(Patient pd)
        {
            string query = @"
                select patientcreate(@fname, @mname, @lname, @dob::date, @sex_type_id)
            ";

            int id;
            NpgsqlDataReader myReader;
            using (NpgsqlConnection myCon = new NpgsqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (NpgsqlCommand myCommand = new NpgsqlCommand(query, myCon))
                {
                    //Values to be inserted in patient record
                    myCommand.Parameters.AddWithValue("fname", pd.First_Name);
                    myCommand.Parameters.AddWithValue("mname", pd.Middle_Name);
                    myCommand.Parameters.AddWithValue("lname", pd.Last_Name);
                    myCommand.Parameters.AddWithValue("dob", pd.DOB);
                    myCommand.Parameters.AddWithValue("sex_type_id", pd.SEX);

                    myReader = myCommand.ExecuteReader();
                    myReader.Read();

                    id = (int)myReader[0];

                    myReader.Close();
                    myCon.Close();
                }
            }
            return Task.FromResult(id);
        }

        public Task<int> Put(int id, Patient pd)
        {
            string query = @" 
                 select patientupdate(@id, @fname, @mname, @lname, @dob::date, @sex_type_id)
            ";

            int ids;
            NpgsqlDataReader myReader;
            string sqlDataSource = _configuration.GetConnectionString("DBcon");
            using (NpgsqlConnection myCon = new NpgsqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (NpgsqlCommand myCommand = new NpgsqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("id", id);
                    myCommand.Parameters.AddWithValue("fname", pd.First_Name);
                    myCommand.Parameters.AddWithValue("mname", pd.Middle_Name);
                    myCommand.Parameters.AddWithValue("lname", pd.Last_Name);
                    myCommand.Parameters.AddWithValue("dob", pd.DOB);
                    myCommand.Parameters.AddWithValue("sex_type_id", pd.SEX);

                    myReader = myCommand.ExecuteReader();
                    myReader.Read();
                    ids = (int)myReader[0];

                    myReader.Close();
                    myCon.Close();
                }
            }
            return Task.FromResult(ids);
        }

        public Task<JsonResult> Delete(int id)
        {
            string query = @"
                select patientdelete(@id)
            ";

            string sqlDataSource = _configuration.GetConnectionString("DBcon");
            using (NpgsqlConnection myCon = new NpgsqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (NpgsqlCommand myCommand = new NpgsqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("id", id);
                    myCommand.ExecuteReader();

                    myCon.Close();
                }
            }
            return Task.FromResult(new JsonResult("Deleted Sccessfully!"));
        }


        public async Task<JsonResult> Get(RequestPatientData rpd)
        {
            string query = @"
                   select * from get_patient_info(patient_id=>@id, fname=>@fname, lname=>@lname, dob=>@dob, sex_type_id=@sex_type_id,
                   pagenumber=@pagenumber, pagesize=>@pagesize, orderby=>@orderby)";

            System.Console.WriteLine("\n\n\n\n", query + "\n\n\n\n");

            DataTable table = new DataTable();
            NpgsqlDataReader myReader;
            using (NpgsqlConnection myCon = new NpgsqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (NpgsqlCommand myCommand = new NpgsqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("id", rpd.Patient_id == null ? DBNull.Value : rpd.Patient_id);
                    myCommand.Parameters.AddWithValue("fname", rpd.First_Name == null || rpd.First_Name == "" ? DBNull.Value : rpd.First_Name);
                    myCommand.Parameters.AddWithValue("mname", rpd.Middle_Name == null || rpd.Middle_Name == "" ? DBNull.Value : rpd.Middle_Name);
                    myCommand.Parameters.AddWithValue("lname", rpd.Last_Name == null || rpd.Last_Name == "" ? DBNull.Value : rpd.Last_Name);
                    myCommand.Parameters.AddWithValue("dob", rpd.DOB == null ? DBNull.Value : rpd.DOB);
                    myCommand.Parameters.AddWithValue("sex_type_id", rpd.SEX == null ? DBNull.Value : rpd.SEX);

                    myCommand.Parameters.AddWithValue("pagenumber", rpd.PageNumber == null ? DBNull.Value : rpd.PageNumber);
                    myCommand.Parameters.AddWithValue("pagesize", rpd.PageSize == null ? DBNull.Value : rpd.PageSize);
                    myCommand.Parameters.AddWithValue("orderby", rpd.OrderBy == null || rpd.OrderBy == "" ? DBNull.Value : rpd.OrderBy);
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);

                    myReader.Close();
                    myCon.Close();
                }
            }
            return new JsonResult(table);
        }

    }
}

//Repository Layer Interface File
using WebApplication6.Models;
using Microsoft.AspNetCore.Mvc;

namespace WebApplication6.RepositoryLayer
{
    public interface IWebApplicationRL
    {
        public Task<PatientList> Get(int id);

        public Task<int> Post(Patient pd);
        public Task<int> Put(int id, Patient pd);
        public Task<JsonResult> Delete(int id);

        public Task<JsonResult> Get(RequestPatientData rpd);
    }
}

//Service Layer
//Service Layer Class File

using WebApplication6.RepositoryLayer;
using WebApplication6.Models;
using Microsoft.AspNetCore.Mvc;

namespace WebApplication6.ServiceLayer
{
    public class WebApplicationSL : IWebApplicationSL
    {
        public readonly IWebApplicationRL _webApplicationRL;
        public WebApplicationSL(IWebApplicationRL webApplicationRL)
        {
            _webApplicationRL = webApplicationRL;
        }

        public async Task<PatientList> Get(int id)
        {
            return await _webApplicationRL.Get(id);
        }

        public async Task<int> Post(Patient pd)
        {
            return await _webApplicationRL.Post(pd);
        }

        public async Task<int> Put(int id, Patient pd)
        {
            return await _webApplicationRL.Put(id, pd);
        }
        public async Task<JsonResult> Delete(int id)
        {
            return await _webApplicationRL.Delete(id);
        }
        public async Task<JsonResult> Get(RequestPatientData rpd)
        {
            return await _webApplicationRL.Get(rpd);
        }
    }
}

//Service Layer Interface File

using WebApplication6.Models;
using Microsoft.AspNetCore.Mvc;

namespace WebApplication6.ServiceLayer
{
    public interface IWebApplicationSL
    {
        public Task<PatientList> Get(int id);

        public Task<int> Post(Patient pd);
        public Task<int> Put(int id, Patient pd);
        public Task<JsonResult> Delete(int id);

        public Task<JsonResult> Get(RequestPatientData rpd);
    }
}

// Controller File

using WebApplication6.Models;
using WebApplication6.ServiceLayer;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Npgsql;
using System.Data;
using System.Xml.Linq;
using WebApplication6.RepositoryLayer;

namespace WebApplication6.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class WebApplicationController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        public readonly IWebApplicationSL _WebApplicationSL;

        public WebApplicationController(IConfiguration configuration, IWebApplicationSL WebApplicationSL)
        {
            _configuration = configuration;
            _WebApplicationSL = WebApplicationSL;
        }



        //Fetch patient detail using id
        [HttpGet("{id}")]
        public async Task<PatientList> Get(int id)
        {
            //try
            // {
            return await _WebApplicationSL.Get(id);
            // }
            // catch (Exception ex)
            // {
            //     return ex;
            // }
        }


        //Insert patient record
        [HttpPost]
        public async Task<int> Post(Patient pd)
        {
            //try
            //{
            return await _WebApplicationSL.Post(pd);
            //}
            //catch (Exception ex)
            //{
            //    return new JsonResult(ex);
            // }
        }

        // Update patient record using id
        [HttpPut("{id}")]
        public async Task<int> Put(int id, Patient pd)
        {
            //try
            //{
            return await _WebApplicationSL.Put(id, pd);
            //}
            //catch (Exception ex)
            //{
            //    return new JsonResult(ex);
            //}
        }

        // Delete patient record using id
        [HttpDelete("{id}")]
        public async Task<JsonResult> Delete(int id)
        {
            try
            {
                return new JsonResult(await _WebApplicationSL.Delete(id));
            }
            catch (Exception ex)
            {
                return new JsonResult(ex);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <param name="pagenumber"></param>
        /// <param name="pagesize"></param>
        /// <param name="sex_type_id"></param>
        /// <param name="fname"></param>
        /// <param name="lname"></param>
        /// <param name="dob"></param>
        /// <param name="orderby"></param>
        /// <returns></returns>
        [HttpGet]
        public async Task<JsonResult> Get(RequestPatientData rpd)
        {
            try
            {
                return new JsonResult(await _WebApplicationSL.Get(rpd));
            }
            catch (Exception ex)
            {
                return new JsonResult(ex);
            }
        }

    }
}










