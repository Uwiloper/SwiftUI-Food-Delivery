//
//  UsuarioView.swift
//  EaToo
//
//  Created by Alumno on 27/10/25.
//

import SwiftUI

struct UsuarioView: View {
    @EnvironmentObject var apiManager: UsuariosApiManager
    @State private var selectedUsuario: Usuario? = nil
    @State private var usuarioAEliminar: Usuario? = nil
    @State private var mostrarInsertarUsuario = false

    var body: some View {
        NavigationStack {
            ScrollView {
                if apiManager.isLoading {
                    ProgressView("Cargando usuarios...")
                        .padding()
                } else if apiManager.usuarios.isEmpty {
                    Text("No hay usuarios registrados.")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    LazyVStack(spacing: 16) {
                        ForEach(apiManager.usuarios) { usuario in
                            UsuarioCardView(
                                usuario: usuario,
                                onEdit: { selectedUsuario = usuario },
                                onDelete: { usuarioAEliminar = usuario }
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Usuarios")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        mostrarInsertarUsuario = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $mostrarInsertarUsuario) {
                UsuarioInsertView()
                    .environmentObject(apiManager)
            }
            .sheet(item: $selectedUsuario) { usuario in
                actualizarUsuario(usuario: usuario)
                    .environmentObject(apiManager)
            }
            .sheet(item: $usuarioAEliminar) { usuario in
                UsuarioDeleteView(usuario: usuario)
                    .environmentObject(apiManager)
            }
            .onAppear {
                apiManager.fetchUsuarios()
            }
        }
    }
}

struct UsuarioCardView: View {
    let usuario: Usuario
    let onEdit: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 16) {
                if let url = usuario.imagenURL {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 70, height: 70)
                        case .success(let image):
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .shadow(radius: 3)
                        case .failure:
                            Image(systemName: "person.crop.circle.badge.exclam")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.gray)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(usuario.nombre) \(usuario.apellido)")
                        .font(.headline)
                    Text(usuario.correo)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Usuario: \(usuario.usuario)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            
            HStack {
                Button(action: onEdit) {
                    Label("Editar", systemImage: "pencil.circle.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                
                Button(action: onDelete) {
                    Label("Eliminar", systemImage: "trash.circle.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    UsuarioView()
}
