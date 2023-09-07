import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>BlocPage()
            // ProviderPage()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width:MediaQuery.of(context).size.width ,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue,Colors.white,]
          ),
        ),
        child: Column(
          children: [
            Image.network(
              width: MediaQuery.of(context).size.width,
              height: 400,
             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1wS8YtYLhEs4xrxk7u0LX3E0wRXOEXXR6_M1NcBzRjf30up0-dcM1rw9XPXE6OIFBpdU&usqp=CAU' ,
            ),
            const Text("Home Delivery Partner",textAlign:TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const CircularProgressIndicator(
              valueColor:  AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
