//
//  Pedido.swift
//  EaToo
//
//  Created by Alumno on 1/12/25.
//

import Foundation

struct Pedido: Codable, Identifiable {
    var id: String = UUID().uuidString
    let fecha: Date
    let items: [ItemCarrito]
    let total: Double
    var estado: String // "En Camino", "Entregado"
    let metodoPago: String
    
    // --- NUEVOS CAMPOS PARA RESEÑA ---
    var rating: Int?      // 1 a 5 estrellas
    var comentario: String?
}
