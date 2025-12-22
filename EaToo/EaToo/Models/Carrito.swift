//
//  Carrito.swift
//  EaToo
//
//  Created by Alumno on 1/12/25.
//

import Foundation

struct ItemCarrito: Codable, Identifiable {
    let producto: Producto
    var cantidad: Int
    
    var id: Int { producto.id }
}
