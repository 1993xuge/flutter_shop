import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/model/category_title_model.dart';
import 'package:fluttershop/model/goods_detail_model.dart';
import 'package:fluttershop/page/goods/goods_detail_gallery.dart';
import 'package:fluttershop/page/goods/goods_list_page.dart';
import 'package:fluttershop/service/goods_service.dart';
import 'package:fluttershop/widget/cached_image_widget.dart';
import 'package:fluttershop/widget/cart_number_widget.dart';

class GoodsDetailPage extends StatefulWidget {
  int goodsId;

  GoodsDetailPage({Key key, @required this.goodsId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {
  int goodsId;

  GoodsService _goodsService = GoodsService();

  // TODO CartService
  // TODO CollectService

  GoodsDetailModel _goodsDetailModel;

  var params;
  int _specificationIndex = 0;

  int _number = 1;

  var _goodsDetailFuture;

  var token;

  var _isCollection = false;

  @override
  void initState() {
    super.initState();

    goodsId = widget.goodsId;
    var params = {'id': goodsId};
    _goodsDetailFuture = _goodsService.getGoodsDetailData(params, (goodsModel) {
      _goodsDetailModel = goodsModel;
    });
  }

  _collection() {
    // TODO 收藏
  }

  _addOrDeleteCollection(){
    // TODO 收藏 或者 取消 收藏
  }

  _addCart() {
    // 添加到 购物车
  }

  _buy() {
    // 立即购买
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(KString.GOODS_DETAIL),
          centerTitle: true,
        ),

        // 异步 组件
        body: FutureBuilder(
          future: _goodsDetailFuture,
          builder: (BuildContext context, AsyncSnapshot shot) {
            switch (shot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Container(
                  child: Center(
                    child: SpinKitFoldingCube(
                      size: 40,
                      color: KColor.watingColor,
                    ),
                  ),
                );
              default:
                if (shot.hasError) {
                  return Container(
                    child: Center(
                      child: Text(
                        KString.SERVER_EXCEPTION,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                } else {
                  return _detailWidget();
                }
                break;
            }
          },
        ),

        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () => _collection(),
                      child: Icon(
                        Icons.star_border,
                        size: 30,
                        color: _isCollection
                            ? KColor.collectionButtonColor
                            : KColor.unCollectionButtonColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.add_shopping_cart,
                    color: KColor.addCartIconColor,
                    size: 30,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: KColor.addCartButtonColor,
                    child: InkWell(
                      onTap: () => openBottomSheet(
                          context, _goodsDetailModel.productList[0], 1),
                      child: Center(
                        child: Text(
                          KString.ADD_CART,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: KColor.buyButtonColor,
                    child: InkWell(
                      onTap: () => openBottomSheet(
                          context, _goodsDetailModel.productList[0], 2),
                      child: Center(
                        child: Text(
                          KString.BUY,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  openBottomSheet(
      BuildContext context, ProductModel productModel, int showType) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: ScreenUtil.instance.setHeight(630),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 第一行 商品信息
                  Container(
                    margin: EdgeInsets.all(ScreenUtil.instance.setWidth(20)),
                    child: Row(
                      children: <Widget>[
                        // 商品图片
                        CachedImageWidget(
                            ScreenUtil.instance.setWidth(120),
                            ScreenUtil.instance.setHeight(120),
                            productModel.url),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // 价格
                            Text(
                              "${KString.PRICE}: ${productModel.price}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: ScreenUtil.instance.setSp(24),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil.instance.setHeight(10)),
                            ),

                            // 规格
                            Text(
                              "${KString.ALREAD_SELECTED}: ${productModel.specifications[_specificationIndex]}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: ScreenUtil.instance.setSp(24),
                              ),
                            ),
                          ],
                        ),

                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 第二行 选择 规格
                  Container(
                    margin: EdgeInsets.all(ScreenUtil.instance.setWidth(10)),
                    child: Text(
                      KString.SPECIFICATIONS,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: ScreenUtil.instance.setSp(30)),
                    ),
                  ),
                  Wrap(
                    children:
                        _specificationsWidget(productModel.specifications),
                  ),

                  // 第三行 选择 数量
                  Container(
                    margin: EdgeInsets.all(ScreenUtil.instance.setWidth(10)),
                    child: Text(
                      KString.NUMBER,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: ScreenUtil.instance.setSp(30)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(ScreenUtil.instance.setWidth(10)),
                    height: ScreenUtil.instance.setWidth(80),
                    alignment: Alignment.centerLeft,
                    child: CartNumberWidget(_number, (number) {
                      setState(() {
                        _number = number;
                      });
                    }),
                  ),

                  // 第四行 加入 购物车

                  Expanded(
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          height: ScreenUtil.instance.setHeight(100),
                          child: InkWell(
                            onTap: () => showType == 1 ? _addCart() : _buy(),
                            child: Container(
                              alignment: Alignment.center,
                              color: KColor.defaultButtonColor,
                              child: Text(
                                showType == 1 ? KString.ADD_CART : KString.BUY,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil.instance.setSp(30)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  List<Widget> _specificationsWidget(List<String> specifications) {
    List<Widget> specificationsWidget = List();

    for (int i = 0; i < specifications.length; i++) {
      specificationsWidget.add(Container(
        padding: EdgeInsets.all(ScreenUtil.instance.setWidth(10)),
        child: Chip(
          label: Text(
            specifications[i],
            style: TextStyle(
              color: i == _specificationIndex ? Colors.white : Colors.black54,
              fontSize: ScreenUtil.instance.setSp(24),
            ),
          ),
          backgroundColor: i == _specificationIndex
              ? KColor.specificationWarpColor
              : Colors.grey,
        ),
      ));
    }

    return specificationsWidget;
  }

  // 内容组件
  Widget _detailWidget() {
    var gallery = _goodsDetailModel.info.gallery;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        ListView(
          children: <Widget>[
            // 轮播图
            GoodsDetailGallery(gallery, gallery.length, 240),
            Divider(
              height: 2,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),

            // 商品基本信息
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 商品 名称
                  Text(
                    _goodsDetailModel.info.name,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 6),
                  ),

                  // 商品简介
                  Text(
                    _goodsDetailModel.info.brief,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 4),
                  ),

                  Row(
                    children: <Widget>[
                      //
                      Text(
                        "原价:${_goodsDetailModel.info.counterPrice}",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      Text(
                        "现价:${_goodsDetailModel.info.retailPrice}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 4),
            ),

            // 商品属性
            _goodsDetailModel.attribute == null ||
                    _goodsDetailModel.attribute.isEmpty
                ? Divider()
                : Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          KString.GOODS_ATTRIBUTES,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                        ),
                        _attributeWidget(_goodsDetailModel),
                      ],
                    ),
                  ),

            // 商品详情（html展示）
            Html(
              data: _goodsDetailModel.info.detail,
            ),

            // 常见问题
            _goodsDetailModel.issue == null || _goodsDetailModel.issue.isEmpty
                ? Divider()
                : Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          KString.COMMON_PROBLEM,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                        ),
                        _issueWidget(_goodsDetailModel),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    );
  }

  // 属性列表组件
  Widget _attributeWidget(GoodsDetailModel goodsDetail) {
    print("${goodsDetail.attribute.length}");

    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: goodsDetail.attribute.length,
        itemBuilder: (context, index) {
          return _attributeItemWidget(_goodsDetailModel.attribute[index]);
        });
  }

  // 属性Item组件
  Widget _attributeItemWidget(AttributeModel attributeModel) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(6),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              attributeModel.attribute,
              style: TextStyle(color: KColor.attributeTextColor, fontSize: 14),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                attributeModel.value,
                style:
                    TextStyle(color: KColor.attributeTextColor, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 常见问题 组件
  Widget _issueWidget(GoodsDetailModel goodsDetail) {
    print("${goodsDetail.issue.length}");

    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: goodsDetail.issue.length,
        itemBuilder: (context, index) {
          return _issueItemWidget(_goodsDetailModel.issue[index]);
        });
  }

  // 常见问题 Item组件
  Widget _issueItemWidget(IssueModel issueModel) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
      padding: EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            issueModel.question,
            style: TextStyle(color: KColor.issueQuestionColor, fontSize: 14),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Text(
            issueModel.answer,
            style: TextStyle(color: KColor.issueAnswerColor, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
