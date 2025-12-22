//
//  RestauranteUpdateView.swift
//  EaToo
//
//  Created by Alumno on 17/11/25.
//

import SwiftUI

struct RestauranteUpdateView: View {
    @EnvironmentObject var apiManager: RestaurantesApiManager
    @Environment(\.dismiss) var dismiss

    @State var restaurante: Restaurante

    @State private var nombre = ""
    @State private var direccion = ""
    @State private var telefono = ""
    @State private var foto = ""
    @State private var latitud = ""
    @State private var longitud = ""

    @State private var isSaving = false
    @State private var mensaje: String? = nil
    @State private var mostrarAlerta = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Datos del Restaurante")) {
                    TextField("Nombre", text: $nombre)
                    TextField("Dirección", text: $direccion)
                    TextField("Teléfono", text: $telefono)
                    TextField("Foto (URL)", text: $foto)
                    TextField("Latitud", text: $latitud)
                    TextField("Longitud", text: $longitud)
                }

                Section {
                    Button(action: actualizar) {
                        if isSaving {
                            ProgressView()
                        } else {
                            Text("Guardar Cambios").bold()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(isSaving)

                    Button("Cancelar") {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                }
            }
            .navigationTitle("Editar Restaurante")
            .onAppear {
                nombre = restaurante.nombre
                direccion = restaurante.direccion
                telefono = restaurante.telefono
                foto = restaurante.foto
                latitud = restaurante.latitud
                longitud = restaurante.longitud
            }
            .alert(mensaje ?? "", isPresented: $mostrarAlerta) {
                Button("Cerrar") {
                    if mensaje == "Restaurante actualizado correctamente" {
                        dismiss()
                    }
                }
            }
        }
    }

    private func actualizar() {
        Task {
            isSaving = true

            let ok = await apiManager.actualizarRestaurante(
                id: restaurante.idrestaurante,
                nombre: nombre,
                direccion: direccion,
                telefono: telefono,
                foto: foto,
                latitud: latitud,
                longitud: longitud
            )

            isSaving = false
            mensaje = ok ? "Restaurante actualizado correctamente" : "Error al actualizar"
            mostrarAlerta = true
        }
    }
}
