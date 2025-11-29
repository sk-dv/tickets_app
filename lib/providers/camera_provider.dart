import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tickets_app/models/gemini_response.dart';
import 'package:tickets_app/services/gemini_service.dart';

enum CameraState { idle, capturing, processing, done, error }

class CameraStateData {
  final String? fotoPath;
  final CameraState state;
  final GeminiResponse? geminiData;
  final String? error;

  CameraStateData({
    this.fotoPath,
    this.state = CameraState.idle,
    this.geminiData,
    this.error,
  });

  CameraStateData copyWith({
    String? fotoPath,
    CameraState? state,
    GeminiResponse? geminiData,
    String? error,
  }) {
    return CameraStateData(
      fotoPath: fotoPath ?? this.fotoPath,
      state: state ?? this.state,
      geminiData: geminiData ?? this.geminiData,
      error: error ?? this.error,
    );
  }
}

final cameraProvider = StateNotifierProvider<CameraNotifier, CameraStateData>(
  (ref) => CameraNotifier(),
);

class CameraNotifier extends StateNotifier<CameraStateData> {
  final ImagePicker _picker = ImagePicker();
  final GeminiService _geminiService = GeminiService();

  CameraNotifier() : super(CameraStateData());

  Future<void> _readFile(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        state = state.copyWith(
          fotoPath: image.path,
          state: CameraState.processing,
        );

        await _analyzePhoto(image.path);
      } else {
        /// TODO. captura cancelada
      }
    } catch (e) {
      state = state.copyWith(
        state: CameraState.error,
        error: 'Error al capturar imagen: $e',
      );
    }
  }

  Future<void> _analyzePhoto(String imagePath) async {
    try {
      final geminiData = await _geminiService.analyzeTicket(imagePath);
      state = state.copyWith(geminiData: geminiData, state: CameraState.done);
    } catch (e) {
      state = state.copyWith(
        state: CameraState.error,
        error: 'Error al analizar ticket: $e',
      );
    }
  }

  Future<void> pickImage() async => _readFile(ImageSource.camera);

  Future<void> pickFromGallery() async => _readFile(ImageSource.gallery);

  void reset() {
    state = CameraStateData();
  }
}
