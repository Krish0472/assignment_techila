import 'package:applicatio01statemanagment/screens/loginscreen.dart';
import 'package:applicatio01statemanagment/screens/splashscreen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.black,
        body: SafeArea(child: _RegisterScreenPage()),
      ),
    );
  }

}

class _RegisterScreenPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _RegisterScreenPageState();
  }
}

class _RegisterScreenPageState extends State<_RegisterScreenPage>{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(color: Colors.black,
        child: ClipRRect(
          borderRadius:
          BorderRadius.all(Radius.circular(30)),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,borderRadius: BorderRadius.circular(30.0)),
            height: MediaQuery.of(context).size.height-35,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Align(alignment: Alignment.center,child: Text('Sign up with one of the following.',style: TextStyle(fontSize: 14),)),
                ),
                Padding(padding: const EdgeInsets.only(left: 35.0,top: 3.0,bottom: 45.0),
                child:   Row(
                  children: [
                    GestureDetector(
                      child: Card(
                        elevation: 2,
                        child: SizedBox(
                            height:50,
                            width: 100,
                            child: Image.asset('asset/icons8-gmail-48.png')
                        ),
                      ),onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
                    },
                    ),
                    const Padding(padding: EdgeInsets.only(left: 70.0)),
                    GestureDetector(onTap: (){
                      print('hiii');
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                      child:  Card(elevation: 2,
                        child: SizedBox(
                            height:50,
                            width:100,
                            child: Image.asset('asset/icons8-apple-48.png')),
                      ),
                    )

                  ],
                )
                ),
                Padding(padding: EdgeInsets.only(left: 12.0,top: 10),
                  child: Row(children: [
                   Container(height: 1.0,width: MediaQuery.of(context).size.width/2.3,color: Colors.black,),
                  Align(alignment: Alignment.center,child:Text(' OR ')),
                    Container(height: 1.0,width: MediaQuery.of(context).size.width/2.3,color: Colors.black,),

                ],),),
                const Padding(padding: EdgeInsets.only(top: 30.0,left: 12.0),
                child: Align(alignment: Alignment.topLeft,child: Text('name*'),),),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: 'enter your name here',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(35.0)),borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid)),),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10.0,left: 12.0),
                  child: Align(alignment: Alignment.topLeft,child: Text('email*'),),),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: 'enter your email here',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(35.0)),borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid)),),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10.0,left: 12.0),
                  child: Align(alignment: Alignment.topLeft,child: Text('password*'),),),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: 'create your password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(35.0)),borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid)),),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 12.0,bottom: 20.0),child: Align(alignment: Alignment.topLeft,child: Text('must be at least 8 characters',style: TextStyle(color: Colors.red),),),),
                SizedBox(height:50,
                    width:339,
                    child: ElevatedButton(onPressed: (){
                      print('register called');
                    },
                      child: Text('Register'),style: ElevatedButton.styleFrom(shape: StadiumBorder(),backgroundColor: Colors.blue),)
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0,bottom: 10.0),
                  child: Text('Already have an account?',style: TextStyle(fontWeight: FontWeight.normal),),
                ),
                SizedBox(height:50,
                    width:339,
                    child: ElevatedButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                      child: const Text('Log In'),style: ElevatedButton.styleFrom(shape: StadiumBorder(),backgroundColor: Colors.blue))
                ),


              ],

            ),
          ),
        ),
      ),
    );
  }
}