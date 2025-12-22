//
//  GestorFavoritos.swift
//  EaToo
//
//  Created by Alumno on 1/12/25.
//

import Foundation

class GestorFavoritos {
    static let shared = GestorFavoritos()
    
    private let keyRestaurantes = "restaurantes_favoritos_guardados"
    private let keyProductos = "productos_favoritos_guardados" // Nueva clave para productos

    // MARK: - RESTAURANTES
    func toggleFavorito(_ restaurante: Restaurante) {
        var favoritos = obtenerFavoritos()
        if let index = favoritos.firstIndex(where: { $0.id == restaurante.id }) {
            favoritos.remove(at: index)
        } else {
            favoritos.append(restaurante)
        }
        guardarEnMemoria(favoritos, key: keyRestaurantes)
    }
    
    func esFavorito(id: Int) -> Bool {
        return obtenerFavoritos().contains(where: { $0.id == id })
    }
    
    func obtenerFavoritos() -> [Restaurante] {
        return leerDeMemoria(key: keyRestaurantes, tipo: [Restaurante].self) ?? []
    }

    // MARK: - PRODUCTOS (NUEVO)
    func toggleFavoritoProducto(_ producto: Producto) {
        var favoritos = obtenerFavoritosProductos()
        if let index = favoritos.firstIndex(where: { $0.id == producto.id }) {
            favoritos.remove(at: index)
        } else {
            favoritos.append(producto)
        }
        guardarEnMemoria(favoritos, key: keyProductos)
    }
    
    func esFavoritoProducto(id: Int) -> Bool {
        return obtenerFavoritosProductos().contains(where: { $0.id == id })
    }
    
    func obtenerFavoritosProductos() -> [Producto] {
        return leerDeMemoria(key: keyProductos, tipo: [Producto].self) ?? []
    }
    
    // MARK: - Helpers Privados (Para no repetir código)
    private func guardarEnMemoria<T: Encodable>(_ lista: T, key: String) {
        do {
            let data = try JSONEncoder().encode(lista)
            UserDefaults.standard.set(data, forKey: key)
        } catch { print("Error guardando favoritos: \(error)") }
    }
    
    private func leerDeMemoria<T: Decodable>(key: String, tipo: T.Type) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(tipo, from: data)
    }
}
