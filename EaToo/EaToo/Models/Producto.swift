//
//  Producto.swift
//  EaToo
//
//  Created by Alumno on 22/09/25.
//

import Foundation

struct Producto: Codable, Identifiable {
    let idproducto: Int
    let nombre: String
    let descripcion: String
    let precio: String
    let idcategoria: Int
    let idrestaurante: Int
    let imagengrande: String
    let calificacion: String?

    var id: Int { idproducto }

    var imagenURL: URL? {
        guard !imagengrande.isEmpty,
              imagengrande.lowercased() != "null",
              let url = URL(string: "https://uwil.alwaysdata.net/" + imagengrande)
        else { return nil }
        return url
    }

}


