//
//  CartaView.swift
//  EaToo
//
//  Created by Alumno on 3/11/25.
//

import SwiftUI

struct CartaView: View {
    @StateObject private var gestor = GestorCarrito.shared
    @State private var irAlCheckout = false
    
    // Necesitamos el Environment para poder cerrar la vista si fuera necesario
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) { // Usamos ZStack para controlar capas si es necesario
                VStack(spacing: 0) {
                    
                    // --- 1. ENCABEZADO PERSONALIZADO (Nuevo) ---
                    HStack {
                        
                        Text("Carrito de Compras")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    .background(Color(UIColor.systemGroupedBackground)) // Mismo fondo que el resto
                    
                    // --- 2. CONTENIDO ---
                    if gestor.items.isEmpty {
                        // Estado Vacío
                        VStack(spacing: 20) {
                            Spacer()
                            Image(systemName: "cart.badge.minus")
                                .font(.system(size: 80))
                                .foregroundColor(.gray.opacity(0.3))
                            Text("Tu carrito está vacío")
                                .font(.title2)
                                .foregroundColor(.gray)
                            Text("¡Explora y agrega comida deliciosa!")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                    } else {
                        // Lista de Items
                        ScrollView {
                            VStack(spacing: 20) {
                                ForEach(gestor.items) { item in
                                    ItemCarritoRow(item: item)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                            // Espacio extra al final del scroll para que no choque con el panel de total
                            .padding(.bottom, 220)
                        }
                    }
                }
                
                // --- 3. PANEL DE TOTAL (FLOTANTE ABAJO) ---
                if !gestor.items.isEmpty {
                    VStack(spacing: 16) {
                        // Fila de Total
                        HStack {
                            Text("Total")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("S/ \(String(format: "%.2f", gestor.totalPagar))")
                                .font(.title) // Más grande
                                .fontWeight(.bold)
                                .foregroundColor(Color("PrimaryColor")) // O .red
                        }
                        
                        // Botón Pagar
                        Button(action: {
                            irAlCheckout = true
                            // Aquí conectarás tu pasarela de pago o confirmación
                        }) {
                            Text("Pagar Ahora")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("PrimaryColor")) // O .red
                                .cornerRadius(15)
                                .shadow(color: .red.opacity(0.3), radius: 5, y: 5)
                        }
                        .navigationDestination(isPresented: $irAlCheckout) {
                            // Pasamos los datos actuales al Checkout
                            CheckoutView(items: gestor.items, subtotal: gestor.totalPagar)
                        }
                    }
                    .padding(24)
                    .background(Color.white)
                    // Bordes redondeados superiores
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                    .shadow(color: .black.opacity(0.1), radius: 10, y: -5)
                    // --- ARREGLO DEL "APLASTADO" ---
                    // Levantamos este panel para que no lo tape la barra de navegación curva
                    .padding(.bottom, 130)
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
            .ignoresSafeArea(edges: .bottom) // Importante para manejar nosotros el espacio
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("IrAPerfil"))) { _ in
                // Cuando se recibe la señal de "Ir al Perfil":
                // 1. Cerramos el checkout automáticamente
                self.irAlCheckout = false
                // (La pestaña cambiará gracias al MainContainerView)
            }
        }
    }
    
    // MARK: - Subvista de Fila (Mantenemos tu diseño)
    struct ItemCarritoRow: View {
        let item: ItemCarrito
        
        var body: some View {
            HStack(spacing: 12) {
                // Imagen cuadrada
                if let url = item.producto.imagenURL {
                    AsyncImage(url: url) { img in
                        img.resizable().scaledToFill()
                    } placeholder: { Color.gray.opacity(0.2) }
                        .frame(width: 80, height: 80)
                        .cornerRadius(12)
                        .clipped()
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 80, height: 80)
                }
                
                // Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.producto.nombre)
                        .font(.headline)
                        .lineLimit(1)
                    
                    Text("S/ \(item.producto.precio)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Controles de Cantidad (+ 1 -)
                HStack(spacing: 0) {
                    Button(action: {
                        GestorCarrito.shared.disminuirCantidad(item.producto)
                    }) {
                        Text("−")
                            .font(.title2)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                            .background(Color.gray.opacity(0.1))
                    }
                    
                    Text("\(item.cantidad)")
                        .font(.headline)
                        .frame(width: 40)
                        .multilineTextAlignment(.center)
                        .background(Color.white)
                    
                    Button(action: {
                        GestorCarrito.shared.agregarProducto(item.producto)
                    }) {
                        Image(systemName: "plus")
                            .font(.body)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .background(Color("PrimaryColor")) // O .red
                    }
                }
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                )
            }
            .padding(12)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.03), radius: 5, y: 2)
        }
    }
}
