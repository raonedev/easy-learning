import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/color.dart';
import '../Homepage/home.dart';

class OnboadringScreen extends StatefulWidget {
  const OnboadringScreen({super.key});

  @override
  State<OnboadringScreen> createState() => _OnboadringScreenState();
}

class _OnboadringScreenState extends State<OnboadringScreen> {
  late PageController _pageController;
  bool check = false;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Expanded(
              flex: 4,
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      check = (value == 2);
                    });
                  },
                  physics: const BouncingScrollPhysics(),
                  itemCount: abc.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // margin: const EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(
                          children: [
                            const Spacer(),
                            CachedNetworkImage(
                              fit: BoxFit.contain,
                              errorWidget: (context, url, error) =>
                                  const Center(
                                      child: Icon(
                                Icons.error_rounded,
                                color: Colors.red,
                              )),
                              placeholder: (context, url) {
                                return Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      color: Colors.grey[300],
                                      width: double.maxFinite,
                                      height: 300,
                                    ));
                              },
                              imageUrl: abc[index].img.toString(),
                            ),
                            // const Spacer(),
                            const SizedBox(height: 10),
                            Text(
                              abc[index].title,
                              style: const TextStyle(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            const Spacer(),
            check
                ? GestureDetector(
                    onTap: () async {
                      final pref = await SharedPreferences.getInstance();
                      await pref.setBool('ON_BORDING', false);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    },
                    child: AnimatedContainer(
                      duration: const Duration(microseconds: 300),
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: 200,
                      // height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColor.black,
                      ),
                      child: const Center(
                        child: Text(
                          "START",
                          style: TextStyle(
                              color: AppColor.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.ease);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.black,
                      ),
                      child: const Center(
                        child: Text(
                          "NEXT",
                          style: TextStyle(
                              color: AppColor.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class Data {
  String title;
  String img;
  String? subtitle;
  Data({required this.title, required this.img, this.subtitle});
}

List<Data> abc = [
  Data(
      title: "Welcome to Gjust IT 3",
      img:
          'https://img.freepik.com/free-vector/live-collaboration-concept-illustration_114360-593.jpg?w=740&t=st=1680876700~exp=1680877300~hmac=4bdf31000aeab4c1968d0291b3e477c9a098c663dc11c7e5a2dee2eb584c569c'),
  Data(
      title: "Watch Videos without distraction",
      img:
          'https://img.freepik.com/free-vector/man-having-online-job-interview_52683-43379.jpg?w=740&t=st=1680876730~exp=1680877330~hmac=18d61c3003a2db17270529da29bc5f2c767302911830e0654f7b6514c462fb65'),
  Data(
      title: "prepare your exam with pyq",
      img:
          'https://img.freepik.com/free-vector/internship-job-illustration_23-2148722413.jpg?w=740&t=st=1680876754~exp=1680877354~hmac=cd5435f82c07b8159d3d15561081fd3886cb3b31352d51ebb7dd2c9d810abe4e')
];
