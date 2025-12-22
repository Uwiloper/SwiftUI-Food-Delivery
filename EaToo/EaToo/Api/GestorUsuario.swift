//
//  GestorUsuario.swift
//  EaToo
//
//  Created by Alumno on 1/12/25.
//

import Foundation

struct UsuarioModelo: Codable {
    let idusuario: Int
    let nombres: String
    let correo: String
    let foto: String // URL o nombre archivo
    // Agrega más campos si tu Models/Usuario.swift tiene más
    
    var fotoURL: URL? {
        if foto.starts(with: "http") { return URL(string: foto) }
        return URL(string: "https://uwil.alwaysdata.net/" + foto)
    }
}

class GestorUsuario: ObservableObject {
    @Published var usuario: UsuarioModelo?
    
    func cargarUsuario() {
        // Aquí deberías poner el ID real del usuario logueado.
        // Por ahora hardcodeamos el ID 1 para probar.
        guard let url = URL(string: "https://uwil.alwaysdata.net/usuarios.php") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let usuarios = try JSONDecoder().decode([UsuarioModelo].self, from: data)
                // Buscamos el usuario 1 (o el que quieras)
                DispatchQueue.main.async {
                    self.usuario = usuarios.first(where: { $0.idusuario == 1 })
                }
            } catch {
                print("Error usuario: \(error)")
            }
        }.resume()
    }
}
