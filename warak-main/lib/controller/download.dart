// import 'dart:io';

// import 'package:dio/dio.dart';

// import '../main.dart';

// class Downloader {
//   static Future download(String url, String savePath) async {
 
//     Dio dio = Dio();
//     try {
//       Response response = await dio.get(
//         url,

//         //Received data with List<int>
//         options: Options(
//             responseType: ResponseType.bytes,
//             followRedirects: false,
//             validateStatus: (status) {
//               return status! < 500;
//             }),
//       );
//       print(response.headers);
//       File file = File(savePath);
//       var raf = file.openSync(mode: FileMode.write);
//       // response.data is List<int> type
//       raf.writeFromSync(response.data);
//       await raf.close();
//     } catch (e) {
//       print(e);
//     }
//   }
// }
