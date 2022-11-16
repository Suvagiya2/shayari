import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/first.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {

  super.initState();
    next();
  }

  next() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await [Permission.storage].request();
    }

    await Future.delayed(Duration(seconds: 2));

    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return first();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body:Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("photo/2.jpg"), fit: BoxFit.cover)
                  ),
                ),
            ),
          ),
          Container(
              child: Center(child: Text("from",style: TextStyle(color: Colors.black45,fontSize: 13,fontWeight: FontWeight.bold)))),
          Container(
              child: Center(child: Text("Rahul Suvagiya",style: TextStyle(color: Colors.white70,fontSize: 20)))
          )
        ],
      ),

    );
  }
}
