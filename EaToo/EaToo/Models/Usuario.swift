//
//  Usuario.swift
//  EaToo
//
//  Created by Alumno on 22/09/25.
//

import Foundation

struct Usuario: Codable, Identifiable {
    let idusuario: Int
    let usuario: String
    let nombre: String
    let apellido: String
    let correo: String
    let telefono: String
    let clave: String
    let foto: String
    let fecha_registro: String
    
    var id: Int { idusuario }
    
    var imagenURL: URL? {
        URL(string: "https://uwil.alwaysdata.net/" + foto)
    }
}

