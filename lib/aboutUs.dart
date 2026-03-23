import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'socialmedia.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title:const Text(
          'Social Media',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        leading:const  BackButton(
        ),
        actions: const [
          Icon(
            Icons.account_box_outlined,
            size: 50,
          )
        ],
      ),
          body:Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('images/3.png'),opacity: 0.10),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.7, 1],
                colors: [Colors.white, Color(0xFFbfe6f8), Color(0xFF40BFED)],
              ),
            ),
            child: Column(
              children: [
                Column(
                  children:  const [
                    Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Text('NOM DU MAGAZINE',style: TextStyle(fontSize: 30,color: Color(0xFF40BFED),fontWeight: FontWeight.w900),),
                    ),
                    socialmedia(
                    url: 'http://cs.univ-batna2.dz/',
                      mediatext: 'Instagram',Textstyle: TextStyle(fontSize: 30,decoration: TextDecoration.underline,color: Color(0xFFC52F9D)),
                      icon: FaIcon(FontAwesomeIcons.instagram,color: Color(0xFFC52F9D),size: 60,),
                    ),
                    socialmedia(
                      url: 'https://www.facebook.com/chefdepartementinformatiquebatna',
                      mediatext: 'Facebook',Textstyle: TextStyle(fontSize: 30,decoration: TextDecoration.underline,color: Colors.blueAccent),
                      icon: FaIcon(FontAwesomeIcons.facebook,color: Colors.blueAccent,size: 60,),
                    ),
                    socialmedia(
                      url: 'https://www.facebook.com/chefdepartementinformatiquebatna',
                      mediatext: 'WhatsApp',Textstyle: TextStyle(fontSize: 30,decoration: TextDecoration.underline,color: Color(0xFF5AF776)),
                      icon: FaIcon(FontAwesomeIcons.whatsapp,color: Color(0xFF5AF776),size: 60,),
                    ),
                    socialmedia(
                      url: 'https://www.google.com/maps/place/Universit%C3%A9+Batna+2/@35.6357032,6.2753977,16.06z/data=!4m6!3m5!1s0x12f405b231da617f:0xa15ecaf6b3bfa065!8m2!3d35.6346757!4d6.2774298!16s%2Fg%2F11cl_pj2dc',
                      mediatext: 'Maps',Textstyle: TextStyle(fontSize: 30,decoration: TextDecoration.underline,color:Color(0xFF34A853)),
                      icon: FaIcon(Icons.location_on,color: Color(0xFF34A853),size: 65,),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'images/5.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    ));
  }
}
