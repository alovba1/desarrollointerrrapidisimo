using Microsoft.EntityFrameworkCore;
using Ruletas.Domain.Model;

namespace Ruletas.DrivenAdapters.SqlServer
{
    public class RouletteDbContext : DbContext
    {
        public RouletteDbContext(DbContextOptions options) : base(options)
        {
        }

        public DbSet<Roulette> Roulette { get; set; }
    }
}
