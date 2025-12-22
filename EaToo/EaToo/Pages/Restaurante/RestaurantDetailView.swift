//
//  RestaurantDetailView.swift
//  EaToo
//
//  Created by Alumno on 13/10/25.
//

import SwiftUI

// MARK: - Gestor de Datos (Sin cambios)
final class GestorProductosPorRestaurante: ObservableObject {
    @Published var productos = [Producto]()
    @Published var isLoading = false
    
    private let urlString = "https://uwil.alwaysdata.net/productos.php"
    private let idrestaurante: Int
    
    init(idrestaurante: Int) {
        self.idrestaurante = idrestaurante
    }
    
    func leerProductos() {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.main.async { self.isLoading = true }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            defer { DispatchQueue.main.async { self.isLoading = false } }
            guard let data = data, error == nil else {
                print("Error productos: \(error?.localizedDescription ?? "sin detalle")")
                return
            }
            do {
                let todos = try JSONDecoder().decode([Producto].self, from: data)
                let filtrados = todos.filter { $0.idrestaurante == self.idrestaurante }
                DispatchQueue.main.async { self.productos = filtrados }
            } catch {
                print("Decoding productos error: \(error)")
            }
        }.resume()
    }
}

// OJO: AQUÍ BORRAMOS 'struct ProductoCard' PORQUE YA EXISTE EN OTRO ARCHIVO.
// Xcode usará automáticamente la que definiste en ProductosView.swift


// MARK: - RestaurantDetailView
struct RestaurantDetailView: View {
    let restaurante: Restaurante
    @StateObject private var gestor: GestorProductosPorRestaurante
    
    // Necesitamos el Environment para manejar la navegación si quisieras volver atrás
    @Environment(\.presentationMode) var presentationMode

    init(restaurante: Restaurante) {
        self.restaurante = restaurante
        _gestor = StateObject(wrappedValue: GestorProductosPorRestaurante(idrestaurante: restaurante.idrestaurante))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                // *** 1. Área de Cabecera ***
                ZStack(alignment: .top) {
                    
                    // Fondo
                    Group {
                        if let url = restaurante.fotoURL {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .success(let image):
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 200)
                                        .clipped()
                                        .blur(radius: 5)
                                case .failure:
                                    Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 200)
                                @unknown default:
                                    Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 200)
                                }
                            }
                        } else {
                            Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 200)
                        }
                    }
                    .padding(.top, 50)
                    
                    // Tarjeta de Info del Restaurante (Asegúrate de tener este componente o coméntalo si no)
                    RestaurantInfoCard(restaurante: restaurante)
                        .offset(y: 160)
                        .zIndex(1)

                    // Imagen de perfil circular
                    if let url = restaurante.fotoURL {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .success(let image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 4)
                                    )
                                    .shadow(radius: 5)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable().aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 4))
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .offset(y: 100)
                        .zIndex(2)
                    }
                }
                .padding(.bottom, 80)
                
                // *** 2. Sección de Filtros y Productos ***
                VStack(alignment: .leading, spacing: 12) {
                    
                    // Filtros
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            Button("Food Items") {}.buttonStyle(FoodFilterButtonStyle(isSelected: true))
                            Button("Juice Items") {}.buttonStyle(FoodFilterButtonStyle(isSelected: false))
                            Button("Desert Items") {}.buttonStyle(FoodFilterButtonStyle(isSelected: false))
                        }
                        .padding(.leading, 20)
                    }
                    
                    // Título
                    HStack {
                        Text("Popular Foods")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        Text("View All")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    .padding(.top, 10)
                    .padding(.horizontal)
                    
                    // *** LISTA DE PRODUCTOS ***
                    // Aquí llamamos a ProductoCard, y Swift buscará la definición en tu otro archivo
                    LazyVStack(spacing: 20) {
                        ForEach(gestor.productos) { p in
                            ProductoCard(producto: p)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
                .padding(.bottom, 60)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            if gestor.productos.isEmpty { gestor.leerProductos() }
        }
    }
}
