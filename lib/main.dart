import 'package:cinetix_id/firebase_options.dart';
import 'package:cinetix_id/presentation/providers/router/router_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'presentation/misc/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.saffron,
              surface: AppColors.backgroundColor,
              brightness: Brightness.dark),
          useMaterial3: true,
          textTheme: TextTheme(
            bodyMedium: GoogleFonts.poppins(color: AppColors.whiteColor),
            bodyLarge: GoogleFonts.poppins(color: AppColors.whiteColor),
            labelLarge: GoogleFonts.poppins(color: AppColors.whiteColor),
          )),
      debugShowCheckedModeBanner: false,
      routeInformationParser: ref.watch(routerProvider).routeInformationParser,
      routeInformationProvider:
          ref.watch(routerProvider).routeInformationProvider,
      routerDelegate: ref.watch(routerProvider).routerDelegate,
    );
  }
}
