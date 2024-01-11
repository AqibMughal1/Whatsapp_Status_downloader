import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_downloader/Provider/getStatusProvider.dart';
import 'package:whatsapp_downloader/Screens/BottomNavPages/Video/video_view.dart';
import 'package:whatsapp_downloader/Utils/getThumbnails.dart';

class VideoHomePage extends StatefulWidget {
  const VideoHomePage({super.key});

  @override
  State<VideoHomePage> createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> {



  @override
  Widget build(BuildContext context) {

    bool _isFetched = false;

    return Scaffold(
        body: Consumer<GetStatusProvider>(
            builder: (context, file, child) {
              if(_isFetched == false){
                file.getStatus("mp4");
                Future.delayed(Duration(microseconds: 2),(){
                  _isFetched = true;
                });

              }
              return file.isWhatsappAvailable == false ? Center(
                child:Text("Whatsapp not Available"),
              )
                  : file.getVideos.isEmpty? Center(
                child:Text("Videos not Available"),
              ) : Container(
                padding: EdgeInsets.all(18),
                child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10, mainAxisSpacing: 10),
                  children: List.generate(file.getVideos.length, (index){

                    final data = file.getVideos[index];
                    return FutureBuilder<String>(
                      future: getThumbnail(data.path),
                      builder: (context, snapshot) {
                        return snapshot.hasData? GestureDetector(
                          onTap: (){
                            Navigator.push(context, CupertinoPageRoute(builder: (_)=> VideoView(
                              videoPath: data.path,
                            )),);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                image: DecorationImage(image: FileImage(File(snapshot.data!))),
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        ):Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    );
                  } ,),
                ),
              );
            }
        )
    );
  }
}
