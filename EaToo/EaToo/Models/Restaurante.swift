//
//  Restaurante.swift
//  EaToo
//
//  Created by Alumno on 13/10/25.
//

import Foundation
import CoreLocation

struct Restaurante: Codable, Identifiable {
    let idrestaurante: Int
    let nombre: String
    let direccion: String
    let telefono: String
    let foto: String
    let latitud: String
    let longitud: String

    var id: Int { idrestaurante }

    var fotoURL: URL? {
        let raw = foto.trimmingCharacters(in: .whitespacesAndNewlines)
        if raw.isEmpty { return nil }
        if raw.starts(with: "http") { return URL(string: raw) }
        return URL(string: "https://uwil.alwaysdata.net/" + raw)
    }
    
    // Propiedad requerida para trabajar con Mapas
    var coordenada: CLLocationCoordinate2D? {
        guard let lat = Double(latitud), let lon = Double(longitud) else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}
