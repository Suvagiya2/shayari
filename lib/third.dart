import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/four.dart';
import 'package:share_plus/share_plus.dart';

class three extends StatefulWidget {
  int index;
  List<String> l;

  three(this.index, this.l);

  @override
  State<three> createState() => _threeState();
}

class _threeState extends State<three> {
  @override
  PageController page = PageController();

  @override
  void initState() {
    super.initState();
    page = PageController(initialPage: widget.index);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Love shayari",
            style: TextStyle(fontSize: 25, color: Colors.purpleAccent),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Center(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(4),
                      color: Colors.white,
                      child: IconButton(onPressed: () {

                      }, icon: Icon(Icons.zoom_out_map)),
                    ),
                    Container(
                      child: Text("${widget.index + 1}/${widget.l.length}"),
                    ),
                    Container(
                      margin: EdgeInsets.all(4),
                      color: Colors.white,
                      child: IconButton(onPressed: () {

                      }, icon: Icon(Icons.refresh)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: widget.l.length,
                  controller: page,
                  onPageChanged: (value) {
                    print(value);
                    setState(() {
                      widget.index = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.all(45),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.brown, width: 4),
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.redAccent,
                              Colors.green,
                              Colors.blueAccent
                            ]),
                      ),
                      child: Text(
                        "${widget.l[widget.index]}",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        color: Colors.white,
                        child: IconButton(
                          onPressed: () {
                            String shayari=widget.l[widget.index];
                            FlutterClipboard.copy(shayari).then((value) =>
                                Fluttertoast.showToast(
                                    msg: "Copied succesfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    fontSize: 16,
                                ),
                            );
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.copy,
                            size: 20,
                            color: Colors.black87,
                          ),
                        )),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.all(4),
                        color: Colors.white,
                        child: IconButton(
                          onPressed: () {
                            if (widget.index != 0) {
                              widget.index--;

                              setState(() {});
                            } else {
                              widget.index = widget.l.length - 1;
                              setState(() {});
                            }
                            page.jumpToPage(widget.index);
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_left,
                            size: 20,
                            color: Colors.black87,
                          ),
                        )),
                  ),
                  Expanded(
                    child: Container(
                        color: Colors.white,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return forth(widget.index, widget.l);
                            },));
                          },
                          icon: Icon(
                            Icons.edit_off_sharp,
                            size: 20,
                            color: Colors.black87,
                          ),
                        )),
                  ),
                  Expanded(
                    child: Container(
                        color: Colors.white,
                        child: IconButton(
                          onPressed: () {
                            if (widget.index < widget.l.length - 1) {
                              widget.index++;

                              setState(() {});
                            } else {
                              widget.index = 0;
                              setState(() {});
                            }
                            page.jumpToPage(widget.index);
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                            size: 20,
                            color: Colors.black87,
                          ),
                        )),
                  ),
                  Expanded(
                    child: Container(
                        color: Colors.white,
                        child: IconButton(
                          onPressed: () {
                            Share.share(
                                "${widget.l[widget.index]}");

                            setState(() {});
                          },
                          icon: Icon(
                            Icons.share,
                            size: 20,
                            color: Colors.black87,
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
