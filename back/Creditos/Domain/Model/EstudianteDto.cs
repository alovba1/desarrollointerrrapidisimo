namespace Credito.Domain.Model
{
    public class EstudianteDto
    {
        public string Nombre { get; set; }
        public int CreditoId { get; set; }
        public List<int> MateriaIds { get; set; }
    }
}
