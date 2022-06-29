import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:starter/app/theme/app_colors.dart';

class NewsTile extends StatelessWidget {
  const NewsTile(
      {Key? key,
      required this.title,
      required this.urlToImage,
      required this.newsSource})
      : super(key: key);

  final String title;
  final String urlToImage;
  final String newsSource;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150.h,
        padding: EdgeInsets.only(left: 8.w, right: 8.w),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 210.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsSource,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: title.length < 80
                          ? Text(
                              title,
                              style: TextStyle(fontSize: 14.sp),
                            )
                          : Text(
                              "${title.substring(0, 80)}...",
                              style: TextStyle(fontSize: 14.sp),
                            )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 140.h,
              width: 100.w,
              child: CachedNetworkImage(
                imageUrl: urlToImage,
            
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
                errorWidget: (context, url, error){

                  return Container();
                },
              ),
            ),
          )
        ]));
  }
}
