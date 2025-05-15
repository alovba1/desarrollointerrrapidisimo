using Microsoft.AspNetCore.Mvc;

using Credito.Domain.UseCase;

namespace Credito.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CreditoController : ControllerBase
    {
        private readonly CreditoUseCase creditoUseCase = new();

        // Obtener todos los créditos
        [HttpGet]
        public IActionResult GetAllCreditos()
        {
            var creditos = creditoUseCase.ListarCreditos();
            return Ok(creditos);
        }
    }
}
