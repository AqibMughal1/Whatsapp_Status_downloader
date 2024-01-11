import 'package:path_provider/path_provider.dart';
import 'dart:io';


class AppConstants {
  static Future<String> getWhatsAppPath() async {
    final directory = await getExternalStorageDirectory();

    if (Platform.isAndroid) {
      return directory!.path + '/Android/media/com.whatsapp/WhatsApp/Media/.Statuses';
    } else if (Platform.isIOS) {
      // TODO: Implement iOS-specific path logic
      return '/path/to/iOS/WhatsApp/Statuses'; // Replace with actual iOS path
    } else {
      throw UnsupportedError('Platform not supported');
    }
  }
}
