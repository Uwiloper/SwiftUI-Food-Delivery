<div align="center">
<img width="180" height="180" alt="logo_eatoo" src="https://github.com/user-attachments/assets/22b3784a-e6c3-4ef2-9fbf-170e36985d4f" />
</a>

  <h1 align="center">Ecommerce EaToo Swift</h1>

  <p align="center">
    <strong>Food Delivery Experience. Redefined.</strong>
    <br />
    Aplicación nativa iOS desarrollada con SwiftUI.
    <br />
    <br />
    <a href="#-demo">Ver Video</a>
    ·
    <a href="#-features">Funcionalidades</a>
    ·
    <a href="#-installation">Instalación</a>
  </p>

  <p align="center">
    <img src="https://img.shields.io/badge/iOS-15.0+-000000?style=for-the-badge&logo=apple&logoColor=white" alt="iOS 15+">
    <img src="https://img.shields.io/badge/Swift-5.0-F05138?style=for-the-badge&logo=swift&logoColor=white" alt="Swift 5">
    <img src="https://img.shields.io/badge/SwiftUI-3.0-007AFF?style=for-the-badge&logo=swift&logoColor=white" alt="SwiftUI">
    <img src="https://img.shields.io/badge/Backend-PHP%20%26%20MySQL-777BB4?style=for-the-badge&logo=php&logoColor=white" alt="PHP MySQL">
  </p>
</div>

<br />

<div align="center">
  <img width="1920" height="310" alt="Eatoo-tira-01" src="https://github.com/user-attachments/assets/60b286d9-4cf3-4b8d-ae8b-ca42807f7377" />
</div>

<br />

##  Sobre el Proyecto

**EaToo** es una app de delivery móvil moderna. Construida enteramente en **SwiftUI**, la app presenta el uso del patrón (**MVVM**), concurrencia estructurada y geolocalización usando GoogleMaps Api for SDK.

La aplicación consume una **API RESTful propia** alojada en Alwaysdata, gestionando desde la autenticación de usuarios hasta la administración de restaurantes y menús en tiempo real.

---

## Funcionalidades Principales

### Experiencia de Geolocalización
Integración profunda con **Google Maps SDK (v10.6.0)** para ofrecer una experiencia visual inmersiva:
* **Radar de Proximidad:** Visualización de radio de alcance de 500m mediante `GMSCircle`.
* **Marcadores Dinámicos:** Los pines del mapa renderizan en tiempo real la foto del restaurante usando `UIGraphicsImageRenderer`.
* **Rastreo en Vivo:** Seguimiento de la ubicación del usuario mediante `CoreLocation`.

### Gestión de Pedidos & E-Commerce
* **Carrito de compras:** Lógica de negocio local (`GestorCarrito`) para calcular totales y validar items.
* **Persistencia:** Uso de `UserDefaults` para historial local y sincronización con base de datos remota MySQL.
* **Checkout Flow:** Pasarela de pago simulada con validación de métodos y confirmación de órdenes.

### Panel Administrativo (CMS Móvil)
Un sistema de gestión de contenido completo integrado en la app:
* **CRUD de Restaurantes, Productos, etc:** Crear, leer, actualizar y eliminar datos.
* **Gestión de Usuarios:** Administración de perfiles y permisos directamente desde la interfaz móvil.
* **Networking Asíncrono:** Todas las operaciones de escritura utilizan `async/await` con `URLSession` para no bloquear el hilo principal.

---

## Especificaciones Técnicas

### Arquitectura & Diseño
El proyecto sigue una arquitectura **MVVM (Model-View-ViewModel)** estricta para separar la lógica de negocio de la interfaz de usuario, facilitando la escalabilidad y el testing.

* **Tipografía:** Sistema de fuentes personalizado utilizando la familia **Inter** (Regular, Bold, Light) inyectado vía `EnvironmentValues`.
* **UI Components:** Uso de `ViewModifier` personalizados para estandarizar botones (`PillButton`) y tarjetas.

### Stack Tecnológico
| Componente | Tecnología | Descripción |
| :--- | :--- | :--- |
| **Mobile Client** | SwiftUI 3 / Swift 5 | Desarrollo 100% nativo. |
| **Maps Engine** | Google Maps SDK | Versión 10.6.0 gestionada vía SPM. |
| **Backend** | PHP / MySQL | API REST hospedada en *alwaysdata.net*. |
| **Networking** | URLSession | Peticiones `multipart/form-data` y decodificación JSON (`Codable`). |

---

## Instalación y Despliegue

Sigue estos pasos para ejecutar el proyecto en tu entorno local (macOS).

### Prerrequisitos
* Xcode 13.0+
* iOS 15.0+

### Pasos

1.  **Clonar el repositorio**
    ```bash
    git clone [https://github.com/tu-usuario/EaToo.git](https://github.com/tu-usuario/EaToo.git)
    ```

2.  **Abrir el Proyecto**
    Abre el archivo `EaToo.xcodeproj`. Xcode comenzará automáticamente a resolver los paquetes Swift (Google Maps SDK).

3.  **Configuración de API Key**
    Para que los mapas carguen, debes añadir tu propia API Key en `AppDelegate.swift`.
    ```swift
    // Ubicación: EaToo/Api/AppDelegate.swift
    GMSServices.provideAPIKey("TU_GOOGLE_MAPS_API_KEY")
    ```

4.  **Compilar y Ejecutar**
    Selecciona un simulador (ej. iPhone 14 Pro) y presiona `Cmd + R`.

---
![Eatoo Swift Fondo Perfil Fotos-01](https://github.com/user-attachments/assets/da7865c2-fe8f-46ec-b98c-b52136079ba9)

<div align="center">
    <p>Diseño basado en: </p>
  <a href="https://www.behance.net/gallery/229420607/Food-Delivery-App-UIUX-Case-Study">Food Delivery App UI/UX Case Study</a> 
</div>
