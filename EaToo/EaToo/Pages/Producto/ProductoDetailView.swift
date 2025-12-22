
import SwiftUI

struct ProductoDetailView: View {
    let producto: Producto
    @State private var agregadoAlCarrito = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Imagen Header
                if let url = producto.imagenURL {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable().scaledToFill()
                                .frame(height: 300).clipped()
                        default:
                            Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 300)
                        }
                    }
                } else {
                    Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 300)
                }

                // Contenido estilo "Hoja"
                VStack(alignment: .leading, spacing: 16) {
                    
                    HStack {
                        Text(producto.nombre)
                            .font(.title).fontWeight(.bold)
                        Spacer()
                        Text("S/ \(producto.precio)")
                            .font(.title2).fontWeight(.bold).foregroundColor(.blue)
                    }

                    Text(producto.descripcion)
                        .font(.body).foregroundColor(.gray)

                    HStack(spacing: 20) {
                        Label(producto.calificacion ?? "4.2", systemImage: "star.fill")
                            .foregroundColor(.yellow)
                        Label("20 - 25 Min", systemImage: "clock")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .font(.subheadline)
                    
                    Spacer(minLength: 20)

                    // --- BOTÓN AGREGAR (CON LÓGICA) ---
                    Button(action: {
                        // 1. Efecto visual
                        withAnimation { agregadoAlCarrito = true }
                        
                        // 2. GUARDAR EN LA BASE DE DATOS LOCAL
                        GestorCarrito.shared.agregarProducto(producto)
                        
                        // 3. Resetear botón
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation { agregadoAlCarrito = false }
                        }
                    }) {
                        HStack {
                            Image(systemName: agregadoAlCarrito ? "checkmark" : "cart.fill")
                            Text(agregadoAlCarrito ? "Agregado" : "Agregar al carrito")
                        }
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(agregadoAlCarrito ? Color.green : Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                    }
                }
                .padding(24)
                .background(Color.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .offset(y: -40)
                .padding(.bottom, -40)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

// Extensión para esquinas redondeadas específicas
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
