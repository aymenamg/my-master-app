import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class socialmedia extends StatefulWidget {
  const socialmedia({super.key, required this.url , required this.icon,required this.mediatext,required this.Textstyle});
  final String url ;
  final FaIcon icon;
  final String mediatext;
  final TextStyle Textstyle;

  @override
  State<socialmedia> createState() => _socialmediaState();
}

class _socialmediaState extends State<socialmedia> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0,left: 70,bottom: 15),
      child: Row(
        children:  [
          widget.icon,
          const SizedBox(width: 20,),
          InkWell(
            child: Text(widget.mediatext,style: widget.Textstyle,),
            onTap: ()=>launch(widget.url),
          )
        ],
      ),
    );
  }
}