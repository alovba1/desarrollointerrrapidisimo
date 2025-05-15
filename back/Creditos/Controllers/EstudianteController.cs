using Microsoft.AspNetCore.Mvc;
using Credito.Domain.UseCase;
using Credito.Domain.Model;

namespace Credito.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EstudianteController : ControllerBase
    {
        private readonly EstudianteUseCase estudianteUseCase = new();

        [HttpPost]
        public IActionResult AddEstudiante([FromBody] EstudianteDto dto)
        {
            if (dto.MateriaIds == null || dto.MateriaIds.Count > 3)
                return BadRequest(new { message = "Solo se pueden seleccionar hasta 3 materias." });

            int idEstudiante = estudianteUseCase.SaveAndReturnId(dto);
            Console.WriteLine($"ID retornado: {idEstudiante}");

            if (idEstudiante > 0)
                return Ok(new { id = idEstudiante, message = "Estudiante guardado correctamente." });
            else
                return BadRequest(new { message = "Error al guardar el estudiante." });
        }

        
        [HttpGet("nombres")]
        public IActionResult GetSoloNombres()
        {
            var nombres = estudianteUseCase.ListarSoloNombres(); // nuevo método
            return Ok(nombres);
        }

        [HttpGet("companeros/{idEstudiante}")]
        public IActionResult GetCompanerosPorMaterias(int idEstudiante)
        {
            var companeros = estudianteUseCase.ObtenerCompanerosPorMaterias(idEstudiante);
            return Ok(companeros);
        }


        // Obtener todos los estudiantes
        [HttpGet]
        public IActionResult GetAllEstudiante()
        {
            var estudiantes = estudianteUseCase.listEstudiante();
            return Ok(estudiantes);
        }

        // Obtener estudiante por ID
        
        [HttpGet("{id}")]
        public IActionResult GetEstudianteById(int id)
        {
            var estudiante = estudianteUseCase.GetById(id);
            if (estudiante == null) return NotFound();
            return Ok(estudiante);
        }

        // Actualizar estudiante
        [HttpPut("{id}")]
        public IActionResult UpdateEstudiante(int id, [FromBody] Estudiante estudiante)
        {
            var actualizado = estudianteUseCase.Update(id, estudiante);
            if (actualizado == null) return NotFound();
            return Ok(actualizado);
        }

        // Eliminar estudiante
        [HttpDelete("{id}")]
        public IActionResult DeleteEstudiante(int id)
        {
            var eliminado = estudianteUseCase.Delete(id);
            if (!eliminado) return NotFound();
            return NoContent();
        }
        
    }
}
