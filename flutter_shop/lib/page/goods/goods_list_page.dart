import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/model/goods_model.dart';
import 'package:fluttershop/service/goods_service.dart';
import 'package:fluttershop/utils/navigator_util.dart';
import 'package:fluttershop/widget/cached_image_widget.dart';

class GoodsListPage extends StatefulWidget {
  int categoryId;

  GoodsListPage(this.categoryId);

  @override
  State<StatefulWidget> createState() => _GoodsListPageState();
}

class _GoodsListPageState extends State<GoodsListPage> {
  GoodsService service = GoodsService();

  List<GoodsModel> goodsModels = List();

  var categoryId;

  @override
  void initState() {
    super.initState();

    if (_isDataEmpty()) {
      categoryId = widget.categoryId;
      _getGoodsData(categoryId);
    }
  }

  _getGoodsData(int categoryId) {
    var params = {"categoryId": categoryId, "page": 1, "limit": 100};
    service.getGoodsList(params, (newGoodsModelList) {
      if (mounted) {
        setState(() {
          goodsModels = newGoodsModelList;
        });
      }
    });
  }

  _isDataEmpty() {
    return goodsModels == null || goodsModels.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: _isDataEmpty()
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "images/no_data.png",
                        width: 80,
                        height: 80,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Text(
                        KString.NO_DATA_TEXT,
                        style: TextStyle(
                            fontSize: 16, color: KColor.noDataTextColor),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  itemCount: goodsModels == null ? 0 : goodsModels.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      childAspectRatio: 1),
                  itemBuilder: (context, index) {
                    return _getGoodsItemWidget(context, goodsModels[index]);
                  }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _getGoodsItemWidget(BuildContext context, GoodsModel model) {
    return GestureDetector(
      onTap: () => _itemClick(model.id),
      child: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: 320,
          height: 460,
          child: Card(
            child: Column(
              children: <Widget>[
                CachedImageWidget(double.infinity,
                    ScreenUtil.instance.setHeight(200), model.picUrl),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                Text(
                  model.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                Text(
                  "￥${model.retailPrice}",
                  style: TextStyle(color: KColor.priceColor, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _itemClick(int id) {
    NavigatorUtil.goGoodsDetails(context, id);
  }
}
