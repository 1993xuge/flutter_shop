import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/model/home_model.dart';
import 'package:fluttershop/utils/navigator_util.dart';
import 'package:fluttershop/widget/cached_image_widget.dart';

class HomeProductWidget extends StatelessWidget {
  List<Goods> products;

  HomeProductWidget(this.products);

  _goGoodsDetail(BuildContext context, Goods goods) {
    NavigatorUtil.goGoodsDetails(context, goods.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return _getGridViewItem(context, products[index]);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
        ),
      ),
    );
  }

  Widget _getGridViewItem(BuildContext context, Goods goods) {
    return Container(
      child: InkWell(
        onTap: () => _goGoodsDetail(context, goods),
        child: Card(
          elevation: 2,
          margin: EdgeInsets.all(6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                child: CachedImageWidget(ScreenUtil.instance.setWidth(200),
                    ScreenUtil.instance.setHeight(200), goods.picUrl),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4),
              ),
              Container(
                padding: EdgeInsets.only(left: 4, right: 4),
                alignment: Alignment.centerLeft,
                child: Text(
                  goods.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 4, right: 4),
                alignment: Alignment.center,
                child: Text(
                  "￥${goods.retailPrice}",
                  style: TextStyle(color: KColor.priceColor, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
