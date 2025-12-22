//
//  RestaurantesApiManager.swift
//  EaToo
//
//  Created by Alumno on 17/11/25.
//

import Foundation

class RestaurantesApiManager: ObservableObject {
    @Published var restaurantes: [Restaurante] = []
    @Published var isLoading = false
    @Published var error: String? = nil

    private let baseURL = "https://uwil.alwaysdata.net/restaurantes.php"

    // MARK: - LISTAR
    func fetchRestaurantes() async {
        DispatchQueue.main.async { self.isLoading = true }

        guard let url = URL(string: baseURL) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let resp = try JSONDecoder().decode([Restaurante].self, from: data)

            DispatchQueue.main.async {
                self.restaurantes = resp
                self.isLoading = false
            }

        } catch {
            DispatchQueue.main.async {
                self.error = error.localizedDescription
                self.isLoading = false
            }
        }
    }

    // MARK: - INSERTAR
    func insertarRestaurante(
        nombre: String,
        direccion: String,
        telefono: String,
        foto: String,
        latitud: String,
        longitud: String
    ) async -> Bool {

        guard let url = URL(string: baseURL) else { return false }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let params = [
            "nombre": nombre,
            "direccion": direccion,
            "telefono": telefono,
            "foto": foto,
            "latitud": latitud,
            "longitud": longitud
        ]

        request.httpBody = params
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .data(using: .utf8)

        do {
            let (_, _) = try await URLSession.shared.data(for: request)
            await fetchRestaurantes()
            return true
        } catch {
            return false
        }
    }

    // MARK: - ACTUALIZAR
    func actualizarRestaurante(
        id: Int,
        nombre: String,
        direccion: String,
        telefono: String,
        foto: String,
        latitud: String,
        longitud: String
    ) async -> Bool {

        guard let url = URL(string: "\(baseURL)?update=\(id)") else { return false }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let params = [
            "nombre": nombre,
            "direccion": direccion,
            "telefono": telefono,
            "foto": foto,
            "latitud": latitud,
            "longitud": longitud
        ]

        request.httpBody = params
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .data(using: .utf8)

        do {
            let (_, _) = try await URLSession.shared.data(for: request)
            await fetchRestaurantes()
            return true
        } catch {
            return false
        }
    }

    // MARK: - ELIMINAR
    func eliminarRestaurante(id: Int) async -> Bool {
        guard let url = URL(string: "\(baseURL)?delete=\(id)") else { return false }

        do {
            let (_, _) = try await URLSession.shared.data(from: url)
            await fetchRestaurantes()
            return true
        } catch {
            return false
        }
    }
}

