import 'package:flutter/material.dart';
import 'const.dart';
import 'total.dart';

class TonBudget extends StatefulWidget {
  const TonBudget({Key? key}) : super(key: key);

  @override
  State<TonBudget> createState() => TonBudgetState();
}

class TonBudgetState extends State<TonBudget> {
  TextEditingController priceController = TextEditingController();
  double budget = 0.0; // Variable to store the budget
  bool isBudgetSaved =
  false; // Variable to track if the budget has been saved Variable to store the budget

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/2.png'),
                opacity: 0.3,
                alignment: Alignment.center),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.7, 1],
              colors: [Colors.white, Color(0xFFbfe6f8), Color(0xFF40BFED)],
            ),
          ),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Text(
                  'Ton Budget',
                  style: textstyle,
                ),
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'ENTRER TON BUDGET',
                  style: textstyle.copyWith(
                      color: Color(0xff40beec), fontSize: 30),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Positioned(
                  left: 5.5,
                  top: 277,
                  child: Align(
                    child: SizedBox(
                      width: 379,
                      height: 174,
                      child: Text(
                        'Ainsi, lorsque vous manquez votre budget, vous verrez un message',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          height: 1.445,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      child: IntrinsicWidth(
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 25
                          ),
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,fontSize: 25
                            ),
                            hintText: 'Ton Budget',
                            suffix: budget != 0.0
                                ? Text(
                              '/DA  ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 25
                              ),
                            )
                                : null,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            filled: true,
                            fillColor: Color(0xff40beec),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              budget = double.tryParse(value) ?? 0.0;
                            });
                            TotalState? totalState = context.findAncestorStateOfType<TotalState>();
                            if (totalState != null) {
                              // Use the non-null value of totalState here
                            }
                          },

                        ),
                      )
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: Container(
                        height: 60,
                        width: 160,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(50))),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            primary: Colors.white,
                            onPrimary: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return Total(budget: double.infinity,);
                                }));
                          },
                          child: const Center(
                            child: Text(
                              'SAUTER',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Container(
                        height: 60,
                        width: 160,
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
                            setState(() {
                              budget = double.parse(priceController.text);
                              isBudgetSaved = true;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Total(budget: budget,),
                              ),
                            );
                          },

                          child: const Center(
                            child: Text(
                              'CONFIRMER',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
