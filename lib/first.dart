import 'package:flutter/material.dart';
import 'package:project/name.dart';
import 'package:project/second.dart';

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {

  List<String> i=model.image;
  List<String> c=model.category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Love shayari", style: TextStyle(fontSize: 25,color: Colors.pink),),
      ),
      body: ListView.builder(itemCount:c.length,itemBuilder: (context, index) {
        return Card(
          elevation: 25,
          shadowColor: Colors.amberAccent,
          child: ListTile(
          leading: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage(i[index]),
                  fit: BoxFit.cover),
            ),
          ),
           title: Text(model.category[index], style: TextStyle(fontSize: 25,color: Colors.blue),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return second(index,i[index],c[index]);
              },));
            },
        ),);
      },),
    );
  }
}
