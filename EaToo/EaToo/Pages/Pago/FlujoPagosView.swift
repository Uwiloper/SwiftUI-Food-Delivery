//
//  FlujoPagosView.swift
//  EaToo
//
//  Created by Alumno on 1/12/25.
//

import SwiftUI


// MARK: - 1. VISTA DE RESEÑA (Review)
struct ReviewView: View {
    let pedido: Pedido
    @State private var rating = 5
    @State private var comentario = ""
    @State private var irADetalle = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Food Review").font(.headline)
            Spacer().frame(height: 20)
            
            Text("¿Qué tal estuvo la comida?")
                .font(.title2).fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            // Emoji cambia según estrellas
            Text(rating >= 4 ? "😍" : (rating >= 3 ? "🙂" : "😐"))
                .font(.system(size: 100))
                .shadow(radius: 10)
            
            // Selector de Estrellas
            HStack(spacing: 15) {
                ForEach(1...5, id: \.self) { i in
                    Image(systemName: i <= rating ? "star.fill" : "star")
                        .font(.title)
                        .foregroundColor(.yellow)
                        .onTapGesture { withAnimation { rating = i } }
                }
            }
            
            // Campo de Texto
            VStack(alignment: .leading) {
                Text("Añadir Comentario").fontWeight(.semibold)
                TextField("Escribe aquí tu opinión...", text: $comentario)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
            }
            .padding()
            
            Spacer()
            
            // BOTÓN ENVIAR (Con lógica de guardado)
            Button(action: {
                // 1. GUARDAMOS LA RESEÑA EN MEMORIA
                GestorPedidos.shared.agregarResena(
                    pedidoID: pedido.id,
                    rating: rating,
                    comentario: comentario
                )
                
                // 2. Avanzamos
                irADetalle = true
            }) {
                Text("Enviar Reseña")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("PrimaryColor")) // O .red
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding()
            .navigationDestination(isPresented: $irADetalle) {
                // Pasamos el pedido actualizado (aunque visualmente usaremos el mismo ID)
                PedidoFinalDetailView(pedido: pedido)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - 2. VISTA DETALLE FINAL (Ticket)
struct PedidoFinalDetailView: View {
    let pedido: Pedido
    @Environment(\.dismiss) var dismiss // Para cerrar si es necesario
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)
                .shadow(color: .green.opacity(0.3), radius: 10)
            
            Text("¡Pedido Confirmado!")
                .font(.title).fontWeight(.bold)
            
            Text("Tu comida está en proceso")
                .foregroundColor(.gray)
            
            // Tarjeta Resumen
            VStack(spacing: 12) {
                HStack {
                    Text("ID Pedido")
                    Spacer()
                    Text("#\(pedido.id.prefix(6).uppercased())").bold()
                }
                Divider()
                HStack {
                    Text("Total Pagado")
                    Spacer()
                    Text("S/ \(String(format: "%.2f", pedido.total))")
                        .bold()
                        .foregroundColor(Color("PrimaryColor"))
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 5)
            .padding(.horizontal, 30)
            .padding(.top, 20)
            
            Spacer()
            
            // --- BOTÓN CORREGIDO ---
            Button(action: {
                // 1. Enviamos la señal al MainView para cambiar de pestaña
                NotificationCenter.default.post(name: NSNotification.Name("IrAPerfil"), object: nil)
                
                // 2. Opcional: Intentamos cerrar la ventana actual para limpiar
                dismiss()
                
            }) {
                Text("Ver en Mis Pedidos")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .navigationBarBackButtonHidden(true)
        .background(Color(UIColor.systemGroupedBackground))
    }
}

// MARK: - 2. DETALLE DEL PEDIDO (Para ver fotos de productos)
struct HistorialPedidoDetailView: View {
    let pedido: Pedido
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // Cabecera
                HStack {
                    VStack(alignment: .leading) {
                        Text("Orden #\(pedido.id.prefix(6).uppercased())")
                            .font(.title2).fontWeight(.bold)
                        Text(pedido.fecha.formatted(date: .long, time: .shortened))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text(pedido.estado)
                        .font(.caption).bold()
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .foregroundColor(.green)
                        .cornerRadius(8)
                }
                .padding()
                .background(Color.white)
                
                // LISTA DE PRODUCTOS CON FOTOS
                VStack(alignment: .leading, spacing: 15) {
                    Text("Productos")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(pedido.items) { item in
                        HStack(spacing: 12) {
                            // FOTO DEL PRODUCTO
                            if let url = item.producto.imagenURL {
                                AsyncImage(url: url) { img in
                                    img.resizable().scaledToFill()
                                } placeholder: {
                                    Color.gray.opacity(0.1)
                                }
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                                .clipped()
                            } else {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(width: 60, height: 60)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(item.producto.nombre)
                                    .fontWeight(.medium)
                                    .lineLimit(1)
                                Text("Cant: \(item.cantidad)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("S/ \(String(format: "%.2f", Double(item.producto.precio)! * Double(item.cantidad)))")
                                .fontWeight(.semibold)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                }
                
                // RESEÑA (Si existe)
                if let rating = pedido.rating {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Tu Calificación").font(.headline)
                        HStack {
                            ForEach(1...5, id: \.self) { i in
                                Image(systemName: "star.fill")
                                    .foregroundColor(i <= rating ? .yellow : .gray.opacity(0.3))
                            }
                        }
                        if let comentario = pedido.comentario, !comentario.isEmpty {
                            Text("\"\(comentario)\"")
                                .font(.body)
                                .italic()
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 50)
            }
            .padding(.vertical)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Detalle de Orden")
        .navigationBarTitleDisplayMode(.inline)
    }
}
  

/*
#Preview {
    ReviewView()
}
*/
