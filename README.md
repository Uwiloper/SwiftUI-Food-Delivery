<div align="center">
  <a href="https://github.com/tu-usuario/EaToo">
    <img src="https://raw.githubusercontent.com/tu-usuario/EaToo/main/EaToo/Assets.xcassets/logo_eatoo.imageset/logo_eatoo.png" alt="Logo EaToo" width="120" height="120">
  </a>

  <h1 align="center">EaToo</h1>

  <p align="center">
    <strong>Food Delivery Experience. Redefined.</strong>
    <br />
    Aplicación nativa iOS desarrollada con SwiftUI y Clean Architecture.
    <br />
    <br />
    <a href="#-demo">Ver Demo</a>
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
  <img src="DOCS/screenshot_home.png" width="200" alt="Home Screen" style="border-radius: 20px; margin: 10px;">
  <img src="DOCS/screenshot_map.png" width="200" alt="Map View" style="border-radius: 20px; margin: 10px;">
  <img src="DOCS/screenshot_detail.png" width="200" alt="Product Detail" style="border-radius: 20px; margin: 10px;">
  <img src="DOCS/screenshot_cart.png" width="200" alt="Cart View" style="border-radius: 20px; margin: 10px;">
</div>

<br />

##  Sobre el Proyecto

**EaToo** no es solo una app de delivery; es una implementación robusta de ingeniería de software móvil moderna. Construida enteramente en **SwiftUI**, la aplicación demuestra el uso de patrones de diseño avanzados (**MVVM**), concurrencia estructurada y geolocalización precisa.

La aplicación consume una **API RESTful propietaria** alojada en infraestructura dedicada (Alwaysdata), gestionando desde la autenticación de usuarios hasta la administración compleja de restaurantes y menús en tiempo real.

---

## ✨ Funcionalidades Principales

### 📍 Experiencia de Geolocalización
Integración profunda con **Google Maps SDK (v10.6.0)** para ofrecer una experiencia visual inmersiva:
* **Radar de Proximidad:** Visualización de radio de alcance de 500m mediante `GMSCircle`.
* **Marcadores Dinámicos:** Los pines del mapa renderizan en tiempo real la foto del restaurante usando `UIGraphicsImageRenderer`.
* **Rastreo en Vivo:** Seguimiento de la ubicación del usuario mediante `CoreLocation`.

### 🛍️ Gestión de Pedidos & E-Commerce
* **Carrito Inteligente:** Lógica de negocio local (`GestorCarrito`) para calcular totales y validar items.
* **Persistencia Híbrida:** Uso de `UserDefaults` para historial local y sincronización con base de datos remota MySQL.
* **Checkout Flow:** Pasarela de pago simulada con validación de métodos y confirmación de órdenes.

### 🔐 Panel Administrativo (CMS Móvil)
Un sistema de gestión de contenido completo integrado en la app:
* **CRUD de Restaurantes:** Crear, leer, actualizar y eliminar locales comerciales.
* **Gestión de Usuarios:** Administración de perfiles y permisos directamente desde la interfaz móvil.
* **Networking Asíncrono:** Todas las operaciones de escritura utilizan `async/await` con `URLSession` para no bloquear el hilo principal.

---

## 🛠️ Especificaciones Técnicas

### Arquitectura & Diseño
El proyecto sigue una arquitectura **MVVM (Model-View-ViewModel)** estricta para separar la lógica de negocio de la interfaz de usuario, facilitando la escalabilidad y el testing.

* **Tipografía:** Sistema de fuentes personalizado utilizando la familia **Inter** (Regular, Bold, Light) inyectado vía `EnvironmentValues`.
* **UI Components:** Uso de `ViewModifier` personalizados para estandarizar botones (`PillButton`) y tarjetas.

### Stack Tecnológico
| Componente | Tecnología | Descripción |
| :--- | :--- | :--- |
| **Mobile Client** | SwiftUI 3 / Swift 5 | Desarrollo 100% nativo declarative. |
| **Maps Engine** | Google Maps SDK | Versión 10.6.0 gestionada vía SPM. |
| **Backend** | PHP 8.1 / MySQL | API REST hospedada en *uwil.alwaysdata.net*. |
| **Networking** | URLSession | Peticiones `multipart/form-data` y decodificación JSON (`Codable`). |

---

## 🚀 Instalación y Despliegue

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

<div align="center">
  <p>Diseñado y Desarrollado con ❤️ por <strong>[Tu Nombre]</strong></p>
  <p>
    <a href="LINK_A_LINKEDIN"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=flat&logo=linkedin&logoColor=white" alt="LinkedIn"/></a>
    <a href="LINK_A_PORTFOLIO"><img src="https://img.shields.io/badge/Portfolio-100000?style=flat&logo=vercel&logoColor=white" alt="Portfolio"/></a>
  </p>
</div>
