//
//  AppDelegate.swift
//  EaToo
//
//  Created by Alumno on 24/11/25.
//

import SwiftUI
import GoogleMaps
import CoreLocation

// MARK: - GoogleMapsAllView (Adaptado para Múltiples Restaurantes y Fotos)
struct GoogleMapsAllView: UIViewRepresentable {
    let restaurantes: [Restaurante]
    
    // Coordenada central (Tu ubicación actual proporcionada)
    private let miUbicacion = CLLocationCoordinate2D(latitude: -12.125244424854813, longitude: -77.02487924736556)
    private let defaultZoom: Float = 12.0 // Zoom adecuado para ver varios puntos

    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withTarget: miUbicacion, zoom: defaultZoom)
        let mapView = GMSMapView(frame: .zero, camera: camera)
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        uiView.clear()
        
        // --- 1. Agregar Marcadores y Círculos de Restaurantes ---
        for restaurante in restaurantes {
            // Asegúrate de que las coordenadas sean válidas (modelo Restaurante debe tener `coordenada: CLLocationCoordinate2D?`)
            guard let coord = restaurante.coordenada else { continue }
            
            let marker = GMSMarker()
            marker.position = coord
            marker.title = restaurante.nombre
            marker.snippet = restaurante.direccion
            
            // Requisito: Usar la foto del restaurante como ícono
            if let url = restaurante.fotoURL {
                // Función auxiliar para cargar imagen y crear un ícono de marcador
                cargarImagenYCrearIcono(from: url) { iconImage in
                    DispatchQueue.main.async {
                        marker.icon = iconImage
                        marker.map = uiView // Se asigna al mapa para que aparezca
                    }
                }
            } else {
                // Icono por defecto si no hay foto
                marker.icon = GMSMarker.markerImage(with: .systemRed)
                marker.map = uiView
            }
            
            // Círculo (Requisito de Evaluación)
            let circulo = GMSCircle()
            circulo.position = coord
            circulo.radius = 500 // 500 metros
            circulo.fillColor = UIColor.red.withAlphaComponent(0.1)
            circulo.strokeColor = UIColor.red.withAlphaComponent(0.6)
            circulo.strokeWidth = 1.5
            circulo.map = uiView
        }
    }
    
    // Función auxiliar para cargar imagen asíncronamente y crear un ícono de marcador
    func cargarImagenYCrearIcono(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(GMSMarker.markerImage(with: .systemRed)) // Icono de fallback
                return
            }
            
            // Redimensionar y recortar la imagen a un círculo/recuadro pequeño para usarla como ícono
            let size = CGSize(width: 40, height: 40)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            
            // Crear una máscara redondeada
            let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), cornerRadius: 5)
            path.addClip()
            
            // Dibujar la imagen
            image.draw(in: CGRect(origin: .zero, size: size))
            
            // Obtener el resultado
            let finalImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            completion(finalImage)
        }.resume()
    }
}


