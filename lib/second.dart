import 'package:flutter/material.dart';
import 'package:project/name.dart';
import 'package:project/third.dart';

class second extends StatefulWidget {
 int index;
 String category;
 String image;
  second(this.index,this.category,this.image);
  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {

  List<String> l=[];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Love shayari", style: TextStyle(fontSize: 30,color: Colors.pink),),
      ),
      body: ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
        return Center(child: Card(
          elevation: 25,
          shadowColor: Colors.amberAccent,
          child: ListTile(
            leading: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(model.image[widget.index]),
                    fit: BoxFit.cover),
              ),
            ),
            title: Text(
              l[index],
              style: TextStyle(fontSize: 25,
              color: Colors.blue),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(Icons.chevron_right,
            size: 20,
            color: Colors.black,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return three(index, l);
              },));
            },
          ),),);
      },),
    );
  }

  @override
  void initState() {
    super.initState();

    if(widget.index==0){
      l=model.congratulation;
    }
    else if(widget.index==1){
      l=model.friends;
    }
    else if(widget.index==2){
      l=model.comedy;
    }
    else if(widget.index==3){
      l=model.god;
    }
    else if(widget.index==4){
      l=model.life;
    }
    else if(widget.index==5){
      l=model.love;
    }
  }
}
