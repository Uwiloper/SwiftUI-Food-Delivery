//
//  UsuarioDeleteView.swift
//  EaToo
//
//  Created by Alumno on 3/11/25.
//

import SwiftUI

struct UsuarioDeleteView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var apiManager: UsuariosApiManager
    let usuario: Usuario
    @State private var isDeleting = false
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 10) {
                Image(systemName: "trash.circle.fill")
                    .font(.system(size: 70))
                    .foregroundColor(.red)
                Text("Eliminar Usuario")
                    .font(.title2.bold())
                Text("¿Seguro que deseas eliminar a **\(usuario.nombre) \(usuario.apellido)**?")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.subheadline)
            }
            HStack {
                Button("Cancelar") {
                    dismiss()
                }
                .buttonStyle(.bordered)
                
                Button("Eliminar") {
                    eliminarUsuario()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .disabled(isDeleting)
            }
            .padding(.top)
        }
        .padding()
        .presentationDetents([.fraction(0.35)])
    }
    
    private func eliminarUsuario() {
        isDeleting = true
        apiManager.eliminarUsuario(id: usuario.idusuario) { success in
            isDeleting = false
            if success {
                dismiss()
            } else {
                errorMessage = "No se pudo eliminar el usuario. Intenta de nuevo."
            }
        }
    }

}

