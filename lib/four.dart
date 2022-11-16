import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/name.dart';
import 'package:share_plus/share_plus.dart';

class forth extends StatefulWidget {
  int index;
  List<String> l;

  forth(this.index, this.l);

  @override
  State<forth> createState() => _forthState();
}

class _forthState extends State<forth> {
  bool single = true;

  List colo = [
    Colors.blueAccent,
    Colors.pinkAccent,
    Colors.purple,
    Colors.greenAccent,
    Colors.deepPurple,
    Colors.redAccent,
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.brown,
    Colors.green,
    Colors.amberAccent,
    Colors.black,
    Colors.greenAccent
  ];

  List<Color> gr = [];

  List<String> emoj = [
    "😊 😇 🙂 🙃 😉 😌 😍",
    "✌️🤞 🤟 🤘 🤙 👌 ",
    "😃 😄 😁 😆 😅 😂 🤣",
    "👫 👩‍❤ 💋‍👨 👥 🫂",
    "😍 🥰 😘 😗 😙 😚",
    "🤨 🧐 🤓 😎 🥸 🤩",
    "👍 👎 ✊ 👊 🤛 🤜",
    "😉 😌 😍 🥰 😘 😗",
  ];

  List fontlist = ["ff1", "ff2", "ff3", "ff4", "ff5", "ff6"];
  String fonttype = "ff1";

  String em = "😊 😇 🙂 🙃 😉 😌 😍";
  Color back = Colors.pink;
  Color bg = Colors.brown;
  double size = 30;
  int count = 0;
  String folderpath = "";

  @override
  void initState() {
    super.initState();

    creatfolder();
  }

  creatfolder() async {
    // Directory direct = Directory((Platform.isAndroid
    //             ? await getExternalStorageDirectory() //FOR ANDROID
    //             : await getApplicationSupportDirectory() //FOR IOS
    //         )!
    //         .path +
    //     '/shayari app');

    var path = await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOADS) +
        '/shayari app';

    Directory dir = Directory(path);

    if (await dir.exists()) {
      print("already created");
    } else {
      await dir.create();
      print("creat");
      print(dir.path);
    }
    folderpath = dir.path;
  }

  GlobalKey _globalKey = new GlobalKey();

  Future<Uint8List> _capturePng() async {
    var pngBytes;
    try {
      print('inside');
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      pngBytes = byteData!.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      //  setState(() {});
      return pngBytes;
    } catch (e) {
      print(e);
    }
    return pngBytes;
  }

  @override
  Widget build(BuildContext context) {
    gr = model.grad[count];
    return Scaffold(
      appBar: AppBar(
        title: Text("Love shayari"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: RepaintBoundary(
              key: _globalKey,
              child: Container(
                decoration: single
                    ? BoxDecoration(color: back)
                    : BoxDecoration(gradient: LinearGradient(colors: gr)),
                width: double.infinity,
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(
                  "${em}\n${widget.l[widget.index]}\n${em}",
                  style: TextStyle(
                      fontSize: size, color: bg, fontFamily: fonttype),
                ),
              ),
            ),
          )),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (count <= gr.length) {
                            gr = model.grad[count];
                          } else {
                            count = 0;
                          }
                          count++;
                        });
                      },
                      icon: Icon(Icons.refresh_rounded)),
                ),
              ),
              Expanded(
                  child: Container(
                color: Colors.white,
                child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          builder: (context) {
                            return Container(
                              height: 650,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: GridView.builder(
                                  itemCount: model.grad.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight,
                                              colors: model.grad[index]),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          single = false;
                                          count = index;
                                          gr = model.grad[index];
                                        });
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10)),
                            );
                          },
                          context: context);
                    },
                    icon: Icon(Icons.zoom_out_map)),
              ))
            ],
          ),
          Container(
            color: Colors.black,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          builder: (context) {
                            return Container(
                              height: 150,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: GridView.builder(
                                          itemCount: colo.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              child: Container(
                                                color: colo[index],
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  single = true;
                                                  back = colo[index];
                                                });
                                              },
                                            );
                                          },
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 6,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                          ))),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.close))
                                ],
                              ),
                            );
                          },
                          context: context);
                    },
                    child: Text("background")),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                          builder: (context) {
                            return AlertDialog(
                              content: ColorPicker(
                                  onColorChanged: (value) {
                                    setState(() {
                                      bg = value;
                                    });
                                  },
                                  pickerColor: bg),
                            );
                          },
                          context: context);
                    },
                    child: Text("text color")),
                ElevatedButton(
                    onPressed: () {
                      DateTime dt = DateTime.now();
                      String imgname =
                            "${dt.day.toString()}${dt.month.toString()}${dt.year.toString()}${dt.hour.toString()}${dt.minute.toString()}${dt.second.toString()}${dt.millisecond.toString()}";
                      print(dt.hour.toString() +
                          ":" +
                          dt.minute.toString() +
                          ":" +
                          dt.second.toString() +
                          ":" +
                          dt.millisecond.toString() +
                          ":" +
                          dt.day.toString() +
                          ":" +
                          dt.month.toString() +
                          ":" +
                          dt.year.toString());

                        String imgpath = "${folderpath}/IMAGE_${imgname}.jpg";

                      File file = File(imgpath);

                      file.create().then((value) {
                        print(value.path);

                        _capturePng().then((value) {
                          file.writeAsBytes(value).then((value) {
                            print("write file");
                            Share.shareFiles(['${value.path}'],
                                text: 'Super picture');
                          });
                        });
                      });
                    },
                    child: Text("share")),
              ],
            ),
          ),
          Container(
            color: Colors.black,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          builder: (context) {
                            return Container(
                              height: 150,
                              child: ListView.builder(
                                itemCount: fontlist.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    child: Container(
                                      height: 30,
                                      child: Center(
                                          child: Text(
                                        "hello",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontFamily: fontlist[index]),
                                      )),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        fonttype = fontlist[index];
                                      });
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),
                            );
                          },
                          context: context);
                    },
                    child: Text("Font")),
                ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          builder: (context) {
                            return Container(
                              height: 150,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: ListView.builder(
                                    itemCount: emoj.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        child: Container(
                                          height: 30,
                                          child:
                                              Center(child: Text(emoj[index])),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            em = emoj[index];
                                          });
                                        },
                                      );
                                    },
                                  )),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.close))
                                ],
                              ),
                            );
                          },
                          context: context);
                    },
                    child: Text("Emoji")),
                ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          builder: (context) {
                            return Container(
                              height: 150,
                              color: Colors.black12,
                              child: StatefulBuilder(
                                builder: (context, setState1) {
                                  return Slider(
                                      min: 10,
                                      max: 50,
                                      onChanged: (value) {
                                        print(value);

                                        size = value;
                                        setState1(() {});
                                        setState(() {});
                                      },
                                      value: size);
                                },
                              ),
                            );
                          },
                          context: context);
                    },
                    child: Text("Text size"))
              ],
            ),
          ),
        ],
      )),
    );
  }
}
