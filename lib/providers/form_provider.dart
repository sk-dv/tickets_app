import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tickets_app/models/gemini_response.dart';

enum FormStep { editing, confirming }

class FormState {
  final GeminiResponse? geminiData;
  final GeminiResponse? userCorrections;
  final FormStep step;
  final bool isLoading;

  FormState({
    this.geminiData,
    this.userCorrections,
    this.step = FormStep.editing,
    this.isLoading = false,
  });

  FormState copyWith({
    GeminiResponse? geminiData,
    GeminiResponse? userCorrections,
    FormStep? step,
    bool? isLoading,
  }) {
    return FormState(
      geminiData: geminiData ?? this.geminiData,
      userCorrections: userCorrections ?? this.userCorrections,
      step: step ?? this.step,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final formProvider = StateNotifierProvider<FormNotifier, FormState>((ref) {
  return FormNotifier();
});

class FormNotifier extends StateNotifier<FormState> {
  FormNotifier() : super(FormState());

  void setGeminiData(GeminiResponse data) {
    state = state.copyWith(geminiData: data);
  }

  void setUserCorrections(GeminiResponse corrections) {
    state = state.copyWith(userCorrections: corrections);
  }

  void moveToConfirming() {
    state = state.copyWith(step: FormStep.confirming);
  }

  void moveToEditing() {
    state = state.copyWith(step: FormStep.editing);
  }

  void reset() {
    state = FormState();
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}