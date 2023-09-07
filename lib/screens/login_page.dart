import 'package:applicatio01statemanagment/bloc/data_bloc.dart';
import 'package:applicatio01statemanagment/bloc/data_event.dart';
import 'package:applicatio01statemanagment/screens/mycatacalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/data_state.dart';
import '../bloc/loginEvent.dart';
import '../bloc/loginbloc.dart';
import '../bloc/loginstate.dart';

class BlocPage extends StatelessWidget {
  const BlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
    );
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
  void initState() {
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
                                            builder: (context) => MyCataLog()));

                                  } else print('Enter Valid Email and Password');

                                },
                                // onPressed: () {
                                //   bloc.add(FetchDataEvent());
                                //   Navigator.pushReplacement(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) => MyCataLog()));
                                // },
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
  }
}

/*

import 'package:applicatio01statemanagment/providers/providers/provider_page.dart';
import 'package:applicatio01statemanagment/screens/mycatacalog.dart';
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
