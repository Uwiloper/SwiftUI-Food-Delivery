//
//  HomeView.swift
//  EaToo
//
//  Created by Alumno on 13/10/25.
//

import SwiftUI

struct HomeView: View {
    // --- Gestores de Datos ---
    @StateObject private var gestorProductos = GestorProductosView()
    @StateObject private var gestorCategorias = GestorDatosCategorias()
    @StateObject private var gestorRestaurantes = GestorDatosRestaurantes()

    // --- Estados Locales ---
    @State private var productoSeleccionado: Producto?
    @State private var mostrarModalProducto = false
    
    // --- Estado del Buscador ---
    @State private var textoBusqueda = ""
    @FocusState private var isSearchFocused: Bool

    // Color de marca (Rojo/Naranja)
    let brandColor = Color("PrimaryColor") // O usa Color.red si no lo tienes definido

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // 1. Barra Superior
                TopBar()
                
                // 2. BARRA DE BÚSQUEDA (DISEÑO NUEVO: DIVIDIDO)
                HStack(spacing: 12) {
                    
                    // A. Campo de Texto (Caja Gris)
                    HStack {
                        TextField("Buscar...", text: $textoBusqueda)
                            .focused($isSearchFocused)
                            .submitLabel(.search)
                            .padding(.leading, 4) // Un poco de aire a la izquierda
                        
                        // Botón 'X' para limpiar (Aparece solo si escribes)
                        if !textoBusqueda.isEmpty {
                            Button(action: {
                                textoBusqueda = ""
                                isSearchFocused = false
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding() // Padding interno del texto
                    .background(Color.gray.opacity(0.15)) // Fondo Gris Claro
                    .cornerRadius(15)
                    
                    // B. Botón Lupa (Caja Roja Separada)
                    Button(action: {
                        // Al dar click a la lupa, ocultamos el teclado
                        isSearchFocused = false
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 55, height: 55) // Cuadrado fijo
                            .background(brandColor) // Tu color rojo/naranja
                            .cornerRadius(15) // Mismo redondeo que el texto
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)

                // 3. CONTENIDO (Lógica: ¿Está buscando o no?)
                if textoBusqueda.isEmpty {
                    
                    // --- VISTA NORMAL (HOME) ---
                    ScrollView {
                        VStack(spacing: 30) {
                            
                            // A. Categorías
                            CategoriasSection(gestor: gestorCategorias)
                            
                            // B. Mapa
                            MapaSection(gestor: gestorRestaurantes)
                            
                            // C. Restaurantes (Límite 5)
                            RestaurantesSection(gestor: gestorRestaurantes, limite: 5)
                            
                            // D. Productos (Límite 5)
                            ProductosSection(
                                gestor: gestorProductos,
                                productoSeleccionado: $productoSeleccionado,
                                mostrarModal: $mostrarModalProducto,
                                limite: 5
                            )
                        }
                        .padding(.vertical)
                        // Espacio extra para la barra curva flotante
                        .padding(.bottom, 100)
                    }
                    
                } else {
                    
                    // --- VISTA DE RESULTADOS DE BÚSQUEDA ---
                    List {
                        // 1. Filtrar Restaurantes
                        let restaurantesFiltrados = gestorRestaurantes.restaurantes.filter {
                            $0.nombre.localizedCaseInsensitiveContains(textoBusqueda)
                        }
                        
                        if !restaurantesFiltrados.isEmpty {
                            Section(header: Text("Restaurantes")) {
                                ForEach(restaurantesFiltrados) { r in
                                    NavigationLink(destination: RestaurantDetailView(restaurante: r)) {
                                        HStack {
                                            if let url = r.fotoURL {
                                                AsyncImage(url: url) { img in
                                                    img.resizable().scaledToFill()
                                                } placeholder: { Color.gray.opacity(0.3) }
                                                .frame(width: 40, height: 40)
                                                .cornerRadius(8)
                                                .clipped()
                                            }
                                            Text(r.nombre)
                                                .fontWeight(.medium)
                                        }
                                    }
                                }
                            }
                        }
                        
                        // 2. Filtrar Productos
                        let productosFiltrados = gestorProductos.productos.filter {
                            $0.nombre.localizedCaseInsensitiveContains(textoBusqueda) ||
                            $0.descripcion.localizedCaseInsensitiveContains(textoBusqueda)
                        }
                        
                        if !productosFiltrados.isEmpty {
                            Section(header: Text("Productos")) {
                                ForEach(productosFiltrados) { p in
                                    Button {
                                        productoSeleccionado = p
                                        mostrarModalProducto = true
                                    } label: {
                                        HStack {
                                            if let url = p.imagenURL {
                                                AsyncImage(url: url) { img in
                                                    img.resizable().scaledToFill()
                                                } placeholder: { Color.gray.opacity(0.3) }
                                                .frame(width: 40, height: 40)
                                                .cornerRadius(8)
                                                .clipped()
                                            }
                                            VStack(alignment: .leading) {
                                                Text(p.nombre).foregroundColor(.primary)
                                                Text("S/ \(p.precio)").font(.caption).foregroundColor(.gray)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                        // 3. Sin Resultados
                        if restaurantesFiltrados.isEmpty && productosFiltrados.isEmpty {
                            ContentUnavailableView.search(text: textoBusqueda)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
                if gestorProductos.productos.isEmpty { gestorProductos.leerProductos() }
                if gestorCategorias.categorias.isEmpty { gestorCategorias.leerCategorias() }
                if gestorRestaurantes.restaurantes.isEmpty { gestorRestaurantes.leerRestaurantes() }
            }
            .sheet(isPresented: $mostrarModalProducto) {
                if let producto = productoSeleccionado {
                    ProductoDetailView(producto: producto)
                }
            }
        }
    }
}


// MARK: - 1. Sección Categorías (ARREGLADA)
struct CategoriasSection: View {
    @ObservedObject var gestor: GestorDatosCategorias

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Categorías")
                    .font(.title2).fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    if gestor.isLoading && gestor.categorias.isEmpty {
                        ForEach(0..<3, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 80, height: 80)
                        }
                    } else {
                        ForEach(gestor.categorias) { c in
                            // --- AQUÍ ESTÁ EL CAMBIO IMPORTANTE ---
                            // Ahora navegamos a CategoriaDetailView enviando la categoría 'c'
                            NavigationLink(destination: CategoriaDetailView(categoria: c)) {
                                // Usamos tu componente visual CategoriaChip
                                CategoriaChip(categoria: c)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// MARK: - 2. Sección Mapa
struct MapaSection: View {
    @ObservedObject var gestor: GestorDatosRestaurantes

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("📍 Explorar en Mapa")
                .font(.title2).fontWeight(.bold)
                .padding(.horizontal)
            
            NavigationLink(destination: RestaurantesCercanosView(restaurantes: gestor.restaurantes)) {
                HStack {
                    Image(systemName: "map.fill")
                        .foregroundColor(.blue)
                        .font(.title)
                        .frame(width: 50, height: 50)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading) {
                        Text("Ver Ubicaciones")
                            .foregroundColor(.primary)
                            .fontWeight(.semibold)
                        Text("\(gestor.restaurantes.count) restaurantes cerca")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

// MARK: - 3. Sección Restaurantes
struct RestaurantesSection: View {
    @ObservedObject var gestor: GestorDatosRestaurantes
    let limite: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Restaurantes")
                    .font(.title2).fontWeight(.bold)
                Spacer()
                NavigationLink(destination: RestaurantesListFullView(restaurantes: gestor.restaurantes)) {
                    Text("Ver todos")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)

            LazyVStack(spacing: 14) {
                ForEach(gestor.restaurantes.prefix(limite)) { r in
                    NavigationLink(destination: RestaurantDetailView(restaurante: r)) {
                        RestauranteCard(restaurante: r)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - 4. Sección Productos
struct ProductosSection: View {
    @ObservedObject var gestor: GestorProductosView
    @Binding var productoSeleccionado: Producto?
    @Binding var mostrarModal: Bool
    let limite: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Productos Populares")
                    .font(.title2).fontWeight(.bold)
                Spacer()
                NavigationLink(destination: ProductosView()) {
                    Text("Ver todos")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)

            VStack(spacing: 12) {
                ForEach(gestor.productos.prefix(limite)) { p in
                    Button {
                        productoSeleccionado = p
                        mostrarModal = true
                    } label: {
                        ProductoCard(producto: p)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
