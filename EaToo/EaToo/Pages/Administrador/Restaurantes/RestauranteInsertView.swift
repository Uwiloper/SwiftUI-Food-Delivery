//
//  RestauranteInsertView.swift
//  EaToo
//
//  Created by Alumno on 17/11/25.
//

import SwiftUI

struct RestauranteInsertView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var apiManager: RestaurantesApiManager

    @State private var nombre = ""
    @State private var direccion = ""
    @State private var telefono = ""
    @State private var foto = ""
    @State private var latitud = ""
    @State private var longitud = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Nombre", text: $nombre)
                TextField("Dirección", text: $direccion)
                TextField("Teléfono", text: $telefono)
                TextField("Foto (URL o archivo)", text: $foto)
                TextField("Latitud", text: $latitud)
                TextField("Longitud", text: $longitud)
            }
            .navigationTitle("Nuevo Restaurante")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        Task {
                            let ok = await apiManager.insertarRestaurante(
                                nombre: nombre,
                                direccion: direccion,
                                telefono: telefono,
                                foto: foto,
                                latitud: latitud,
                                longitud: longitud
                            )
                            if ok { dismiss() }
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
        }
    }
}
