import 'package:e_commerce/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'core/bloc_observer/bloc_observer.dart';
import 'core/helper/cache.dart';
import 'core/home_cubit/home_cubit.dart';
import 'features/auth/logic/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await supabase.Supabase.initialize(
    url: 'https://vcavegqzgqjyitygssps.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZjYXZlZ3F6Z3FqeWl0eWdzc3BzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg2MTAxMTYsImV4cCI6MjA1NDE4NjExNn0._vXRraAE5rnTSoBt80GX39JyHmNEMSDM9-ctOH2dOY0',
  );

  Bloc.observer = MyBlocObserver();
  runApp(BlocProvider(
    create: (context) => AuthCubit()..getData(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final supabase.SupabaseClient client = supabase.Supabase.instance.client;

  MyApp({super.key});

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
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
