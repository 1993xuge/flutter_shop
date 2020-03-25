import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttershop/config/index.dart';

class CachedImageWidget extends StatelessWidget {
  double width;
  double height;

  String url;

  CachedImageWidget(this.width, this.height, this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        width: width,
        height: height,
        placeholder: (BuildContext context, String url) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[350],
            alignment: Alignment.center,
            child: Text(
              KString.LOADING,
              style: TextStyle(
                  fontSize: ScreenUtil.instance.setSp(26), color: Colors.white),
            ),
          );
        },

      ),
    );
  }
}
