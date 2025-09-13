import 'package:constitution_app/controllers/chat_data_bloc/chat_data_bloc.dart';
import 'package:constitution_app/controllers/chat_history_cubit.dart';
import 'package:constitution_app/services/ai_generation_service.dart';
import 'package:constitution_app/services/chat_history_local_storage_service.dart';
import 'package:constitution_app/utils/hive_config.dart';
import 'package:constitution_app/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await HiveConfig().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ChatDataBloc(
              aiGenerationService: AiGenerationService(),
              chatHistoryLocalStorageService: ChatHistoryLocalStorageService(),
            ),
          ),
          BlocProvider(
            create: (context) => ChatHistoryCubit(
              chatHistoryLocalStorageService: ChatHistoryLocalStorageService(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Indian Constitutional Law",
          theme: ThemeData.dark(),
          home: child,
        ),
      ),
      child: SplashScreen(),
    );
  }
}
