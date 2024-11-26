import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileDownloader extends StatefulWidget {
  @override
  _FileDownloaderState createState() => _FileDownloaderState();
}

class _FileDownloaderState extends State<FileDownloader> {
  bool _isDownloading = false;
  String _downloadStatus = "";

  Future<String> getDownloadsDirectory() async {
    // Get the public Downloads folder path (Android only)
    Directory? downloadsDir = Directory('/storage/emulated/0/Download');
    if (downloadsDir.existsSync()) {
      return downloadsDir.path;
    } else {
      throw Exception("Unable to access Downloads folder");
    }
  }

  Future<void> downloadPdfFile(String url, String filename) async {
    setState(() {
      _isDownloading = true;
      _downloadStatus = "Downloading...";
    });

    // Request storage permissions
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      setState(() {
        _isDownloading = false;
        _downloadStatus = "Storage permission denied!";
      });
      return;
    }

    try {
      // Make the GET request
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Get the Downloads directory
        final downloadsPath = await getDownloadsDirectory();

        // Create a file in the Downloads folder
        final filePath = "$downloadsPath/$filename";
        final file = File(filePath);

        // Write the file content
        await file.writeAsBytes(response.bodyBytes);

        setState(() {
          _isDownloading = false;
          _downloadStatus = "Download complete! File saved at $filePath";
        });
      } else {
        setState(() {
          _isDownloading = false;
          _downloadStatus = "Failed to download file: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _isDownloading = false;
        _downloadStatus = "An error occurred: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("File Downloader")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isDownloading
                  ? null
                  : () {
                downloadPdfFile(
                  "http://192.168.8.46:8081/api/admin/download-pdf",
                  "example.pdf",
                );
              },
              child: Text("Download PDF"),
            ),
            SizedBox(height: 20),
            Text(_downloadStatus),
          ],
        ),
      ),
    );
  }
}
