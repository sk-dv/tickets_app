# PROYECTO: TICKETS APP - CONTINUIDAD

## 📱 CONTEXTO GENERAL
Sistema mobile (Flutter iOS) para registrar y procesar tickets de compra.
- Extracción automática con Gemini Vision
- Modelos ML locales (Random Forest + Árbol Decisión) que se retroalimentan
- UI minimalista con estética pastel
- Single-user por ahora

## 🎨 DISEÑO VISUAL (CONFIRMADO)
**Paleta Pastel/Suave:**
- Primary: #9B8FE8 (morado pastel)
- Secondary: #D4C5F9
- Success: #A8D5BA (verde pastel)
- Warning: #F4D4A8
- Error: #E8A8A8
- Neutral: grises suaves (#FAFAFA → #2A2A2A)
- Manual badge: verde, Auto badge: morado
- Bordes: 20px (muy redondeados)
- Typography: Poppins
- Sombras: sutil (elevation 2-4)
- Espaciado: 8px base
- Iconos: Feather Icons
- Animaciones: checkmark elastic, transiciones 200-300ms, micro-interacciones

**Componentes creados:**
- TicketCard (comercio, fecha, total, icon categoría, badge manual/auto, # productos)
- AppButton (primary, con scale animation)
- AppFormField (focus animation, label float)
- CategoryIconMapper (dinámico por categoría)
- ConfirmationView (checkmark scale + resumen)

## 🏗️ ARQUITECTURA TÉCNICA

**Stack:**
- Frontend: Flutter + Riverpod (state management)
- Backend: FastAPI Python
- BD: Supabase
- ML: Random Forest (errores) + Árbol Decisión (categoría)
- Modelos: TFLITE local en app
- Fotos: almacenamiento local en dispositivo (ruta en BD)

**Tablas Supabase:**
1. `tickets` (existente) + agregar columna `handmade: boolean`
2. `training_data` (nueva) con: usuario_id, comercio, foto_path, gemini_original (JSONB), usuario_correccion (JSONB), categoria_final, timestamp, handmade

## 📁 ESTRUCTURA CARPETAS (CONFIRMADA)
```
lib/
├── core/theme/ (app_colors.dart, app_theme.dart)
├── screens/ (home_screen.dart, ticket_form_modal.dart)
├── widgets/ (ticket_card.dart, app_button.dart, form_field.dart, confirmation_view.dart)
├── providers/ (ticket_provider.dart, form_provider.dart, camera_provider.dart)
├── services/ (api_service.dart, supabase_service.dart, gemini_service.dart)
├── models/ (ticket.dart, gemini_response.dart, training_data.dart)
└── utils/ (category_icon_mapper.dart)
```

## 🔄 FLUJO DE USUARIO (FINAL)
1. Home: lista tickets con diferenciación manual/auto
2. FAB (+): cámara/galería
3. Foto → Modal bottom sheet (dismissible)
4. Formulario pre-llenado por Gemini
5. Modelos TFLITE muestran confianza por campo
6. Usuario edita
7. Guardar → confirmación (checkmark animado) + resumen
8. API recibe correcciones → retroalimenta modelos
9. Próxima semana: reentrenamiento automático

## ✅ QUÉ YA EXISTE
- UI completa (Home + Modal + Confirmación)
- Diseño system implementado
- Providers (Riverpod) con estado
- Componentes base funcionando
- Datos simulados en home

## ❌ QUÉ FALTA
1. Conectar Supabase (guardar/fetch tickets)
2. Integrar Gemini Vision API (extracción real)
3. Cargar modelos TFLITE locales (predicciones)
4. API backend endpoints
5. Crear tabla training_data SQL
6. Servicio de cámara real (solo mock ahora)

## 📌 PRÓXIMOS PASOS
- A: Integración Supabase
- B: Integración Gemini Vision  
- C: Modelos TFLITE locales

Recomendación: A → B → C en ese orden

## 📦 pubspec.yaml COMPLETO
```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.1.0
  flutter_feather_icons: ^2.0.0
  riverpod: ^2.4.0
  flutter_riverpod: ^2.4.0
  riverpod_generator: ^2.3.0
  supabase_flutter: ^2.0.0
  image_picker: ^1.0.0
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.0
  riverpod_generator: ^2.3.0
```

## 🚀 COMANDOS REFERENCIAS
```bash
flutter clean
flutter pub get
flutter pub run build_runner build
flutter run -d ios
```

## 📝 NOTAS IMPORTANTES
- Todos los componentes están implementados
- La app corre sin errores con datos simulados
- Design system completo y funcional
- Estado management con Riverpod configurado
- Single-user (sin autenticación)
- Almacenamiento de fotos: local en dispositivo
