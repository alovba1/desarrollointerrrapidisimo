using Credito.Domain.Model;
using Credito.DrivenAdapters.SqlServer;
using System.Collections.Generic;

namespace Credito.Domain.UseCase
{
    public class CreditoUseCase
    {
        private readonly CreditoImpl creditoImpl;

        public CreditoUseCase()
        {
            creditoImpl = new CreditoImpl();
        }

        public List<Credito.Domain.Model.Credito> ListarCreditos()
        {
            return creditoImpl.ListarCreditos();
        }
    }
}
