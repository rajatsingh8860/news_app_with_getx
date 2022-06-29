import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:starter/app/data/values/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../theme/app_colors.dart';

class DetailView extends StatefulWidget {
  const DetailView(
      {Key? key,
    })
      : super(key: key);


  @override
  State<DetailView> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailView> {
  bool connected = true;
  var args = Get.arguments;

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  checkConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      setState(() {
        connected = true;
      });
    } else {
      setState(() {
        connected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0C54BE),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: !connected
          ? Center(
              child: ElevatedButton(
                  onPressed: () async {
                    await checkConnection();
                  },
                  child: const Text(ErrorMessages.tryAgain)),
            )
          : SizedBox(
              height: size.height,
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 250.h,
                      width: size.width,
                      child: CachedNetworkImage(
                        imageUrl: args["imageUrl"],
                        fit: BoxFit.cover,
                        placeholder: (ctx, url) => Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.shimmerHighlightColor,
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: AppColors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) {
                          return Container();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        args["newsSource"],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Text(args["content"]),
                    ),
                    InkWell(
                      onTap: () async {
                        await checkConnection();
                        if (connected) {
                          await launchUrl(Uri.parse(args["author"]));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 15.0, right: 15),
                        child: Row(
                          children: const [
                            Text(
                              Strings.seeFullStory,
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff0C54BE),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                color: Color(0xff0C54BE), size: 12)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
