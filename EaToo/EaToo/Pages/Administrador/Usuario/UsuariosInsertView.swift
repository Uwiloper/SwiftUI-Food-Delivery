//
//  UsuariosInsertView.swift
//  EaToo
//
//  Created by Alumno on 3/11/25.
//

import SwiftUI

struct UsuarioInsertView: View {
    @EnvironmentObject var apiManager: UsuariosApiManager
    @Environment(\.dismiss) var dismiss
    
    @State private var usuario = ""
    @State private var nombre = ""
    @State private var apellido = ""
    @State private var correo = ""
    @State private var telefono = ""
    @State private var clave = ""
    
    @State private var mensaje = ""
    @State private var mostrarAlerta = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Datos del usuario") {
                    TextField("Usuario", text: $usuario)
                    TextField("Nombre", text: $nombre)
                    TextField("Apellido", text: $apellido)
                    TextField("Correo", text: $correo)
                    TextField("Teléfono", text: $telefono)
                    SecureField("Clave", text: $clave)
                }
                
                Button("Guardar") {
                    apiManager.insertarUsuario(
                        usuario: usuario,
                        nombre: nombre,
                        apellido: apellido,
                        correo: correo,
                        telefono: telefono,
                        clave: clave
                    ) { ok in
                        mensaje = ok ? "Usuario agregado correctamente" : "Error al registrar"
                        mostrarAlerta = true
                        if ok { apiManager.fetchUsuarios() }
                    }
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Nuevo Usuario")
            .alert(mensaje, isPresented: $mostrarAlerta) {
                Button("Cerrar") { dismiss() }
            }
        }
    }
}

#Preview {
    UsuarioInsertView()
}
