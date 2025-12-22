import SwiftUI

struct RestauranteView: View {
    @EnvironmentObject var apiManager: RestaurantesApiManager
    @State private var mostrarInsert = false
    @State private var restauranteSeleccionado: Restaurante? = nil
    @State private var mostrarUpdate = false
    @State private var mostrarDeleteAlert = false

    var body: some View {
        NavigationStack {
            Group {
                if apiManager.isLoading {
                    VStack {
                        ProgressView("Cargando restaurantes...")
                            .padding()
                    }
                } else if let error = apiManager.error {
                    VStack(spacing: 15) {
                        Text("Error:")
                            .font(.title2)
                            .bold()
                        Text(error)
                            .foregroundColor(.red)

                        Button("Reintentar") {
                            Task { await apiManager.fetchRestaurantes() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List {
                        ForEach(apiManager.restaurantes) { r in
                            HStack {
                                // FOTO
                                AsyncImage(url: r.fotoURL) { img in
                                    img.resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                                VStack(alignment: .leading) {
                                    Text(r.nombre)
                                        .font(.headline)

                                    Text(r.direccion)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)

                                    Text("\(r.latitud), \(r.longitud)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()

                                // BOTÓN EDITAR
                                Button {
                                    restauranteSeleccionado = r
                                    mostrarUpdate = true
                                } label: {
                                    Image(systemName: "pencil.circle.fill")
                                        .font(.title2)
                                }
                                .buttonStyle(.plain)

                                // BOTÓN ELIMINAR
                                Button {
                                    restauranteSeleccionado = r
                                    mostrarDeleteAlert = true
                                } label: {
                                    Image(systemName: "trash.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.title2)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .refreshable {
                        await apiManager.fetchRestaurantes()
                    }
                    .scrollDismissesKeyboard(.interactively)
                }
            }
            .navigationTitle("Restaurantes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        mostrarInsert = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }

            // INSERT
            .sheet(isPresented: $mostrarInsert) {
                RestauranteInsertView()
                    .environmentObject(apiManager)
                    .onDisappear {
                        Task { await apiManager.fetchRestaurantes() }
                    }
            }

            // UPDATE
            .sheet(item: $restauranteSeleccionado) { seleccionado in
                RestauranteUpdateView(restaurante: seleccionado)
                    .environmentObject(apiManager)
                    .onDisappear {
                        Task { await apiManager.fetchRestaurantes() }
                    }
            }

            // ALERTA DE ELIMINACIÓN
            .alert("Eliminar Restaurante",
                   isPresented: $mostrarDeleteAlert)
            {
                Button("Eliminar", role: .destructive) {
                    eliminarRestaurante()
                }
                Button("Cancelar", role: .cancel) {}
            } message: {
                Text("¿Seguro que deseas eliminar este restaurante?")
            }

        }
        .onAppear {
            Task { await apiManager.fetchRestaurantes() }
        }
    }

    // MARK: - ELIMINAR RESTAURANTE (versión corregida)
    private func eliminarRestaurante() {
        guard let r = restauranteSeleccionado else { return }

        Task {
            // 1) Llamada async a eliminar
            let ok = await apiManager.eliminarRestaurante(id: r.idrestaurante)

            // 2) Si fue ok, refrescamos (await) y luego animamos cualquier cambio en el main actor
            if ok {
                await apiManager.fetchRestaurantes()

                // Si quieres animar algo visible en la UI, hazlo en MainActor con withAnimation
                await MainActor.run {
                    withAnimation {
                        // aquí pones cambios sincronos sobre estados locales que quieras animar,
                        // p. ej. limpiar la selección:
                        restauranteSeleccionado = nil
                        mostrarDeleteAlert = false
                    }
                }
            }
        }
    }

}
