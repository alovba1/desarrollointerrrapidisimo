
using Microsoft.AspNetCore.Mvc;
using Materia.Domain.UseCase;

namespace Materia.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class MateriaController : ControllerBase
    {
        private readonly MateriaUseCase materiaUseCase = new();

        [HttpGet]
        public IActionResult GetAllMaterias()
        {
            var materias = materiaUseCase.ListarMaterias();
            return Ok(materias);
        }
    }
}
