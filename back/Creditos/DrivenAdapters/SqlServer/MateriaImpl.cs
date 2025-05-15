
using Credito.Domain.Model;
using System.Data;
using System.Data.SqlClient;

namespace Credito.DrivenAdapters.SqlServer
{
    public class MateriaImpl
    {
        public List<Credito.Domain.Model.Materia> ListarMaterias()
        {
            var lista = new List<Credito.Domain.Model.Materia>();
            var cn = new Connection();

            using (var conect = new SqlConnection(cn.getCadenaSql()))
            {
                conect.Open();
                SqlCommand cmd = new SqlCommand("spListMateria", conect);
                cmd.CommandType = CommandType.StoredProcedure;

                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        lista.Add(new Credito.Domain.Model.Materia
                        {
                            Id = Convert.ToInt32(dr["Id"]),
                            Nombre = dr["Nombre"].ToString(),
                            ProfesorId = Convert.ToInt32(dr["ProfesorId"])
                        });
                    }
                }
            }
            return lista;
        }
    }
}
