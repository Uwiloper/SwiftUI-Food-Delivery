//
//  Categoria.swift
//  EaToo
//
//  Created by Alumno on 13/10/25.
//

import Foundation

struct Categoria: Codable, Identifiable {
    let idcategoria: Int
    let nombre: String
    let descripcion: String
    let foto: String

    // Computed id para Identifiable
    var id: Int { idcategoria }

    // URL completa para foto grande (opcional)
    var fotoURL: URL? {
        let raw = foto.trimmingCharacters(in: .whitespacesAndNewlines)
        if raw.isEmpty { return nil }
        if raw.starts(with: "http") { return URL(string: raw) }
        return URL(string: "https://uwil.alwaysdata.net/" + raw)
    }

}

