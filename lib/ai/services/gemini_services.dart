import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:sems/core/constants/assets.dart';

class GeminiService {
  static final GeminiService _instance = GeminiService._internal();
  late final GenerativeModel _model;
  factory GeminiService() => _instance;
  GeminiService._internal() {
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: MySEMSKey.geminiKey,
    );
  }

  Future<String> getResponse(String prompt) async {
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'SEMS AI Facing Some Issue';
    } catch (e) {
      return 'Error generating response: ${e.toString()}';
    }
  }
}
