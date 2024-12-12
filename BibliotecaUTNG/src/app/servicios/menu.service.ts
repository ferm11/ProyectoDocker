import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class MenuService {

  private API_URL = "http://192.168.49.2:30444/api"

  showNavbar : BehaviorSubject<boolean>;

  constructor(private http:HttpClient) { 
    this.showNavbar = new BehaviorSubject(true);
  }

  hide(){
    this.showNavbar.next(false);
  }

  display(){
    this.showNavbar.next(true);
  }

  actualizarUsuario(nuevosDatos: any): Observable<any> {
    return this.http.post<any>('http://192.168.49.2:30444/api/actualizar-usuario', nuevosDatos);
  }

}
