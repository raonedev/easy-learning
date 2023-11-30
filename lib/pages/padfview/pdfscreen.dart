import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../common/color.dart';

class PdfScreen2 extends StatefulWidget {
  const PdfScreen2({super.key, this.title, this.url});
  final String? title;
  final String? url;
  @override
  State<PdfScreen2> createState() => _PdfScreen2State();
}

class _PdfScreen2State extends State<PdfScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.black,
          elevation: 0,
          centerTitle: true,
          title: SizedBox(
            // width: 200,
            child: Text(
              widget.title.toString(),
              style: const TextStyle(color: AppColor.white),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.white,
            ),
          ),
        ),
        body: SfPdfViewer.network(
          widget.url.toString(),
        ));
  }
}
