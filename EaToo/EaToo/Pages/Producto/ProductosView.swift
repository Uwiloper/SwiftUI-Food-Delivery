import SwiftUI

// Gestor de datos de productos
final class GestorProductosView: ObservableObject {
    @Published var productos = [Producto]()
    @Published var isLoading = false

    private let urlString = "https://uwil.alwaysdata.net/productos.php"

    func leerProductos() {
        guard let url = URL(string: urlString) else {
            print("URL inválida productos")
            return
        }

        DispatchQueue.main.async { self.isLoading = true }

        URLSession.shared.dataTask(with: url) { data, _, error in
            defer { DispatchQueue.main.async { self.isLoading = false } }

            guard let data = data, error == nil else {
                print("Error descargando productos: \(error?.localizedDescription ?? "sin detalle")")
                return
            }

            do {
                let dec = try JSONDecoder().decode([Producto].self, from: data)
                DispatchQueue.main.async { self.productos = dec }
            } catch {
                print("Error decodificando productos JSON: \(error)")
            }
        }.resume()
    }
}

// MARK: - Producto Card
struct ProductoCard: View {
    let producto: Producto
    @State private var esFavorito: Bool = false

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            
            // --- ZONA IMAGEN + CORAZÓN ---
            ZStack(alignment: .topTrailing) {
                // Imagen
                if let url = producto.imagenURL {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable().scaledToFill().frame(width: 110, height: 110).clipped()
                        default:
                            Color.gray.opacity(0.1).frame(width: 110, height: 110)
                        }
                    }
                    .cornerRadius(16)
                } else {
                    Color.gray.opacity(0.1).frame(width: 110, height: 110).cornerRadius(16)
                }
                
                // --- BOTÓN CORAZÓN (Con lógica) ---
                Button(action: {
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                    
                    GestorFavoritos.shared.toggleFavoritoProducto(producto)
                    
                    withAnimation(.spring()) {
                        esFavorito.toggle()
                    }
                }) {
                    Image(systemName: esFavorito ? "heart.fill" : "heart")
                        .foregroundColor(esFavorito ? .red : .white) // Rojo si es fav, Blanco si no (para que se vea sobre la foto)
                        .padding(6)
                        .background(esFavorito ? Color.white : Color.black.opacity(0.3)) // Fondo blanco si es fav, oscuro si no
                        .clipShape(Circle())
                        .padding(6)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            // --- ZONA INFO ---
            VStack(alignment: .leading, spacing: 8) {
                Text(producto.nombre)
                    .font(.headline).fontWeight(.bold).lineLimit(2)
                
                Text(producto.descripcion)
                    .font(.caption).foregroundColor(.gray).lineLimit(1)
                
                HStack(spacing: 12) {
                    Label(producto.calificacion ?? "4.2", systemImage: "star.fill")
                        .foregroundColor(.yellow).font(.caption2)
                    Label("20-25 Min", systemImage: "clock")
                        .foregroundColor(.red).font(.caption2)
                }
                
                Text("S/ \(producto.precio)")
                    .font(.subheadline).fontWeight(.bold).foregroundColor(.white)
                    .padding(.horizontal, 12).padding(.vertical, 6)
                    .background(Color.red).cornerRadius(20)
                    .shadow(color: .red.opacity(0.3), radius: 4, x: 0, y: 2)
            }
            
            Spacer()
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        // Cargar estado inicial
        .onAppear {
            esFavorito = GestorFavoritos.shared.esFavoritoProducto(id: producto.id)
        }
    }
}

// MARK: - Vista de productos
struct ProductosView: View {
    @StateObject private var gestor = GestorProductosView()
    @State private var productoSeleccionado: Producto?
    @State private var mostrarModal = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    if gestor.isLoading && gestor.productos.isEmpty {
                        ForEach(0..<5, id: \.self) { _ in
                            ProductoCard(
                                producto: Producto(
                                    idproducto: 0,
                                    nombre: "Cargando...",
                                    descripcion: "",
                                    precio: "0",
                                    idcategoria: 0,
                                    idrestaurante: 0,
                                    imagengrande: "",
                                    calificacion: nil
                                )
                            )
                            .redacted(reason: .placeholder)
                            .padding(.horizontal)
                        }
                    } else {
                        ForEach(gestor.productos) { producto in
                            Button {
                                productoSeleccionado = producto
                                mostrarModal = true
                            } label: {
                                ProductoCard(producto: producto)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("productos")
            .onAppear {
                if gestor.productos.isEmpty { gestor.leerProductos() }
            }
            // Modal de detalle
            .sheet(isPresented: $mostrarModal) {
                if let producto = productoSeleccionado {
                    ProductoDetailView(producto: producto)
                }
            }
        }
    }
}

// MARK: - Preview
struct ProductosView_Previews: PreviewProvider {
    static var previews: some View {
        ProductosView()
    }
}
