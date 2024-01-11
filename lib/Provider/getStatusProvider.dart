import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_downloader/Constants/constant.dart';

class GetStatusProvider extends ChangeNotifier {
  List<FileSystemEntity> _getImages = [];
  List<FileSystemEntity> _getVideos = [];
  bool _isWhatsappAvailable = false;

  List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;
  bool get isWhatsappAvailable => _isWhatsappAvailable;

  Future<void> getStatus(String ext) async {
    try {
      // Get storage permission
      final status = await Permission.storage.request();

      if (status.isDenied) {
        await Future.delayed(const Duration(seconds: 3));
        final status = await Permission.storage.request();
        if (status.isDenied) {
          log("Permission denied");
          return;
        }
      }

      // Get WhatsApp path dynamically
      final whatsappPath = await AppConstants.getWhatsAppPath();

      // Check if path exists
      final directory = Directory(whatsappPath);
      if (await directory.exists()) {
        // List files with specified extension
        final items = directory.listSync().where((element) => element.path.endsWith(ext)).toList();
        log(items.toString());

        if (ext == ".mp4") {
          _getVideos = items;
        } else {
          _getImages = items;
        }

        _isWhatsappAvailable = true;
      } else {
        log("WhatsApp folder not found");
        _isWhatsappAvailable = false;
      }

      notifyListeners();
    } catch (error) {
      log("Error fetching status: $error");
    }
  }
}
