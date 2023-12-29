import 'package:assignment_techila/bloc/data_bloc.dart';
import 'package:assignment_techila/bloc/data_event.dart';
import 'package:assignment_techila/screens/listscreen.dart';
import 'package:assignment_techila/screens/registerscreen.dart';
import 'package:assignment_techila/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';
import 'homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1.0)),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 55, horizontal: 23),
                      child: Column(
                        children: [
                          const Text('Log in with one of the following'),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                      height: 50,
                                      width: 100,
                                      child: Image.asset(
                                          'asset/icons8-gmail-48.png')),
                                ),
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SplashScreen()));
                                },
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(left: 70.0)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                },
                                child: SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Image.asset(
                                        'asset/icons8-apple-48.png')),
                              )
                            ],
                          )
                        ],
                      )),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 22),
                        height: 1.0,
                        width: MediaQuery.of(context).size.width / 2.3,
                        color: Colors.black,
                      ),
                      const Align(
                          child: Text(
                        ' OR ',
                        style: TextStyle(fontSize: 15),
                      )),
                      Container(
                        height: 1.0,
                        width: MediaQuery.of(context).size.width / 2.2,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 30),
                    child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                      if (state is LoadingLoginState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0),
                              child: TextField(
                                controller: _usernameController,
                                decoration: const InputDecoration(
                                  labelText: 'Email*',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(35.0)),
                                      borderSide: BorderSide(
                                          color: Colors.black,
                                          style: BorderStyle.solid)),
                                  hintText: 'Phone number, email or username',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0,
                                  right: 12.0,
                                  top: 15,
                                  bottom: 0),
                              child: TextField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                    labelText: 'password*',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(35.0)),
                                        borderSide: BorderSide(
                                            color: Colors.black,
                                            style: BorderStyle.solid)),
                                    hintText: 'Enter secure password'),
                                obscureText: true,
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 6.0, top: 20.0, right: 6.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: const StadiumBorder(),
                                      backgroundColor: Colors.blue),
                                  onPressed: () async {
                                    final username = _usernameController.text;
                                    final password = _passwordController.text;
                                    SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    await sharedPreferences.setString(
                                        'name', username);
                                    if (username == 'krishna@gmail.com' &&
                                        password == '1234567') {
                                      if (!mounted) return;
                                      context.read<LoginBloc>().add(
                                          LoginButtonPressedEvent(
                                              username: username,
                                              password: password));
                                      context
                                          .read<DataBloc>()
                                          .add(FetchDataEvent());
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(username)));
                                    } else {
                                      debugPrint(
                                          'Enter Valid Email and Password');
                                    }
                                  },
                                  child: const Text(
                                    'sign-in',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            Center(
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 25, bottom: 15.0),
                                    child:
                                        Text('Forgot your login details? '),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 1.0, bottom: 15.0),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MyCataLog()));
                                        },
                                        child: const Text(
                                          'Get help logging in.',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.blue),
                                        )),
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Text("Don't have an account?"),
                            ),
                            SizedBox(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0, top: 10.0, right: 6.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterScreen()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        backgroundColor: Colors.blue),
                                    child: const Text('Register'),
                                  ),
                                )),
                          ],
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
