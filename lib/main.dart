import 'package:dio/dio.dart';
import 'package:effectivemobile/api/reservation_api.dart';
import 'package:effectivemobile/app_routes.dart';
import 'package:effectivemobile/bloc/reservation_bloc.dart';
import 'package:effectivemobile/screens/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: BlocProvider(
        create: (context) {
          final dio = Dio(); // Create a Dio instance
          final api = ReservationApi(dio);
          return ReservationBloc(api);
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: 'SF Pro Display',
          ),
          // home: const MainScreen(),
          initialRoute: '/',
          routes: routes,
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
                builder: (context) => const NotFoundScreen());
          },
        ),
      ),
    );
  }
}
