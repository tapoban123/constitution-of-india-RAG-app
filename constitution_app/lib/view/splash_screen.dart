import 'dart:async';

import 'package:constitution_app/controllers/chat_history_cubit.dart';
import 'package:constitution_app/utils/constants.dart';
import 'package:constitution_app/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    context.read<ChatHistoryCubit>().fetchChatHistory();

    timer = Timer(Duration(seconds: 1), () {
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween(begin: Offset(1, 0), end: Offset.zero).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastEaseInToSlowEaseOut,
              ),
            );

            return SlideTransition(position: tween, child: child);
          },
          transitionDuration: Duration(milliseconds: 400),
        ),
        (route) => false,
      );
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Indian Constitutional Law \nby \nDr. MP Jain",
                style: TextStyle(
                  fontFamily: FontFamily.Lexend_Medium.name,
                  fontSize: 46.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
