import { Component, OnInit } from '@angular/core';
import { EstudianteService } from '../../services/estudiante.service';
import { Estudiante } from '../../models/estudiante';
import { Credito } from '../../models/credito'; // crea esta interfaz
import { Materia } from '../../models/materia';

@Component({
  selector: 'app-estudiante',
  templateUrl: './estudiante.component.html'
})
export class EstudianteComponent implements OnInit {
  estudiantes: Estudiante[] = [];
  creditos: Credito[] = []; 
  materias: Materia[] = []; 
  nombresEstudiantes: string[] = [];
  companeros: string[] = [];
  mensaje: string = '';
  estudianteForm: Estudiante = { id: 0, nombre: '', creditoId: null ,  materiaIds: [] };
  modoEdicion: boolean = false;
  materiaError: string = '';
  idEstudianteGuardado: number | null = null;
  constructor(private estudianteService: EstudianteService) {}

  ngOnInit(): void {
    this.obtenerEstudiantes();
    this.obtenerCreditos(); // 
     this.obtenerMaterias(); 
  }

onMateriaChange(event: any): void {
  const materiaId = +event.target.value;
  const isChecked = event.target.checked;

  const materiaSeleccionada = this.materias.find(m => m.id === materiaId);
  const profesorId = materiaSeleccionada?.profesorId;

  // 🔧 Solución al error: asegurarse de que materiaIds nunca sea undefined
  const profesoresSeleccionados = (this.estudianteForm.materiaIds || []).map(id => {
    const m = this.materias.find(mat => mat.id === id);
    return m?.profesorId;
  });

  if (isChecked) {
    // Inicializa materiaIds si está undefined
    if (!this.estudianteForm.materiaIds) {
      this.estudianteForm.materiaIds = [];
    }

    if (this.estudianteForm.materiaIds.length >= 3) {
      this.materiaError = 'Solo puedes seleccionar hasta 3 materias.';
      event.target.checked = false;
      return;
    }

    if (profesoresSeleccionados.includes(profesorId)) {
      this.materiaError = 'No puedes seleccionar dos materias del mismo profesor.';
      event.target.checked = false;
      return;
    }

    this.estudianteForm.materiaIds.push(materiaId);
  } else {
    this.estudianteForm.materiaIds = this.estudianteForm.materiaIds.filter(id => id !== materiaId);
  }

  this.materiaError = '';
}


cargarTodosLosEstudiantes() {
  this.estudianteService.getTodosLosEstudiantes().subscribe(res => {
    this.nombresEstudiantes = res;
  });
}

verCompaneros(estudianteId: number) {
  this.estudianteService.getCompaneros(estudianteId).subscribe(res => {
    this.companeros = res;
  });
}

obtenerMaterias(): void {
    this.estudianteService.getMaterias().subscribe(data => {
      this.materias = data;
    });
  }

obtenerEstudiantes(): void {
  this.estudianteService.getEstudiantes().subscribe(data => {
    this.estudiantes = data;
    console.log('Estudiantes:', this.estudiantes);
  });
}


  obtenerCreditos(): void {
  this.estudianteService.getCreditos().subscribe(data => {
    console.log('Créditos:', data); // 
    this.creditos = data;
  });
}



getTotalCredito(creditoId: number | null): string {
  if (!creditoId) return 'Sin crédito asignado';
  const credito = this.creditos.find(c => c.id === +creditoId);
  return credito ? `$${credito.totalCredito.toFixed(2)}` : 'Crédito no encontrado';
}



guardarEstudiante(): void {
  console.log(this.estudianteForm);
  console.log('Enviando al backend:', this.estudianteForm);

  this.estudianteService.addEstudiante(this.estudianteForm).subscribe(
    (res: any) => {
      console.log('Respuesta del backend:', res);
      this.obtenerEstudiantes();
      this.idEstudianteGuardado = res.id; // guardamos el ID real
      this.estudianteForm = { id: 0, nombre: '', creditoId: null, materiaIds: [] };
      this.mensaje = res.message;
    },
    (error) => {
      console.error(error);
      this.mensaje = error.error.message || 'Error inesperado';
    }
  );
}



  editarEstudiante(estudiante: Estudiante): void {
    this.estudianteForm = { ...estudiante };
    this.modoEdicion = true;
  }

  cancelarEdicion(): void {
    this.estudianteForm = { id: 0, nombre: '', creditoId: 0,  materiaIds: []   };
    this.modoEdicion = false;
  }

  eliminarEstudiante(id: number): void {
    this.estudianteService.deleteEstudiante(id).subscribe(() => {
      this.obtenerEstudiantes();
    });
  }
}
