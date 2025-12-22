//
//  UsuarioUpdateView.swift
//  EaToo
//
//  Created by Alumno on 3/11/25.
//

import SwiftUI


struct actualizarUsuario: View {
    @EnvironmentObject var apiManager: UsuariosApiManager
    @Environment(\.dismiss) var dismiss
    
    @State var usuario: Usuario
    
    // Campos editables
    @State private var usuarioText: String = ""
    @State private var nombre: String = ""
    @State private var apellido: String = ""
    @State private var correo: String = ""
    @State private var telefono: String = ""
    @State private var clave: String = ""
    
    // UI state
    @State private var isSaving = false
    @State private var mensaje: String? = nil
    @State private var mostrarAlerta = false
    
    init(usuario: Usuario) {
        _usuario = State(initialValue: usuario)
        // estos estados se inicializan en onAppear para asegurar que SwiftUI los maneje bien
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Cuenta")) {
                    TextField("Usuario", text: $usuarioText)
                        .autocapitalization(.none)
                    SecureField("Clave", text: $clave)
                }
                
                Section(header: Text("Información")) {
                    TextField("Nombre", text: $nombre)
                    TextField("Apellido", text: $apellido)
                    TextField("Correo", text: $correo)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    TextField("Teléfono", text: $telefono)
                        .keyboardType(.phonePad)
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button(action: actualizar) {
                            if isSaving {
                                ProgressView()
                            } else {
                                Text("Guardar cambios")
                                    .bold()
                            }
                        }
                        .disabled(isSaving)
                        .buttonStyle(.borderedProminent)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Button("Cancelar") {
                            dismiss()
                        }
                        .buttonStyle(.bordered)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Editar usuario")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Listo") {
                        actualizar()
                    }
                    .disabled(isSaving)
                }
            }
            .onAppear {
                // inicializar campos con los datos existentes
                usuarioText = usuario.usuario
                nombre = usuario.nombre
                apellido = usuario.apellido
                correo = usuario.correo
                telefono = usuario.telefono
                clave = usuario.clave
            }
            .alert(mensaje ?? "", isPresented: $mostrarAlerta) {
                Button("Cerrar") {
                    if mensaje == "Usuario actualizado correctamente" {
                        dismiss()
                    } else {
                        // mantener en la vista para corregir errores
                    }
                }
            }
        }
    }
    
    private func actualizar() {
        isSaving = true
        mensaje = nil
        
        // crear nueva instancia con los valores editados
        let actualizado = Usuario(
            idusuario: usuario.idusuario,
            usuario: usuarioText,
            nombre: nombre,
            apellido: apellido,
            correo: correo,
            telefono: telefono,
            clave: clave,
            foto: usuario.foto,
            fecha_registro: usuario.fecha_registro
        )
        
        apiManager.actualizarUsuario(actualizado) { ok in
            isSaving = false
            if ok {
                mensaje = "Usuario actualizado correctamente"
                apiManager.fetchUsuarios() // refrescar lista
            } else {
                mensaje = "Error al actualizar el usuario"
            }
            mostrarAlerta = true
        }
    }
}
