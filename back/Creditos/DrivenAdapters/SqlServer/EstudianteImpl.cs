using Credito.Domain.Model;
using System.Data;
using System.Data.SqlClient;

namespace Credito.DrivenAdapters.SqlServer
{
    public class EstudianteImpl
    {

        public bool SaveEstudiante(Estudiante estudiante)
        {
            bool rpta;
            try
            {
                var cn = new Connection();
                using (var conect = new SqlConnection(cn.getCadenaSql()))
                {
                    conect.Open();
                    SqlCommand cmd = new SqlCommand("spSaveEstudiante", conect);

                    cmd.Parameters.AddWithValue("Nombre", estudiante.Nombre);
                    cmd.Parameters.AddWithValue("CreditoId", estudiante.CreditoId);
                    //cmd.Parameters.AddWithValue("MateriaId", estudiante.MateriaId);


                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();

                }
                rpta = true;
            }
            catch (Exception e)
            {
                string error = e.Message;
                rpta = false;
            }
            return rpta;
        }

        public List<Estudiante> listEstudiante()
        {
            var varList = new List<Estudiante>();
            var cn = new Connection();
            using (var conect = new SqlConnection(cn.getCadenaSql()))
            {
                conect.Open();
                SqlCommand cmd = new SqlCommand("spListEstudiante", conect);
                cmd.CommandType = CommandType.StoredProcedure;
                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        varList.Add(new Estudiante()
                        {
                            Id = Convert.ToInt32(dr["Id"]),
                            Nombre = dr["Nombre"].ToString()
                            
                        }
                        );
                    }
                }

            }
            return varList;
        }

        public bool UpdateEstudiante(Estudiante estudiante)
        {
            bool rpta;
            try
            {
                var cn = new Connection();
                using (var conect = new SqlConnection(cn.getCadenaSql()))
                {
                    conect.Open();
                    SqlCommand cmd = new SqlCommand("spUpdateEstudiante", conect);

                    cmd.Parameters.AddWithValue("Id", estudiante.Id);
                    cmd.Parameters.AddWithValue("Nombre", estudiante.Nombre);

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                }
                rpta = true;
            }
            catch (Exception e)
            {
                string error = e.Message;
                rpta = false;
            }
            return rpta;
        }

        public bool DeleteEstudiante(int id)
        {
            bool rpta;
            try
            {
                var cn = new Connection();
                using (var conect = new SqlConnection(cn.getCadenaSql()))
                {
                    conect.Open();
                    SqlCommand cmd = new SqlCommand("spDeleteEstudiante", conect);

                    cmd.Parameters.AddWithValue("Id", id);

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                }
                rpta = true;
            }
            catch (Exception e)
            {
                string error = e.Message;
                rpta = false;
            }
            return rpta;
        }

        public bool SaveEstudianteConMaterias(string nombre, int creditoId, List<int> materiaIds)
        {
            bool rpta;
            try
            {
                var cn = new Connection();
                using (var conect = new SqlConnection(cn.getCadenaSql()))
                {
                    conect.Open();

                    // 1. Guardar el estudiante y obtener el ID generado
                    SqlCommand cmd = new SqlCommand("spSaveEstudiante", conect);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Nombre", nombre);
                    cmd.Parameters.AddWithValue("@CreditoId", creditoId);

                    SqlParameter outputId = new SqlParameter("@IdEstudiante", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(outputId);

                    cmd.ExecuteNonQuery();
                    int idEstudiante = (int)outputId.Value;

                    // 2. Guardar las materias seleccionadas (máx 3)
                    foreach (int materiaId in materiaIds)
                    {
                        SqlCommand cmdMateria = new SqlCommand("INSERT INTO EstudianteMateria (EstudianteId, MateriaId) VALUES (@EstudianteId, @MateriaId)", conect);
                        cmdMateria.Parameters.AddWithValue("@EstudianteId", idEstudiante);
                        cmdMateria.Parameters.AddWithValue("@MateriaId", materiaId);
                        cmdMateria.ExecuteNonQuery();
                    }
                }
                rpta = true;
            }
            catch (Exception e)
            {
                string error = e.Message;
                rpta = false;
            }
            return rpta;
        }

        public List<string> ListarSoloNombres()
        {
            var lista = new List<string>();
            var cn = new Connection();
            using (var conect = new SqlConnection(cn.getCadenaSql()))
            {
                conect.Open();
                SqlCommand cmd = new SqlCommand("SELECT Nombre FROM Estudiante", conect);
                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        lista.Add(dr["Nombre"].ToString());
                    }
                }
            }
            return lista;
        }

        public List<string> ObtenerCompanerosPorMaterias(int idEstudiante)
        {
            var lista = new List<string>();
            var cn = new Connection();
            using (var conect = new SqlConnection(cn.getCadenaSql()))
            {
                conect.Open();

                // Obtener materias del estudiante actual
                var materias = new List<int>();
                var cmdMaterias = new SqlCommand("SELECT MateriaId FROM EstudianteMateria WHERE EstudianteId = @Id", conect);
                cmdMaterias.Parameters.AddWithValue("@Id", idEstudiante);
                using (var dr = cmdMaterias.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        materias.Add(Convert.ToInt32(dr["MateriaId"]));
                    }
                }

                if (materias.Count > 0)
                {
                    var cmdCompaneros = new SqlCommand(@"
                SELECT DISTINCT E.Nombre 
                FROM Estudiante E
                INNER JOIN EstudianteMateria EM ON EM.EstudianteId = E.Id
                WHERE EM.MateriaId IN (" + string.Join(",", materias) + ") AND E.Id != @Id", conect);
                    cmdCompaneros.Parameters.AddWithValue("@Id", idEstudiante);
                    using (var dr = cmdCompaneros.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            lista.Add(dr["Nombre"].ToString());
                        }
                    }
                }
            }

            return lista;
        }

        public int SaveEstudianteAndReturnId(string nombre, int creditoId, List<int> materiaIds)
        {
            int idGenerado = 0;
            var cn = new Connection();

            using (var conect = new SqlConnection(cn.getCadenaSql()))
            {
                conect.Open();

                // 1. Insertar estudiante y obtener su ID
                SqlCommand cmd = new SqlCommand("spSaveEstudiante", conect);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Nombre", nombre);
                cmd.Parameters.AddWithValue("@CreditoId", creditoId);

                SqlParameter outputId = new SqlParameter("@IdEstudiante", SqlDbType.Int)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(outputId);

                cmd.ExecuteNonQuery();
                idGenerado = (int)outputId.Value;

                // 2. Insertar materias
                foreach (int materiaId in materiaIds)
                {
                    SqlCommand cmdMateria = new SqlCommand("INSERT INTO EstudianteMateria (EstudianteId, MateriaId) VALUES (@EstudianteId, @MateriaId)", conect);
                    cmdMateria.Parameters.AddWithValue("@EstudianteId", idGenerado);
                    cmdMateria.Parameters.AddWithValue("@MateriaId", materiaId);
                    cmdMateria.ExecuteNonQuery();
                }
            }

            return idGenerado;
        }


    }
}
