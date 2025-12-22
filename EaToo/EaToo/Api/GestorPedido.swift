//
//  GestorPedido.swift
//  EaToo
//
//  Created by Alumno on 1/12/25.
//

import Foundation

class GestorPedidos: ObservableObject {
    static let shared = GestorPedidos()
    @Published var historial: [Pedido] = []
    private let key = "historial_pedidos_app"
    
    init() {
        cargarPedidos()
    }
    
    // Función corregida para guardar de verdad
    func registrarPedido(items: [ItemCarrito], total: Double, metodo: String) -> Pedido {
        let nuevoPedido = Pedido(
            fecha: Date(),
            items: items,
            total: total,
            estado: "En Camino",
            metodoPago: metodo,
            rating: nil,       // Inicialmente sin reseña
            comentario: nil
        )
        
        historial.insert(nuevoPedido, at: 0)
        guardarEnMemoria()
        return nuevoPedido // Retornamos el pedido para usarlo en la siguiente vista
    }
    
    // Nueva función para agregar la reseña al pedido existente
    func agregarResena(pedidoID: String, rating: Int, comentario: String) {
        if let index = historial.firstIndex(where: { $0.id == pedidoID }) {
            historial[index].rating = rating
            historial[index].comentario = comentario
            guardarEnMemoria() // Guardamos cambios
            print("Reseña guardada para el pedido \(pedidoID)")
        }
    }
    
    private func guardarEnMemoria() {
        if let data = try? JSONEncoder().encode(historial) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    private func cargarPedidos() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Pedido].self, from: data) {
            self.historial = decoded
        }
    }
}
