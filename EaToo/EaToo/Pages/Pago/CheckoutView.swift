//
//  CheckoutView.swift
//  EaToo
//
//  Created by Alumno on 1/12/25.
//

import SwiftUI

struct CheckoutView: View {
    // Datos del carrito actual
    let items: [ItemCarrito]
    let subtotal: Double
    
    @State private var irAReview = false
    @State private var pedidoReciente: Pedido?
    
    // Estados del formulario
    @State private var metodoPago = "Tarjeta"
    @State private var procesandoPago = false
    @State private var pagoExitoso = false
    
    let costoEnvio: Double = 5.00
    var totalFinal: Double { subtotal + costoEnvio }
    
    @Environment(\.dismiss) var dismiss
    
    // --- OJO: AQUÍ YA NO HAY NAVIGATION STACK, SOLO EL CONTENIDO ---
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // 1. Tarjeta Simulada
                if metodoPago == "Tarjeta" {
                    Image(systemName: "creditcard.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 180)
                        .foregroundColor(.blue.opacity(0.8))
                        .padding(.top)
                }
                
                // 2. Selección de Método
                VStack(alignment: .leading, spacing: 16) {
                    Text("Método de Pago").font(.headline)
                    
                    Button(action: { metodoPago = "Tarjeta" }) {
                        PaymentMethodRow(icono: "creditcard.fill", nombre: "Credit Card", seleccionado: metodoPago == "Tarjeta")
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: { metodoPago = "PayPal" }) {
                        PaymentMethodRow(icono: "dollarsign.circle.fill", nombre: "PayPal", seleccionado: metodoPago == "PayPal")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                
                // 3. Resumen
                VStack(spacing: 12) {
                    RowResumen(titulo: "Subtotal", valor: subtotal)
                    RowResumen(titulo: "Costo de Envío", valor: costoEnvio)
                    Divider()
                    RowResumen(titulo: "Total", valor: totalFinal, esTotal: true)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                
                Spacer(minLength: 30)
            }
            .padding()
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline) // Título pequeño para que se vea bien
        .navigationDestination(isPresented: $irAReview) {
            if let pedido = pedidoReciente {
                ReviewView(pedido: pedido)
            }
        }
        
        // 4. Botón Pagar (Fuera del Scroll para que quede fijo o dentro si prefieres)
        Button(action: {
            simularPago()
        }) {
            HStack {
                if procesandoPago {
                    ProgressView().tint(.white)
                } else {
                    Text("Confirmar Pago - S/ \(String(format: "%.2f", totalFinal))")
                        .fontWeight(.bold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryColor"))
            .foregroundColor(.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .padding()
        }
        .disabled(procesandoPago)
    }
    
    func simularPago() {
        procesandoPago = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // 1. Guardar Pedido
            let pedidoGuardado = GestorPedidos.shared.registrarPedido(
                items: items,
                total: totalFinal,
                metodo: metodoPago
            )
            
            self.pedidoReciente = pedidoGuardado
            GestorCarrito.shared.limpiarCarrito()
            procesandoPago = false
            
            // 2. Ir a la Reseña
            irAReview = true
        }
    }
}

// Subvistas Auxiliares
struct PaymentMethodRow: View {
    let icono: String
    let nombre: String
    let seleccionado: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icono)
                .font(.title2)
                .foregroundColor(nombre == "PayPal" ? .blue : .orange)
                .frame(width: 40)
            
            Text(nombre).fontWeight(.medium)
            Spacer()
            
            Image(systemName: seleccionado ? "largecircle.fill.circle" : "circle")
                .foregroundColor(seleccionado ? .red : .gray)
                .font(.title2)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(seleccionado ? Color.red : Color.clear, lineWidth: 1)
        )
    }
}

struct RowResumen: View {
    let titulo: String
    let valor: Double
    var esTotal: Bool = false
    
    var body: some View {
        HStack {
            Text(titulo)
                .foregroundColor(esTotal ? .primary : .gray)
                .fontWeight(esTotal ? .bold : .regular)
            Spacer()
            Text("S/ \(String(format: "%.2f", valor))")
                .fontWeight(esTotal ? .bold : .regular)
                .font(esTotal ? .title3 : .body)
        }
    }
}
