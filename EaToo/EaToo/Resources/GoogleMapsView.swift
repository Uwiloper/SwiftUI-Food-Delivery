//
//  GoogleMapsView.swift
//  EaToo
//
//  Created by Alumno on 24/11/25.
//

import GoogleMaps
import SwiftUI
import CoreLocation

// MARK: - GoogleMapsView (Adaptado para Múltiples Restaurantes y Fotos)
struct GoogleMapsView: UIViewRepresentable {
    let restaurantes: [Restaurante]
    
    // Coordenada central (Tu ubicación actual)
    private let miUbicacion = CLLocationCoordinate2D(latitude: -12.125244424854813, longitude: -77.02487924736556)
    
    // Zoom alto para ver un radio pequeño (50m requiere zoom alto, ej. 17.5 o 18)
    private let radioZoom: Float = 16.5

    func makeUIView(context: Context) -> GMSMapView {
        // 1. Establecer la cámara con el zoom adecuado para 50 metros.
        let camera = GMSCameraPosition.camera(withTarget: miUbicacion, zoom: radioZoom)
        let mapView = GMSMapView(frame: .zero, camera: camera)
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        uiView.clear()
        
        // --- 1. Agregar Marcador de Mi Ubicación (y el Círculo) ---
        let miMarker = GMSMarker(position: miUbicacion)
        miMarker.title = "Mi Ubicación"
        miMarker.snippet = "Estás aquí"
        miMarker.icon = GMSMarker.markerImage(with: .blue)
        miMarker.map = uiView
        
        // 1.b. Círculo: SOLO en mi ubicación, radio de 50 metros.
        let miCirculo = GMSCircle()
        miCirculo.position = miUbicacion
        miCirculo.radius = 100 // Circulo radar 50 metros!
        miCirculo.fillColor = UIColor.blue.withAlphaComponent(0.15) // Color azul para Mi Ubicación
        miCirculo.strokeColor = UIColor.blue.withAlphaComponent(0.6)
        miCirculo.strokeWidth = 2
        miCirculo.map = uiView
        
        // --- 2. Agregar Marcadores de Restaurantes (SIN CÍRCULO) ---
        for restaurante in restaurantes {
            guard let coord = restaurante.coordenada else { continue }
            
            let marker = GMSMarker()
            marker.position = coord
            marker.title = restaurante.nombre
            marker.snippet = restaurante.direccion
            
            // Requisito: Usar la foto del restaurante como ícono
            if let url = restaurante.fotoURL {
                cargarImagenYCrearIcono(from: url) { iconImage in
                    DispatchQueue.main.async {
                        marker.icon = iconImage
                        marker.map = uiView
                    }
                }
            } else {
                // Icono por defecto si no hay foto
                marker.icon = GMSMarker.markerImage(with: .systemRed)
                marker.map = uiView
            }
            
            // Nota: Se ha eliminado el código que agregaba el círculo aquí.
        }
    }
    
    // Función auxiliar para cargar imagen asíncronamente y crear un ícono de marcador (se mantiene igual)
    func cargarImagenYCrearIcono(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(GMSMarker.markerImage(with: .systemRed)) // Icono de fallback
                return
            }
            
            // Redimensionar y recortar la imagen a un círculo para usarla como ícono
            let size = CGSize(width: 40, height: 40)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            
            // Recortar a círculo/redondo
            let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), cornerRadius: 20)
            path.addClip()
            
            // Dibujar la imagen
            image.draw(in: CGRect(origin: .zero, size: size))
            
            let finalImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            completion(finalImage)
        }.resume()
    }
}
