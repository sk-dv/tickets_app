# Tickets App

App Flutter para digitalizar tickets de compra usando IA.

## Flujo

1. **Captura**: Foto del ticket
2. **Extracción**: Gemini AI analiza y extrae datos
3. **Revisión**: Usuario valida/corrige campos
4. **Almacenamiento**: Guarda ticket y training data

## Sistema de confianza

Cada ticket extraído por IA recibe una **puntuación de precisión**:

```
confianza = (campos sin modificar / 7) × 100
```

- 🟢 ≥80%: Alta precisión
- 🟡 ≥60%: Precisión media
- 🔴 <60%: Baja precisión

## Base de datos

### `tickets`
Tickets finales (corregidos por usuario)

### `training_data`
Comparación Gemini vs Usuario para mejorar el modelo:
- `gemini_original`: Extracción inicial de IA
- `usuario_correccion`: Datos corregidos
- `confianza_gemini`: Precisión del modelo
- `ticket_id`: Relación con ticket guardado

## Entrenamiento

**Datos valiosos** (confianza < 70%):
```sql
SELECT * FROM training_data
WHERE confianza_gemini < 70
ORDER BY confianza_gemini ASC;
```

**Dataset categorización**:
```sql
SELECT
  usuario_correccion->>'comercio' as comercio,
  categoria_final
FROM training_data
WHERE confianza_gemini >= 70;
```

## Tech Stack

- Flutter + Riverpod
- Gemini 2.5 Flash
- Supabase
