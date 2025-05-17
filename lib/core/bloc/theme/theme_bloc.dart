import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {}

class SystemThemeChangedEvent extends ThemeEvent {
  final Brightness brightness;

  const SystemThemeChangedEvent(this.brightness);

  @override
  List<Object> get props => [brightness];
}

// States
class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final IconData icon;

  const ThemeState(this.themeMode, this.icon);

  @override
  List<Object> get props => [themeMode, icon];
}

// BLoC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(const ThemeState(ThemeMode.light, Icons.brightness_auto)) {
    on<ToggleThemeEvent>(_onToggleTheme);
    on<SystemThemeChangedEvent>(_onSystemThemeChanged);
  }

  void _onToggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) {
    switch (state.themeMode) {
      case ThemeMode.light:
        emit(const ThemeState(ThemeMode.dark, Icons.light_mode));
        break;
      case ThemeMode.dark:
        emit(const ThemeState(ThemeMode.light, Icons.dark_mode));
        break;
      
      case ThemeMode.system:
        if (state.themeMode == ThemeMode.dark) {
          emit(const ThemeState(ThemeMode.light, Icons.dark_mode));
        } else {
          emit(const ThemeState(ThemeMode.dark, Icons.light_mode));
        }
    }
  }

  void _onSystemThemeChanged(
      SystemThemeChangedEvent event, Emitter<ThemeState> emit) {
    if (state.themeMode == ThemeMode.system) {
      final icon = event.brightness == Brightness.light
          ? Icons.dark_mode
          : Icons.light_mode;
      emit(ThemeState(ThemeMode.system, icon));
    }
  }
}
