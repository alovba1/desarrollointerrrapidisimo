import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Estudiante } from '../models/estudiante';
import { Credito } from '../models/credito'; // 
import { Materia } from '../models/materia'; 
@Injectable({
  providedIn: 'root'
})
export class EstudianteService {

  private apiUrl = 'https://localhost:7243/api/Estudiante';
  private apiCreditosUrl = 'https://localhost:7243/api/Credito'; 
  private apiMateriasUrl = 'https://localhost:7243/api/Materia'; 

  constructor(private http: HttpClient) {}

  getEstudiantes(): Observable<Estudiante[]> {
    return this.http.get<Estudiante[]>(this.apiUrl);
  }

addEstudiante(estudiante: any): Observable<any> {
  return this.http.post<any>(this.apiUrl, estudiante);
}

  updateEstudiante(estudiante: Estudiante): Observable<Estudiante> {
    return this.http.put<Estudiante>(`${this.apiUrl}/${estudiante.id}`, estudiante);
  }

  deleteEstudiante(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`);
  }

  //NUEVO: obtener créditos para llenar el combo
  getCreditos(): Observable<Credito[]> {
    return this.http.get<Credito[]>(this.apiCreditosUrl);
  }

  getMaterias(): Observable<Materia[]> {
  return this.http.get<Materia[]>(this.apiMateriasUrl);
}

getTodosLosEstudiantes(): Observable<string[]> {
  return this.http.get<string[]>(this.apiUrl + '/nombres');
}

getCompaneros(estudianteId: number): Observable<string[]> {
  return this.http.get<string[]>(`${this.apiUrl}/companeros/${estudianteId}`);
}

}
