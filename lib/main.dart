import 'package:bloc/bloc.dart';
import 'package:e_commerce/core/bloc_observer/bloc_observer.dart';
import 'package:e_commerce/core/home_cubit/home_cubit.dart';
import 'package:e_commerce/views/auth/logic/cubit/auth_cubit.dart';
import 'package:e_commerce/views/auth/view/login/login_screen.dart';
import 'package:e_commerce/views/layout/view/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://vcavegqzgqjyitygssps.supabase.co',
    anonKey:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZjYXZlZ3F6Z3FqeWl0eWdzc3BzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg2MTAxMTYsImV4cCI6MjA1NDE4NjExNn0._vXRraAE5rnTSoBt80GX39JyHmNEMSDM9-ctOH2dOY0',
  );
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SupabaseClient client = Supabase.instance.client;

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: client.auth.currentUser != null ? LayoutScreen() : LoginScreen(),
      ),
    );
  }
}
