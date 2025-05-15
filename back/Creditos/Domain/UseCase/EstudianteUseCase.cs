using Credito.Domain.Model;
using Credito.DrivenAdapters.SqlServer;

namespace Credito.Domain.UseCase
{
    public class EstudianteUseCase
    {
        private readonly EstudianteImpl creditoImpl;

        public EstudianteUseCase()
        {
            // Idealmente esto debería venir por inyección de dependencias
            creditoImpl = new EstudianteImpl();
        }

        public bool Save(Estudiante estudiante)
        {
            return creditoImpl.SaveEstudiante(estudiante);
        }

        public List<Estudiante> listEstudiante()
        {
            return creditoImpl.listEstudiante();
        }

        public Estudiante GetById(int id)
        {
            return creditoImpl.listEstudiante().FirstOrDefault(e => e.Id == id);
        }
        
        public Estudiante Update(int id, Estudiante updated)
        {
            var lista = creditoImpl.listEstudiante();
            var existente = lista.FirstOrDefault(e => e.Id == id);

            if (existente == null)
                return null;

            existente.Nombre = updated.Nombre;
            creditoImpl.UpdateEstudiante(existente);
            return existente;
        }

        public bool Delete(int id)
        {
            return creditoImpl.DeleteEstudiante(id);
        }

        public bool Save(EstudianteDto dto)
        {
            return creditoImpl.SaveEstudianteConMaterias(dto.Nombre, dto.CreditoId, dto.MateriaIds);
        }

        public List<string> ListarSoloNombres()
        {
            return creditoImpl.ListarSoloNombres();
        }

        public List<string> ObtenerCompanerosPorMaterias(int idEstudiante)
        {
            return creditoImpl.ObtenerCompanerosPorMaterias(idEstudiante);
        }

        public int SaveAndReturnId(EstudianteDto dto)
        {
            return creditoImpl.SaveEstudianteAndReturnId(dto.Nombre, dto.CreditoId, dto.MateriaIds);
        }

    }
}
