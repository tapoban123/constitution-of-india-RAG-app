import 'package:constitution_app/controllers/chat_data_bloc/chat_data_bloc.dart';
import 'package:constitution_app/services/ai_generation_service.dart';
import 'package:constitution_app/view/home_screen.dart';
import 'package:constitution_app/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Constitution of India",
        theme: ThemeData.dark(),
        home: child,
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ChatDataBloc(aiGenerationService: AiGenerationService()),
          ),
        ],
        child: HomeScreen(),
      ),
    );
  }
}
