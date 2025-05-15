
using Credito.DrivenAdapters.SqlServer;
using Credito.Domain.Model;


namespace Materia.Domain.UseCase
{
    public class MateriaUseCase
    {
        private readonly MateriaImpl materiaImpl;

        public MateriaUseCase()
        {
            materiaImpl = new MateriaImpl();
        }

        public List<Credito.Domain.Model.Materia> ListarMaterias()
        {
            return materiaImpl.ListarMaterias();
        }
    }
}
