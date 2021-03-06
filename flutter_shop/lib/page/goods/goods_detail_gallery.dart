import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/widget/cached_image_widget.dart';

class GoodsDetailGallery extends StatelessWidget {

  List<String> galleryData = List();

  int size;

  double viewHeight;

  GoodsDetailGallery(this.galleryData, this.size, this.viewHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: viewHeight,
      child: galleryData == null || galleryData.isEmpty
          ? Container(
              height: ScreenUtil.instance.setHeight(200),
              color: Colors.grey,
              alignment: Alignment.center,
              child: Text(KString.NO_DATA_TEXT),
            )
          : Swiper(
              itemCount: galleryData.length,
              scrollDirection: Axis.horizontal,
              loop: true,
              index: 0,
              autoplay: false,
              itemBuilder: (BuildContext context, int index) {
                return CachedImageWidget(
                    double.infinity, double.infinity, galleryData[index]);
              },
              duration: 10000,

              // 底部指示器
              pagination: SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                      size: 8,
                      color: KColor.bannerDefaultColor,
                      activeColor: KColor.bannerActiveColor)),
            ),
    );
  }
}
