import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/bloc/theme/theme_bloc.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: () {
            context.read<ThemeBloc>().add(ToggleThemeEvent());
          },
          child: Icon(state.icon),
        );
      },
    );
  }
}
