//
//  PerfilView.swift
//  EaToo
//
//  Created by Alumno on 3/11/25.
//

import SwiftUI

struct PerfilView: View {
    @StateObject private var usuariosManager = UsuariosApiManager()
    @StateObject private var gestorPedidos = GestorPedidos.shared
    
    // Busca usuario ID 1
    var usuarioActual: Usuario? {
        return usuariosManager.usuarios.first { $0.idusuario == 1 }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    
                    // --- 1. CABECERA (Tu código de foto se mantiene) ---
                    CabeceraPerfil(usuario: usuarioActual)
                    
                    // --- 2. HISTORIAL DE PEDIDOS ---
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Historial de Pedidos")
                            .font(.title3).fontWeight(.bold)
                            .padding(.horizontal, 20)
                        
                        if gestorPedidos.historial.isEmpty {
                            Text("No tienes pedidos recientes")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.top, 20)
                        } else {
                            LazyVStack(spacing: 20) {
                                // Muestra los pedidos (El último sale primero)
                                ForEach(gestorPedidos.historial) { pedido in
                                    
                                    // NAVEGACIÓN AL DETALLE (Con fotos)
                                    NavigationLink(destination: HistorialPedidoDetailView(pedido: pedido)) {
                                        PedidoPerfilCard(pedido: pedido)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 100)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if usuariosManager.usuarios.isEmpty { usuariosManager.fetchUsuarios() }
                // Forzamos actualización por si vienes del checkout
                gestorPedidos.objectWillChange.send()
            }
        }
    }
}

// --- SUBVISTA DE LA TARJETA (DISEÑO MEJORADO) ---
struct PedidoPerfilCard: View {
    let pedido: Pedido
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // Fila Superior: Icono y Datos Básicos
            HStack(spacing: 15) {
                // Icono Bonito
                ZStack {
                    Circle().fill(Color.orange.opacity(0.1))
                    Image(systemName: "bag.fill")
                        .foregroundColor(.orange)
                        .font(.title2)
                }
                .frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Orden #\(pedido.id.prefix(4).uppercased())")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(pedido.fecha.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text("S/ \(String(format: "%.2f", pedido.total))")
                    .font(.headline)
                    .foregroundColor(Color("PrimaryColor")) // O .red
            }
            
            Divider()
            
            // Fila Inferior: Estrellas y Reseña
            HStack(spacing: 6) {
                if let rating = pedido.rating {
                    // Muestra Estrellas
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { i in
                            Image(systemName: "star.fill")
                                .font(.caption)
                                .foregroundColor(i <= rating ? .yellow : .gray.opacity(0.3))
                        }
                    }
                    
                    // Muestra Comentario
                    if let comentario = pedido.comentario, !comentario.isEmpty {
                        Text("•")
                            .foregroundColor(.gray)
                        Text("\"\(comentario)\"")
                            .font(.caption)
                            .italic()
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                } else {
                    Text("Pedido entregado")
                        .font(.caption)
                        .foregroundColor(.green)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20) // Bordes muy redondeados
        .padding(.horizontal, 20)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4) // Sombra suave
    }
}

// Subvista auxiliar para la cabecera (para no llenar el código principal)
struct CabeceraPerfil: View {
    let usuario: Usuario?
    var body: some View {
        VStack(spacing: 10) {
            // Foto
            if let user = usuario, !user.foto.isEmpty {
                 let urlString = user.foto.starts(with: "http") ? user.foto : "https://uwil.alwaysdata.net/" + user.foto
                 AsyncImage(url: URL(string: urlString)) { ph in
                     if let img = ph.image { img.resizable().scaledToFill() }
                     else { Color.gray.opacity(0.3) }
                 }
                 .frame(width: 110, height: 110).clipShape(Circle())
                 .shadow(radius: 5)
            } else {
                Circle().fill(Color.gray.opacity(0.3)).frame(width: 110, height: 110)
                    .overlay(Image(systemName: "person.fill").font(.largeTitle).foregroundColor(.white))
            }
            // Textos
            Text(usuario != nil ? "\(usuario!.nombre) \(usuario!.apellido)" : "Cargando...")
                .font(.title2).fontWeight(.bold)
            Text(usuario?.correo ?? "")
                .font(.subheadline).foregroundColor(.gray)
        }
        .padding(.top, 20)
    }
}
    /*
#Preview {
    PerfilView()
}
*/
