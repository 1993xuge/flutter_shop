import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/model/home_model.dart';
import 'package:fluttershop/page/home/home_banner.dart';
import 'package:fluttershop/page/home/home_category.dart';
import 'package:fluttershop/page/home/home_product.dart';
import 'package:fluttershop/service/home_service.dart';
import 'package:fluttershop/utils/shared_preferences_utils.dart';
import 'package:fluttershop/utils/toast_util.dart';
import 'package:fluttershop/widget/loading_dialog_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeService _homeService = HomeService();
  HomeModel _homeModel;

  EasyRefreshController _controller = EasyRefreshController();

  @override
  void initState() {
    super.initState();

    _queryHomeData();
  }

  _queryHomeData() {
    _homeService.queryHomeData((success) {
      setState(() {
        _homeModel = success;
      });
      _controller.finishRefresh();
    }, (error) {
      ToastUtil.showToast(error);
      _controller.finishRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(KString.HOME_TITLE),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: _contentWidget(),
    );
  }

  Widget _contentWidget() {
    return _homeModel == null
        ? LoadingDialogWidget()
        : Container(
            child: EasyRefresh(
              controller: _controller,
              header: BezierCircleHeader(backgroundColor: Colors.redAccent),
              footer: BezierBounceFooter(backgroundColor: Colors.redAccent),
              enableControlFinishRefresh: true,
              enableControlFinishLoad: false,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    HomeBannerWidget(
                        _homeModel.banner,
                        _homeModel.banner.length,
                        ScreenUtil.instance.setHeight(360)),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    HomeCategoryWidget(_homeModel.channel),
                    Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(KString.NEW_PRODUCT),
                    ),
                    HomeProductWidget(_homeModel.newGoodsList),
                    Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(KString.HOT_PRODUCT),
                    ),
                    HomeProductWidget(_homeModel.hotGoodsList),
                  ],
                ),
              ),
              onRefresh: () async {
                _queryHomeData();
                _controller.finishRefresh();
              },
            ),
          );
  }
}
