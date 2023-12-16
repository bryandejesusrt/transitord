# App Agente de Tránsito RD (Digesett)

![Cover Proyecto final](https://github.com/Bryan-r15/transitord/assets/71520172/de7f19ac-25ec-4495-b558-cd4dec085955)

## Objetivo del Proyecto:
Desarrollar una aplicación móvil utilizando Flutter para agentes de tránsito en la República Dominicana. La aplicación permitirá a los agentes gestionar multas de tráfico, acceder a información vehicular, consultar datos de conductores y obtener información relevante como noticias de la DIGESET, estado del clima y horóscopo.

## Funcionalidades Principales:

- **Inicio de Sesión:** Los agentes deberán iniciar sesión para acceder al menú principal de la aplicación.

- **Tarifario de Multas:** Consulta de todos los tipos de multas con sus respectivos detalles.

- **Consulta de Vehículo por Placa:** Inserción de la matrícula de un vehículo para visualizar sus detalles.

- **Consulta de Conductor por Licencia:** Inserción del número de licencia para mostrar foto, nombre, apellido, fecha de nacimiento, dirección y teléfono del conductor.

- **Aplicar Multa:** Registro de una multa de tránsito con detalles como cédula del infractor, placa del vehículo, motivo de la multa, foto de evidencia, comentario, nota de voz, latitud, longitud, fecha y hora.

- **Multas Registradas:** Consulta de las multas registradas por el agente, con detalles como código, nombre y motivo.

- **Mapa de Multas:** Visualización en un mapa de las multas registradas por el agente, con opción para ver detalles al hacer clic en cada multa.

- **Noticias de DIGESET:** Mostrará noticias importantes para el agente provenientes de la DIGESET mediante la API de Remolacha.

- **Estado del Clima:** Enviará la ubicación del agente para mostrar el clima actual en esa zona mediante una API externa.

- **Horóscopo Diario:** Proporcionará el horóscopo diario para el agente.

## Integrantes del Grupo de Desarrollo:


- [Bryan De Jesus Rosa Tavarez(2021-2239)](https://github.com/bryandejesusrt)
- [Yoniber Encarnacion(2021-1442)](https://github.com/yoniberplay)
- [Sander Arias (2020-10182))](https://github.com/HabunoGD1809)
- [Frankli Joel Valdez (2022-0678)](https://github.com/SanderArias)

## Enlaces:

Codigo: [FrontEnd:]([https://transitord20231207185629.azurewebsites.net/swagger/index.html](https://github.com/Bryan-r15/transitord))</br>
[ BackEnd:](https://github.com/Bryan-r15/TransitordAPI).</br>
APK: [APK de la Aplicación:](https://drive.google.com/file/d/1T8BDoUdTnb0-i7-S2IGagtLara672mr6/view)</br>
API: [API del Projectot:](https://transitord20231207185629.azurewebsites.net/swagger/index.html)</br>
</br></br>

![Pantalla1 proyecto final](https://github.com/Bryan-r15/transitord/assets/71520172/35d26b81-ebd1-4bb5-aec7-45f848af5158)</br></br>

![Pantalla2 proyecto final](https://github.com/Bryan-r15/transitord/assets/71520172/d04843e1-1a07-4b85-9a97-78031f129073)</br></br>

![Pantalla5 proyecto final](https://github.com/Bryan-r15/transitord/assets/71520172/3d1abe8e-e778-49b3-8e2f-ebc21fa8c7ed)</br></br>

![Pantalla3 proyecto final](https://github.com/Bryan-r15/transitord/assets/71520172/2b479965-5614-4ec7-8c4c-b0df5de3365a)</br></br>

![Pantalla4 proyecto final](https://github.com/Bryan-r15/transitord/assets/71520172/902d85af-4530-4056-8dde-e882a3e6e527)</br></br>

## Inicialización del Proyecto Flutter

Este archivo describe los pasos necesarios para inicializar el proyecto Flutter después de clonarlo o descargarlo.

### Requisitos Previos

- [Flutter](https://flutter.dev/docs/get-started/install) debe estar instalado en tu máquina.
- Asegúrate de tener todas las dependencias necesarias instaladas. Puedes ejecutar el siguiente comando:

  ```bash
  
  flutter doctor
  ```
  Asegúrate de solucionar cualquier problema identificado por flutter doctor antes de continuar.

### Pasos de Inicialización
**Descargar el Proyecto:**
Clona el repositorio o descarga el proyecto desde GitHub.

```bash
git clone https://github.com/tu-usuario/tu-proyecto-flutter.git
```

### Limpiar el Proyecto:
Ejecuta el siguiente comando para limpiar el proyecto.
```bash
lutter clean
```

### Obtener Dependencias:
Ejecuta el siguiente comando para obtener todas las dependencias del proyecto.
```
flutter pub get
```
Esto descargará todas las dependencias definidas en el archivo **pubspec.yaml.**

### Configuración Adicional (si es necesario):
Realiza cualquier configuración adicional necesaria según las instrucciones del proyecto.

## Ejecutar la Aplicación
Una vez completados los pasos anteriores, puedes ejecutar la aplicación Flutter con el siguiente comando:
``
bash

flutter run
``
Esto iniciará la aplicación en el emulador o dispositivo conectado.


A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
