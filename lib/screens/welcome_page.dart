import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authentication/auth_bloc.dart';
import '../bloc/authentication/auth_event.dart';
import '../bloc/authentication/auth_state.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final usernamecontroller = TextEditingController(text: 'amirahmad');
  final passwordcontroller = TextEditingController(text: '12345678');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 176, 7),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 340,
                    height: 340,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255, 255, 255, 0.1)),
                  ).animate(delay: const Duration(milliseconds: 700)).scale(),
                  Container(
                    width: 282.76,
                    height: 282.76,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255, 255, 255, 0.1)),
                  ).animate(delay: const Duration(milliseconds: 800)).scale(),
                  Container(
                    width: 230.81,
                    height: 230.81,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255, 255, 255, 0.1)),
                  ).animate(delay: const Duration(milliseconds: 900)).scale(),
                  Container(
                    width: 168.27,
                    height: 168.27,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(255, 255, 255, 0.1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 110,
                          width: 110,
                          child: Image.asset(
                            'assets/images/Vector.png',
                          ),
                        ).animate().scale(),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'اپل شاپ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ).animate().scale(),
                      ],
                    ),
                  ).animate(delay: const Duration(seconds: 1)).scale(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/Star Pattern 1.png',
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    height: 350,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      color: const Color(0xffF5DEB3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: usernamecontroller,
                            decoration: const InputDecoration(
                              label: Text(
                                'نام کاربری',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'sb',
                                    fontWeight: FontWeight.bold),
                              ),
                              focusColor: Colors.green,
                              focusedBorder: OutlineInputBorder(
                                gapPadding: 4,
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                gapPadding: 2,
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    15,
                                  ),
                                ),
                              ),
                              hintText: 'نام کاربری',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: passwordcontroller,
                            decoration: const InputDecoration(
                              label: Text(
                                'رمز عبور',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'sb',
                                    fontWeight: FontWeight.bold),
                              ),
                              focusColor: Colors.green,
                              focusedBorder: OutlineInputBorder(
                                gapPadding: 4,
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                gapPadding: 2,
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    15,
                                  ),
                                ),
                              ),
                              hintText: 'رمز عبور ',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthInitiateState) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 244, 111, 54),
                                        minimumSize: const Size(230, 50)),
                                    onPressed: () {
                                      BlocProvider.of<AuthBloc>(context).add(
                                        AuthLoginRequestEvent(
                                            usernamecontroller.text,
                                            passwordcontroller.text),
                                      );
                                    },
                                    child: const Text(
                                      'ورود به حساب کاربری',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'sb',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              }
                              if (state is AuthLoadingState) {
                                return const LinearProgressIndicator();
                              }
                              if (state is AuthResponseState) {
                                Text textwidget = const Text('');
                                state.response.fold(
                                  (l) {
                                    textwidget = Text(l);
                                  },
                                  (r) {
                                    textwidget = Text(r);
                                  },
                                );
                                return textwidget;
                              }
                              return const Text('خظا');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
