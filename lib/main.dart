import 'package:applicatio01statemanagment/bloc/cart_bloc.dart';
import 'package:applicatio01statemanagment/bloc/data_bloc.dart';
import 'package:applicatio01statemanagment/bloc/login_bloc.dart';
import 'package:applicatio01statemanagment/bloc/observer.dart';
import 'package:applicatio01statemanagment/repo/repository.dart';
import 'package:applicatio01statemanagment/screens/loginscreen.dart';
import 'package:applicatio01statemanagment/providers/providers/provider_page.dart';
import 'package:applicatio01statemanagment/screens/listscreen.dart';
import 'package:applicatio01statemanagment/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  Bloc.observer = MyGlobalObserver();


  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  final Repo repo = Repo();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [ BlocProvider<DataBloc>(create: (context) => DataBloc()),
                     BlocProvider<CartBloc>(create: (context) => CartBloc(repo)),
                     BlocProvider<LoginBloc>(create: (context)=> LoginBloc()),
        ],

        child: MaterialApp(darkTheme: ThemeData.dark(useMaterial3: true),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
    );

  }
}




/*class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => DataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),);
  }
}

 */

