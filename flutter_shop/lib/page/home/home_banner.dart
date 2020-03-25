import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/model/home_model.dart';
import 'package:fluttershop/utils/navigator_util.dart';
import 'package:fluttershop/widget/cached_image_widget.dart';

class HomeBannerWidget extends StatelessWidget {
  List<BannerModel> bannerData = List();

  int size;

  double viewHeight;

  HomeBannerWidget(this.bannerData, this.size, this.viewHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: viewHeight,
      width: double.infinity,
      child: bannerData == null || bannerData.isEmpty
          ? Container(
              height: ScreenUtil.instance.setHeight(400),
              color: Colors.grey,
              alignment: Alignment.center,
              child: Text(KString.NO_DATA_TEXT),
            )
          : Swiper(
              onTap: (index) {
                BannerModel data = bannerData[index];
                NavigatorUtil.goWebView(context, data.name, data.link);
              },
              itemCount: bannerData.length,
              scrollDirection: Axis.horizontal,
              loop: true,
              index: 0,
              autoplay: false,
              itemBuilder: (BuildContext context, int index) {
                return CachedImageWidget(
                    double.infinity, double.infinity, bannerData[index].url);
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
