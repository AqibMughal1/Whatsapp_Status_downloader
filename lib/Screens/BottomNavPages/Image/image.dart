import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_downloader/Provider/getStatusProvider.dart';
import 'package:whatsapp_downloader/Screens/BottomNavPages/Image/image_view.dart';

class ImageHomePage extends StatefulWidget {
  const ImageHomePage({super.key});

  @override
  State<ImageHomePage> createState() => _ImageHomePageState();
}

class _ImageHomePageState extends State<ImageHomePage> {
  bool _isFetched = false;

  @override
  void initState() {
    super.initState();
    _fetchData(); // Call getStatus on initial load
  }

  Future<void> _fetchData() async {
    await Provider.of<GetStatusProvider>(context, listen: false).getStatus("jpg");
    setState(() => _isFetched = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _isFetched ? null : _fetchData(), // Fetch only if not already done
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading indicator
          }

          final file = Provider.of<GetStatusProvider>(context);

          return file.isWhatsappAvailable == false
              ? Center(child: Text("WhatsApp not Available"))
              : file.getImages.isEmpty
              ? Center(child: Text("Images not Available"))
              : Container(
            padding: const EdgeInsets.all(18),
            child: GridView.builder(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: file.getImages.length,
              itemBuilder: (context, index) {
                final data = file.getImages[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (_) => ImageView(
                              imagePath: data.path,
                            )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(data.path))),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
