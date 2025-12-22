import SwiftUI

// MARK: - Modelo y Gestor (Se mantienen igual)
// Asumo que tienes el struct Restaurante definido en otro lado,
// pero el Gestor se queda tal cual lo tenías.

final class GestorDatosRestaurantes: ObservableObject {
    @Published var restaurantes = [Restaurante]()
    @Published var isLoading = false
    
    private let urlString = "https://uwil.alwaysdata.net/restaurantes.php"
    
    func leerRestaurantes() {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.main.async { self.isLoading = true }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            defer { DispatchQueue.main.async { self.isLoading = false } }
            guard let data = data, error == nil else { return }
            do {
                let dec = try JSONDecoder().decode([Restaurante].self, from: data)
                DispatchQueue.main.async { self.restaurantes = dec }
            } catch {
                print("Error: \(error)")
            }
        }.resume()
    }
}

// MARK: - NUEVA Card estilo "Burger King"
struct RestauranteCard: View {
    let restaurante: Restaurante
    @State private var esFavorito: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // 1. ZStack para Imagen + Badges
            ZStack(alignment: .top) {
                // Imagen Fondo
                if let url = restaurante.fotoURL {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable().aspectRatio(contentMode: .fill).frame(height: 160).clipped()
                        case .failure, .empty:
                            Color.gray.opacity(0.3).frame(height: 160)
                        @unknown default: EmptyView()
                        }
                    }
                } else {
                    Color.gray.opacity(0.3).frame(height: 160)
                }
                
                // Badge y Corazón
                HStack {
                    Text("Free Delivery")
                        .font(.caption2.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 10).padding(.vertical, 6)
                        .background(Color.red).clipShape(Capsule())
                    
                    Spacer()
                    
                    // --- BOTÓN CORAZÓN CON LÓGICA ---
                    Button(action: {
                        // 1. Impacto visual inmediato
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                        
                        // 2. Lógica de guardado
                        GestorFavoritos.shared.toggleFavorito(restaurante)
                        
                        // 3. Actualizar estado visual
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                            esFavorito.toggle()
                        }
                    }) {
                        Image(systemName: esFavorito ? "heart.fill" : "heart")
                            .foregroundColor(esFavorito ? .red : .gray)
                            .font(.system(size: 18))
                            .padding(8)
                            .background(Circle().fill(Color.white.opacity(0.9)))
                            .shadow(color: .black.opacity(0.15), radius: 3)
                            .scaleEffect(esFavorito ? 1.1 : 1.0) // Pequeño efecto pop
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(12)
            }
            
            // 2. Información Inferior
            VStack(alignment: .leading, spacing: 10) {
                Text(restaurante.nombre)
                    .font(.title3).fontWeight(.bold).lineLimit(1)
                
                HStack(spacing: 15) {
                    Label("4.2", systemImage: "star.fill").foregroundColor(.yellow).font(.subheadline)
                    Label("20-25 Min", systemImage: "clock").foregroundColor(.red).font(.subheadline)
                }
                
                HStack(spacing: 8) {
                    Text("Burger").font(.caption).padding(6).background(Color.gray.opacity(0.1)).cornerRadius(5)
                    Text("Fast Food").font(.caption).padding(6).background(Color.gray.opacity(0.1)).cornerRadius(5)
                }
            }
            .padding(16)
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
        // AL APARECER: Revisamos si ya estaba guardado en memoria
        .onAppear {
            esFavorito = GestorFavoritos.shared.esFavorito(id: restaurante.id)
        }
    }
}

// Subvista auxiliar para las etiquetas grises
struct TagView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundColor(.gray)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
    }
}


// MARK: - Vista Principal (Lógica mantenida, ajustes visuales menores)
struct RestaurantesView: View {
    @StateObject private var gestor = GestorDatosRestaurantes()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Cabecera
                    HStack {
                        Text("Restaurantes")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // Estado de Carga / Lista
                    if gestor.isLoading && gestor.restaurantes.isEmpty {
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 200)
                    } else {
                        LazyVStack(spacing: 24) { // Más espacio entre tarjetas grandes
                            ForEach(gestor.restaurantes) { r in
                                NavigationLink(destination: RestaurantDetailView(restaurante: r)) {
                                    RestauranteCard(restaurante: r)
                                }
                                .buttonStyle(PlainButtonStyle()) // Quita el efecto azul del link
                            }
                        }
                        .padding(.horizontal, 20) // Margen lateral para que las tarjetas no toquen los bordes
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarHidden(true) // Ocultamos el nav bar por defecto para usar el título custom
            .onAppear {
                if gestor.restaurantes.isEmpty { gestor.leerRestaurantes() }
            }
        }
    }
}

// Vista "Ver todos" (Reutiliza la misma card)
struct RestaurantesListFullView: View {
    let restaurantes: [Restaurante]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(restaurantes) { r in
                    NavigationLink(destination: RestaurantDetailView(restaurante: r)) {
                        RestauranteCard(restaurante: r)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(20)
        }
        .navigationTitle("Todos los Restaurantes")
    }
}

// MARK: - Preview
struct RestaurantesView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantesView()
    }
}
