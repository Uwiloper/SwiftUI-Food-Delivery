//
//  GestorCarrito.swift
//  EaToo
//
//  Created by Alumno on 1/12/25.
//

import Foundation
import SwiftUI

class GestorCarrito: ObservableObject {
    static let shared = GestorCarrito() // Singleton
    
    @Published var items: [ItemCarrito] = []
    private let key = "carrito_compras_local"
    
    init() {
        cargarCarrito()
    }
    
    // --- LÓGICA PRINCIPAL ---
    
    func agregarProducto(_ producto: Producto, cantidad: Int = 1) {
        if let index = items.firstIndex(where: { $0.id == producto.id }) {
            // Si ya existe, solo sumamos la cantidad
            items[index].cantidad += cantidad
        } else {
            // Si no existe, lo creamos
            let nuevoItem = ItemCarrito(producto: producto, cantidad: cantidad)
            items.append(nuevoItem)
        }
        guardarCarrito()
    }
    
    func disminuirCantidad(_ producto: Producto) {
        if let index = items.firstIndex(where: { $0.id == producto.id }) {
            if items[index].cantidad > 1 {
                items[index].cantidad -= 1
            } else {
                // Si es 1 y bajamos, lo borramos
                items.remove(at: index)
            }
            guardarCarrito()
        }
    }
    
    func eliminarProducto(_ producto: Producto) {
        items.removeAll(where: { $0.id == producto.id })
        guardarCarrito()
    }
    
    func limpiarCarrito() {
        items.removeAll()
        guardarCarrito()
    }
    
    // --- CÁLCULOS ---
    
    var totalPagar: Double {
        items.reduce(0) { total, item in
            // Convertimos el precio String ("12.99") a Double para calcular
            let precio = Double(item.producto.precio) ?? 0.0
            return total + (precio * Double(item.cantidad))
        }
    }
    
    var cantidadTotalArticulos: Int {
        items.reduce(0) { $0 + $1.cantidad }
    }
    
    // --- PERSISTENCIA (Base de Datos Local) ---
    
    private func guardarCarrito() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    private func cargarCarrito() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([ItemCarrito].self, from: data) {
            self.items = decoded
        }
    }
}
