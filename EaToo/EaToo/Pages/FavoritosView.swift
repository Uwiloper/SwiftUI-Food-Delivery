//
//  FavoritosView.swift
//  EaToo
//
//  Created by Alumno on 3/11/25.
//

//
//  FavoritosView.swift
//  EaToo
//
//  Created by Alumno on 3/11/25.
//

import SwiftUI

struct FavoritosView: View {
    @State private var favRestaurantes: [Restaurante] = []
    @State private var favProductos: [Producto] = []
    
    // 0 = Restaurantes, 1 = Productos
    @State private var filtroSeleccionado = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                // --- SELECTOR DE PESTAÑAS ---
                Picker("Filtro", selection: $filtroSeleccionado) {
                    Text("Restaurantes").tag(0)
                    Text("Productos").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(Color.white)
                
                // --- LISTAS ---
                ScrollView {
                    if filtroSeleccionado == 0 {
                        // VISTA DE RESTAURANTES
                        if favRestaurantes.isEmpty {
                            EmptyStateView(icono: "house.slash", texto: "Sin restaurantes favoritos")
                        } else {
                            LazyVStack(spacing: 20) {
                                ForEach(favRestaurantes) { restaurante in
                                    NavigationLink(destination: RestaurantDetailView(restaurante: restaurante)) {
                                        RestauranteCard(restaurante: restaurante)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(20)
                        }
                    } else {
                        // VISTA DE PRODUCTOS
                        if favProductos.isEmpty {
                            EmptyStateView(icono: "cart.badge.minus", texto: "Sin productos favoritos")
                        } else {
                            LazyVStack(spacing: 20) {
                                ForEach(favProductos) { producto in
                                    // Aquí puedes navegar al detalle del producto si lo tienes
                                    // NavigationLink(destination: ProductoDetailView(producto: producto)) { ... }
                                    ProductoCard(producto: producto)
                                }
                            }
                            .padding(20)
                        }
                    }
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Favoritos")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                cargarDatos()
            }
        }
    }
    
    func cargarDatos() {
        favRestaurantes = GestorFavoritos.shared.obtenerFavoritos()
        favProductos = GestorFavoritos.shared.obtenerFavoritosProductos()
    }
}

// Subvista auxiliar para cuando no hay datos
struct EmptyStateView: View {
    let icono: String
    let texto: String
    var body: some View {
        VStack(spacing: 15) {
            Spacer(minLength: 50)
            Image(systemName: icono)
                .font(.system(size: 60))
                .foregroundColor(.gray.opacity(0.4))
            Text(texto)
                .font(.title3)
                .foregroundColor(.gray)
            Spacer()
        }
        .padding(.top, 50)
    }
}

struct FavoritosView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritosView()
    }
}
