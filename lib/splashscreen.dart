import 'package:flutter/material.dart';
import 'package:master_project/TonBudget.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({
    Key? key,
  }) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

// ignore: camel_case_types
class _splashscreenState extends State<splashscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.55, 0.9],
            colors: [
              Colors.blue,
              Colors.white70,
              Colors.white70,
              Colors.blue,
            ],
          )),
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Bienvenue',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 50.0),
                  ),
                ),
                const Expanded(
                  child: Image(
                    image: AssetImage('images/1.png'),
                  ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60, bottom: 60),
                      child: Container(
                          height: 60,
                          width: 200,
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                primary: Colors.black,
                                onPrimary: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return const TonBudget();
                                }
                                ),);
                              },
                              child: const Center(
                                  child: Text(
                                'commence',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              )))),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
