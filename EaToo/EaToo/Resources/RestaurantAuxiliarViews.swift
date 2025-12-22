import SwiftUI

// MARK: - Componente Auxiliar: Estilo de Botón de Filtro
struct FoodFilterButtonStyle: ButtonStyle {
    var isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.caption)
            .fontWeight(isSelected ? .semibold : .regular)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .foregroundColor(isSelected ? .white : .primary)
            .background(isSelected ? Color(red: 1.0, green: 0.3, blue: 0.2) : Color.gray.opacity(0.12))
            .cornerRadius(30)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

// MARK: - Componente Auxiliar: Tarjeta de Información del Restaurante (Tarjeta Blanca Superior)
struct RestaurantInfoCard: View {
    let restaurante: Restaurante

    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            VStack(alignment: .leading, spacing: 10) {
                // 1. Nombre y Dirección
                Text(restaurante.nombre)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .padding(.top, 10)
                
                Text(restaurante.direccion)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                
                // 2. Fila de Rating, Tiempo y Delivery
                HStack(spacing: 16) {
                    Label("4.2", systemImage: "star.fill")
                        .font(.subheadline).foregroundColor(.yellow)
                    Label("20-25 Min", systemImage: "clock.fill")
                        .font(.subheadline).foregroundColor(.gray)
                    Label("Free delivery", systemImage: "box.truck.fill")
                        .font(.subheadline).foregroundColor(.green)
                }
                .padding(.top, 4)
                
                // 3. Tags/Categorías
                HStack {
                    Text("Pizza").font(.caption2).padding(6).background(Color.gray.opacity(0.1)).cornerRadius(8)
                    Text("Burger").font(.caption2).padding(6).background(Color.gray.opacity(0.1)).cornerRadius(8)
                    Text("Fast Food").font(.caption2).padding(6).background(Color.gray.opacity(0.1)).cornerRadius(8)
                }
                .padding(.top, 5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 25)
            .padding(.vertical, 15)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            
            // 4. Corazón de Favorito
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
                .padding(.top, 25)
                .padding(.trailing, 35)
        }
        .padding(.horizontal, 20)
    }
}
