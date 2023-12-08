import 'package:applicatio01statemanagment/bloc/cart_bloc.dart';
import 'package:applicatio01statemanagment/bloc/data_bloc.dart';
import 'package:applicatio01statemanagment/bloc/login_bloc.dart';
import 'package:applicatio01statemanagment/bloc/observer.dart';
import 'package:applicatio01statemanagment/bloc/wishlist_bloc.dart';
import 'package:applicatio01statemanagment/repo/repository.dart';
import 'package:applicatio01statemanagment/screens/splashscreen.dart';
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
    return MultiBlocProvider(
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
        home: SplashScreen(),
      ),
    );
  }
}
