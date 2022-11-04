import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zataca/bloc/registers/cubit/registers_cubit.dart';
import 'package:flutter_zataca/screens/screens.dart';
import 'package:flutter_zataca/bloc/liked/liked_cubit.dart';
import 'package:flutter_zataca/services/petitions.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;
void main() async{
  
  //WidgetsFlutterBinding.ensureInitialized();

  await injectDependences();

  runApp(MyApp());
}

Future<void> injectDependences() async{

  getIt.registerLazySingleton(() => Petitions());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ( _ ) => LikedCubit()),
        BlocProvider(create: ( _ ) => RegistersCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
        },
        theme: ThemeData.light().copyWith(
          primaryColor: const Color.fromRGBO(38,154,143,1),
        )
      ),
    );
  }
}