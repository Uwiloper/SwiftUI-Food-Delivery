import SwiftUI

// MARK: - Gestor para descargar categorías
final class GestorDatosCategorias: ObservableObject {
    @Published var categorias = [Categoria]()
    @Published var isLoading = false

    private let urlString = "https://uwil.alwaysdata.net/categorias.php"

    func leerCategorias() {
        guard let url = URL(string: urlString) else {
            print("URL inválida categorias")
            return
        }
        DispatchQueue.main.async { self.isLoading = true }

        URLSession.shared.dataTask(with: url) { data, _, error in
            defer { DispatchQueue.main.async { self.isLoading = false } }
            guard let data = data, error == nil else {
                print("Error descargando categorias: \(error?.localizedDescription ?? "sin detalle")")
                return
            }
            do {
                let dec = try JSONDecoder().decode([Categoria].self, from: data)
                DispatchQueue.main.async { self.categorias = dec }
            } catch {
                print("Error decodificando categorias JSON: \(error)")
            }
        }.resume()
    }
}

// MARK: - Chip de categoría
struct CategoriaChip: View {
    let categoria: Categoria

    var body: some View {
        VStack(spacing: 8) {
            if let url = categoria.fotoURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.gray.opacity(0.25))
                            .frame(width: 72, height: 72)
                    case .success(let image):
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 72, height: 72)
                            .clipped()
                            .cornerRadius(18)
                    case .failure:
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.gray.opacity(0.25))
                            .frame(width: 72, height: 72)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.gray.opacity(0.25))
                    .frame(width: 72, height: 72)
            }

            Text(categoria.nombre)
                .font(.caption)
                .lineLimit(1)
                .frame(width: 80)
        }
        .padding(.vertical, 6)
        .frame(width: 92)
    }
}

// MARK: - Vista principal de categorías
struct CategoriasView: View {
    @StateObject private var gestor = GestorDatosCategorias()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Categorías")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    if gestor.isLoading && gestor.categorias.isEmpty {
                        ForEach(0..<4, id: \.self) { _ in
                            CategoriaChip(categoria: Categoria(idcategoria: 0, nombre: "Cargando", descripcion: "", foto: ""))
                                .redacted(reason: .placeholder)
                        }
                    } else {
                        ForEach(gestor.categorias) { cat in
                            NavigationLink(destination: CategoriaDetailView(categoria: cat)) {
                                CategoriaChip(categoria: cat)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 110)
        }
        .onAppear {
            if gestor.categorias.isEmpty { gestor.leerCategorias() }
        }
    }
}

// MARK: - Preview
struct CategoriasView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CategoriasView()
        }
        .previewLayout(.sizeThatFits)
    }
}
