import 'package:applicatio01statemanagment/bloc/car_bloc.dart';
import 'package:applicatio01statemanagment/bloc/data_bloc.dart';
import 'package:applicatio01statemanagment/bloc/loginbloc.dart';
import 'package:applicatio01statemanagment/repo/apirepo.dart';
import 'package:applicatio01statemanagment/screens/login_page.dart';
import 'package:applicatio01statemanagment/providers/providers/provider_page.dart';
import 'package:applicatio01statemanagment/screens/mycatacalog.dart';
import 'package:applicatio01statemanagment/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
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

        child: MaterialApp(
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

