//
//  UsuariosApiManager.swift
//  EaToo
//
//  Created by Alumno on 3/11/25.
//

import Foundation

class UsuariosApiManager: ObservableObject {
    @Published var usuarios: [Usuario] = []
    @Published var isLoading = false
    private var baseURL = "https://uwil.alwaysdata.net/"
    
    init() {
        fetchUsuarios()
    }
    
    func fetchUsuarios() {
        guard let url = URL(string: "\(baseURL)usuarios.php") else { return }
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    print(" Error al cargar usuarios:", error.localizedDescription)
                    return
                }
                guard let data = data else { return }
                do {
                    self.usuarios = try JSONDecoder().decode([Usuario].self, from: data)
                } catch {
                    print("Error decodificando JSON:", error.localizedDescription)
                }
            }
        }.resume()
    }
    
    // Insert (retorna Bool en completion)
    func insertarUsuario(usuario: String, nombre: String, apellido: String, correo: String, telefono: String, clave: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)usuarios_insert.php") else { completion(false); return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = [
            "usuario": usuario,
            "nombre": nombre,
            "apellido": apellido,
            "correo": correo,
            "telefono": telefono,
            "clave": clave
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                let ok = (error == nil)
                if ok { self.fetchUsuarios() }
                completion(ok)
            }
        }.resume()
    }
    
    // Update
    func actualizarUsuario(_ usuario: Usuario, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)usuarios_update.php") else { completion(false); return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = [
            "idusuario": usuario.idusuario,
            "usuario": usuario.usuario,
            "nombre": usuario.nombre,
            "apellido": usuario.apellido,
            "correo": usuario.correo,
            "telefono": usuario.telefono,
            "clave": usuario.clave
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                let ok = (error == nil)
                if ok { self.fetchUsuarios() }
                completion(ok)
            }
        }.resume()
    }
    
    // Delete
    func eliminarUsuario(id: Int, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)usuarios_delete.php") else { completion(false); return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["idusuario": id]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                let ok = (error == nil)
                if ok {
                    // Mantenemos la lista local coherente
                    self.usuarios.removeAll { $0.idusuario == id }
                }
                completion(ok)
            }
        }.resume()
    }
}


