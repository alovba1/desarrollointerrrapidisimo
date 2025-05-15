using Credito.Domain.Model;
using System.Data;
using System.Data.SqlClient;

namespace Credito.DrivenAdapters.SqlServer
{
    public class CreditoImpl
    {
        public List<Credito.Domain.Model.Credito> ListarCreditos()
        {
            var lista = new List<Credito.Domain.Model.Credito>();
            var cn = new Connection();
            using (var conect = new SqlConnection(cn.getCadenaSql()))
            {
                conect.Open();
                SqlCommand cmd = new SqlCommand("spListCredito", conect);
                cmd.CommandType = CommandType.StoredProcedure;

                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        lista.Add(new Credito.Domain.Model.Credito
                        {
                            Id = Convert.ToInt32(dr["Id"]),
                            TotalCredito = Convert.ToDecimal(dr["TotalCredito"])
                        });
                    }
                }
            }
            return lista;
        }
    }
}
