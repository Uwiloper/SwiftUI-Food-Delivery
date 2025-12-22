//
//  RestauranteDeleteView.swift
//  EaToo
//
//  Created by Alumno on 17/11/25.
//

import SwiftUI

struct RestauranteDeleteView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var apiManager: RestaurantesApiManager

    let restaurante: Restaurante

    @State private var isDeleting = false
    @State private var errorMessage: String? = nil
    @State private var mostrarConfirmacion = false

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "trash.circle.fill")
                .font(.system(size: 64))
                .foregroundColor(.red)

            Text("Eliminar Restaurante")
                .font(.title2)
                .bold()

            Text("¿Seguro que quieres eliminar **\(restaurante.nombre)**? Esta acción no se puede deshacer.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .padding(.horizontal)
            }

            HStack(spacing: 12) {
                Button("Cancelar") {
                    dismiss()
                }
                .buttonStyle(.bordered)

                Button(role: .destructive) {
                    // mostrar alerta de confirmación antes de borrar
                    mostrarConfirmacion = true
                } label: {
                    if isDeleting {
                        ProgressView()
                            .frame(minWidth: 80)
                    } else {
                        Text("Eliminar")
                            .frame(minWidth: 80)
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .disabled(isDeleting)
            }
            .padding(.top)
        }
        .padding()
        .presentationDetents([.fraction(0.35)])
        .confirmationDialog("¿Eliminar restaurante?", isPresented: $mostrarConfirmacion, titleVisibility: .visible) {
            Button("Eliminar", role: .destructive) {
                borrar()
            }
            Button("Cancelar", role: .cancel) { }
        } message: {
            Text("Se eliminará el restaurante \"\(restaurante.nombre)\" permanentemente.")
        }
    }

    private func borrar() {
        isDeleting = true
        errorMessage = nil

        Task {
            let ok = await apiManager.eliminarRestaurante(id: restaurante.idrestaurante)
            await MainActor.run {
                isDeleting = false
                if ok {
                    dismiss()
                } else {
                    errorMessage = "No se pudo eliminar. Intenta de nuevo."
                }
            }
        }
    }
}
