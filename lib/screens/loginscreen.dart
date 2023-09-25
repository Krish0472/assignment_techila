import 'package:applicatio01statemanagment/bloc/data_bloc.dart';
import 'package:applicatio01statemanagment/bloc/data_event.dart';
import 'package:applicatio01statemanagment/screens/listscreen.dart';
import 'package:applicatio01statemanagment/screens/registerscreen.dart';
import 'package:applicatio01statemanagment/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/data_state.dart';
import '../bloc/login_event.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';
import 'homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  HomePage();
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Card(
            color: Colors.black,
            elevation: 6,
            child: ClipRRect(
              borderRadius:
               BorderRadius.all(Radius.circular(30)),
              child: Container(height: MediaQuery.of(context).size.height-35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1.0)
                ),
                child: Column(
                  children: [
                     Padding(padding: const EdgeInsets.symmetric(vertical: 55,horizontal: 23),
                    child:
                        Column(
                          children: [
                            Card(child: const Text('Log in with one of the following')),
                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                GestureDetector(
                                  child: Card(
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
                                  child:  Card(
                                    child: SizedBox(
                                        height:50,
                                        width:100,
                                        child: Image.asset('asset/icons8-apple-48.png')),
                                  ),
                                )

                              ],
                            )
                  ],
                )
                     ),
                    Row(children: [
                      Container(height: 1.0,width: MediaQuery.of(context).size.width/2.3,color: Colors.black,),
                      const Align(child:Text(' OR ',style: TextStyle(fontSize: 10),)),
                      Container(height: 1.0,width: MediaQuery.of(context).size.width/2.3,color: Colors.black,),

                    ],),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
                      child: BlocBuilder<LoginBloc,LoginState>(builder: (context,state){
                        if(state is LoadingLoginState){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Column(crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                                child: TextField(
                                  controller: _usernameController,
                                  decoration: const InputDecoration(labelText: 'Email*',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(35.0)),borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid)),
                                    hintText: 'Phone number, email or username',),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12.0, top: 15, bottom: 0),
                                child: TextField(
                                  controller: _passwordController,
                                  decoration: const InputDecoration(
                                      labelText: 'password*',
                                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(35.0)),borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid)),
                                      hintText: 'Enter secure password'
                                  ),
                                  obscureText: true,
                                ),
                              ),
                              SizedBox(height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 6.0,top: 20.0,right: 6.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        shape: const StadiumBorder(),backgroundColor: Colors.blue),
                                       onPressed: () async {
                                      final username = _usernameController.text;
                                      final password = _passwordController.text;
                                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                         await sharedPreferences.setString('name', username);
                                         if (username == 'krishna@gmail.com' &&
                                          password == '1234567') {
                                        context.read<LoginBloc>().
                                        add(LoginButtonPressedEvent(
                                            username: username, password: password));
                                        context.read<DataBloc>().add(
                                            FetchDataEvent());
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(username)));
                                      } else
                                        print('Enter Valid Email and Password');
                                    },
                                    child: const Text('sign-in',style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                              ),
                              SizedBox(height: 50.0,),
                              Center(
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 25,bottom: 15.0),
                                      child: Text('Forgot your login details? '),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left:1.0,bottom: 15.0),
                                      child: InkWell(
                                          onTap: (){
                                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyCataLog()));
                                          },
                                          child: const Text('Get help logging in.', style: TextStyle(fontSize: 14, color: Colors.blue),)),
                                    )
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 20.0),child: Text("Don't have an account?"),),
                              SizedBox(height:60,
                                width:MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 6.0,top: 10.0,right: 6.0),
                                  child: ElevatedButton(onPressed: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                                  },
                                  child: Text('Register'),style: ElevatedButton.styleFrom(shape: StadiumBorder(),backgroundColor: Colors.blue),),
                                )
                              ),

                            ],
                          );
                        }
                      }
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
Scaffold(

      body: BlocBuilder<LoginBloc,LoginState>(
        builder: (context,state) {
          if(state is LoadingLoginState){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration:const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGAAiVPZTmEciG3PYuVd3MXCYnhLgSbFWy4Q&usqp=CAU'),
                    ),
                    Column(children: [
                      Form(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(labelText: 'Username'),
                            ),
                            // TextField(
                            //   keyboardType: TextInputType.emailAddress,
                            //   decoration: InputDecoration(
                            //     hintText: 'exapmle@example.com',
                            //     labelText: 'E-mail Address',
                            //   ),
                            //   onChanged: (emailGet) {
                            //     //data.user.email = emailGet;
                            //   },
                            // ),
                            // TextField(
                            //   obscureText: true,
                            //   decoration: InputDecoration(
                            //     hintText: '*********',
                            //     labelText: 'Password',
                            //   ),
                            //   onChanged: (passwordGet) {
                            //     //data.user.password = passwordGet;
                            //   },
                            // ),
                            TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(labelText: 'Password'),
                              obscureText: true,
                            ),
                            SizedBox(height: 10),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  final username = _usernameController.text;
                                  final password = _passwordController.text;
                                  if(username == 'krishna@gmail.com' && password=='1234567'){
                                    context.read<LoginBloc>().
                                    add(LoginButtonPressedEvent(username: username, password: password));
                                    context.read<DataBloc>().add(FetchDataEvent());
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyCataLog(username)));

                                  } else print('Enter Valid Email and Password');

                                },
                                child: Text('Submit'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ],
                ));
        }
      ),

    );
 */

/*
// BlocBuilder<LoginBloc, LoginState>(
                            //   builder: (context, state) {
                            //     if (state is LoadingLoginState) {
                            //       return CircularProgressIndicator();
                            //     } else if (state is ErrorLoginState) {
                            //       return Text(state.error);
                            //     } else {
                            //       return SizedBox.shrink();
                            //     }
                            //   },
                            // ),
 */

/*

import 'package:applicatio01statemanagment/providers/providers/provider_page.dart';
import 'package:applicatio01statemanagment/screens/listscreen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class ProviderPage extends StatelessWidget {
  const ProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeProvider(),
    );
  }
}

class HomeProvider extends StatefulWidget {
  HomeProvider({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomeProviderState();
  }
}

class _HomeProviderState extends State<HomeProvider> {
  late DataProvider provider;

  @override
  void initState() {
    provider = Provider.of<DataProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Login Page '),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyCataLog()));
              },
              icon: Icon(Icons.list_alt))
        ],
      ),
      body: Consumer<DataProvider>(
        builder: (context, data, child) {
          return Container(
           height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGAAiVPZTmEciG3PYuVd3MXCYnhLgSbFWy4Q&usqp=CAU'),
                ),
                Column(
                  children: [
                    Form(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'exapmle@example.com',
                              labelText: 'E-mail Address',
                            ),
                            onChanged: (emailGet){
                              data.user.email = emailGet;

                            },
                          ),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: '*********',
                              labelText: 'Password',
                            ),
                            onChanged: (passwordGet){
                              data.user.password = passwordGet;

                            },
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: (){
                                data.fetchData();
                               data.signIn(username: data.user.email, password: data.user.password);
                               Navigator.pushReplacement(context,
                                     MaterialPageRoute(builder: (context) => MyCataLog()));



                                },
                              child: Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),

    );
  }
}


floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
              child: Icon(Icons.play_arrow),
              onPressed: () {
                provider.fetchData();

              })
        ],
      ),
Consumer<DataProvider>(builder: (context, data, child) {
        if (data.status == Status.inital) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.white]),
            ),
            child: Center(
              child: Text('Press The Button'),
            ),
          );
        }
        if (data.status == Status.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (data.status == Status.success) {
          
        }
        return Container();
      }),
 */
