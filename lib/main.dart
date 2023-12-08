import 'package:assignment_techila/bloc/cart_bloc.dart';
import 'package:assignment_techila/bloc/data_bloc.dart';
import 'package:assignment_techila/bloc/login_bloc.dart';
import 'package:assignment_techila/bloc/observer.dart';
import 'package:assignment_techila/bloc/wishlist_bloc.dart';
import 'package:assignment_techila/repo/repository.dart';
import 'package:assignment_techila/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MyGlobalObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Repo repo = Repo();

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(    //multiBlocPRovider for bloc
      providers: [
        BlocProvider<DataBloc>(create: (context) => DataBloc()),
        BlocProvider<CartBloc>(create: (context) => CartBloc(repo)),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<WishListBloc>(
          create: (context) => WishListBloc(repo),
        )
      ],
      child: MaterialApp(
        darkTheme: ThemeData.dark(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
