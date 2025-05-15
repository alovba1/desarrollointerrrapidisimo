using System.Data.SqlClient;
namespace Credito.DrivenAdapters.SqlServer
{
    public class Connection
    {
        private string cadenaSQL = string.Empty;

        public Connection() 
        {
            var builder = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.json").Build();
            cadenaSQL = builder.GetSection("ConnectionStrings:EstudianteConnectionString").Value;
        }

        public string getCadenaSql() 
        {
            return cadenaSQL;
        }
    }
}
