import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class DownloadFromUri extends StatefulWidget {
  const DownloadFromUri({super.key});

  @override
  State<DownloadFromUri> createState() => _DownloadFromUriState();
}

class _DownloadFromUriState extends State<DownloadFromUri> {
  final images = <String>[
    "https://images.unsplash.com/photo-1599707367072-cd6ada2bc375?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1333&q=80",
    "https://plus.unsplash.com/premium_photo-1677693662875-1bbbb45d3937?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1332&q=80",
    "https://images.unsplash.com/photo-1614730321146-b6fa6a46bcb4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1074&q=80",
    "https://images.unsplash.com/photo-1516331138075-f3adc1e149cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1208&q=80",
    "https://images.unsplash.com/photo-1691059283093-1e4345a9fa71?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1171&q=80",
    "https://images.unsplash.com/photo-1691257348349-429137fdf76a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80",
    "https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1283&q=80",
    "https://images.unsplash.com/photo-1583121274602-3e2820c69888?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80",
    "https://images.unsplash.com/photo-1494976388531-d1058494cdd8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80",
    "https://plus.unsplash.com/premium_photo-1663047351997-c3ba1fda32b6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80",
    "https://media.comicbook.com/2017/10/iron-man-movie-poster-marvel-cinematic-universe-1038878.jpg",
    "https://marketplace.canva.com/EAFVCFkAg3w/1/0/1131w/canva-red-and-black-horror-movie-poster-AOBSIAmLWOs.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1LY7QbSVNyJEjvzDSmF7nc25hnncMyQu3--vDQKMcKUcTbPvxylCHKB7380LrXo5eHsc",
    "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80",
    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80",
  ];

  late String selected;
  Uint8List? bytes;

  @override
  void initState() {
    selected = images[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Download From Url"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  images.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () => setState(() => selected = images[index]),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade400,
                          image: DecorationImage(
                            image: NetworkImage(
                              images[index],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              width: double.maxFinite,
              child: FadeInImage.assetNetwork(
                placeholder: "assets/images/download.png",
                image: selected,
                fit: BoxFit.fill,
                placeholderFit: BoxFit.fill,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/download.png",
                    fit: BoxFit.fill,
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            ActionChip(
              label: const Text("Download"),
              onPressed: () async {
                // final path = await getExternalStorageDirectory();
                final dir = Directory("/storage/emulated/0/Download");
                debugPrint('dir -> $dir');
                final status = await Permission.storage.request();
                if (status.isDenied || status.isPermanentlyDenied) {
                  await openAppSettings();
                }

                debugPrint('status => $status');

                debugPrint(status.isGranted.toString());
                if (status.isGranted) {
                  if (!await dir.exists()) {
                    await dir.create(recursive: true);
                  }

                  final Response response = await Dio().get(
                    selected,
                    options: Options(
                      responseType: ResponseType.bytes,
                    ),
                  );

                  if (response.data != null) {
                    final fileName = DateTime.now().millisecondsSinceEpoch;
                    final file = File('${dir.path}/${fileName}image.jpeg');
                    debugPrint("file => $file");
                    await file.writeAsBytes(response.data);
                  }
                }
              },
            ),
            const SizedBox(height: 10),
            ActionChip(
              label: const Text("Gallery Download"),
              onPressed: () async {
                final dir = await getTemporaryDirectory();
                final bytes = await Dio().get(
                  selected,
                  options: Options(
                    responseType: ResponseType.bytes,
                  ),
                );

                await ImageGallerySaver.saveImage(
                  Uint8List.fromList(bytes.data),
                );
              },
            ),
            const SizedBox(height: 10),
            ActionChip(
              label: const Text("Share"),
              onPressed: () async {
                final dir = await getTemporaryDirectory();
                final Response response = await Dio().get(
                  selected,
                  options: Options(
                    responseType: ResponseType.bytes,
                  ),
                );
                final file = File("${dir.path}/Image.png"); // import 'dart:io';
                 file.writeAsBytesSync(Uint8List.fromList(response.data));
                 debugPrint('==> ${file.path}');

                // Share
                await Share.shareXFiles(
                  [XFile(file.path)],
                );
              },
            ),

            const SizedBox(height: 10),
            ActionChip(
              label: const Text("Share file from assert"),
              onPressed: () async {
                final dir = await getTemporaryDirectory();
                final byte = (await rootBundle.load("assets/images/download.png")).buffer.asUint8List(); // convert in to Uint8List
                debugPrint('byte $byte');
                final file = File("${dir.path}/Image.png") ; // import 'dart:io'
                await file.writeAsBytes(byte);
                // Share
                await Share.shareXFiles(
                  [XFile(file.path)],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// https://stackoverflow.com/questions/76003249/platformexception-platformexceptionshare-callback-error-prior-share-sheet-did