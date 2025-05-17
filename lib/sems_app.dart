import 'package:sems/core/bloc/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'router.dart';
import 'shared/theme/theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        
        return MaterialApp.router(
          
          title: 'SEMS',
          
          restorationScopeId: 'app',
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          debugShowCheckedModeBanner: false,
          theme: SEMSTheme.lightThemeData(),
          darkTheme: SEMSTheme.darkThemeData(),
          
          
          themeMode: state.themeMode,
          routerConfig: AppRouter.router,
          builder: (context, child) {
            return BlocListener<ThemeBloc, ThemeState>(
              
              listener: (context, state) {
                if (state.themeMode == ThemeMode.system) {
                  final brightness = MediaQuery.of(context).platformBrightness;
                  BlocProvider.of<ThemeBloc>(context)
                      .add(SystemThemeChangedEvent(brightness));
                }
              },
              child: child!,
            );
          },
        );
      },
    );
  }
}


