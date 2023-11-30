import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:hackuniv/pages/padfview/pdfscreen.dart';

import '../../common/color.dart';
import '../../model/pdfmodel.dart';

class PdfViewPage extends StatefulWidget {
  const PdfViewPage({
    super.key,
  });
  // final String title;
  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Prevous year questions",
          style: TextStyle(color: AppColor.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.black,
            )),
      ),
      body: FutureBuilder(
        future: readJsonData(),
        builder: ((context, snapsot) {
          if (snapsot.hasError) {
            return Text("${snapsot.error}");
          } else if (snapsot.hasData) {
            var pyqList = snapsot.data as List<Pdfdata>;
            // print(pyqList);
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: pyqList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ListTile(
                    hoverColor: Colors.blue[200],
                    focusColor: Colors.red[200],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.white60)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfScreen2(
                            title: pyqList[index].title.toString(),
                            url: pyqList[index].url.toString(),
                          ),
                        ),
                      );
                    },
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    tileColor: AppColor.backgroundColor,
                    title: Text(pyqList[index].title.toString()),
                    leading: const Icon(
                      Icons.book_rounded,
                      color: Colors.blue,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(),
              ),
            );
          }
        }),
      ),
    );
  }

  Future<List<Pdfdata>> readJsonData() async {
    final jsonpyq =
        await services.rootBundle.loadString('asstes/json/pyq.json');
    final selist = json.decode(jsonpyq) as List<dynamic>;
    return selist.map((e) => Pdfdata.jsondata(e)).toList();
  }
}
