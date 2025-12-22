
import SwiftUI

// MARK: - Gestor para productos filtrados por categoría
final class GestorProductosPorCategoria: ObservableObject {
    @Published var productos = [Producto]()
    @Published var isLoading = false

    private let urlString = "https://uwil.alwaysdata.net/productos.php"
    private let idcategoria: Int

    init(idcategoria: Int) {
        self.idcategoria = idcategoria
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
                let filtrados = todos.filter { $0.idcategoria == self.idcategoria }
                DispatchQueue.main.async { self.productos = filtrados }
            } catch {
                print("Decoding productos error: \(error)")
            }
        }.resume()
    }
}

// MARK: - Vista detalle de categoría
struct CategoriaDetailView: View {
    let categoria: Categoria
    @StateObject private var gestor: GestorProductosPorCategoria

    init(categoria: Categoria) {
        self.categoria = categoria
        _gestor = StateObject(wrappedValue: GestorProductosPorCategoria(idcategoria: categoria.idcategoria))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header con imagen
                HStack(spacing: 12) {
                    if let url = categoria.fotoURL {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.25))
                                    .frame(width: 120, height: 120)
                            case .success(let image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 120)
                                    .clipped()
                                    .cornerRadius(12)
                            case .failure:
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.25))
                                    .frame(width: 120, height: 120)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text(categoria.nombre)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text(categoria.descripcion)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(3)
                    }
                    Spacer()
                }
                .padding(.horizontal)

                // Productos de la categoría
                VStack(alignment: .leading, spacing: 12) {
                    Text("Productos")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)

                    if gestor.isLoading && gestor.productos.isEmpty {
                        ForEach(0..<3, id: \.self) { _ in
                            ProductoCard(producto: Producto(idproducto: 0, nombre: "Cargando", descripcion: "", precio: "0", idcategoria: categoria.id, idrestaurante: 0, imagengrande: "", calificacion: nil))
                                .redacted(reason: .placeholder)
                                .padding(.horizontal)
                        }
                    } else if gestor.productos.isEmpty {
                        Text("No hay productos para esta categoría.")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    } else {
                        ForEach(gestor.productos) { p in
                            ProductoCard(producto: p)
                                .padding(.horizontal)
                        }
                    }
                }

                Spacer(minLength: 60)
            }
            .padding(.vertical)
        }
        .navigationTitle(categoria.nombre)
        .onAppear {
            if gestor.productos.isEmpty { gestor.leerProductos() }
        }
    }
}

/*
// MARK: - Preview
struct CategoriaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CategoriaDetailView(categoria: Categoria(idcategoria: 1, nombre: "Bebidas", descripcion: "Categoría de bebidas", foto: ""))
        }
    }
}
*/
