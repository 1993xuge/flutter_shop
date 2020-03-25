import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttershop/event/category_event.dart';
import 'package:fluttershop/model/sub_category_model.dart';
import 'package:fluttershop/service/category_service.dart';
import 'package:fluttershop/utils/navigator_util.dart';

class SubCategoryWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubCategoryWidgetWidget();
}

class _SubCategoryWidgetWidget extends State<SubCategoryWidget> {
  CategoryService categoryService = CategoryService();

  List<SubCategoryModel> subCategoryModels = List();

  var categoryId, categoryName, categoryImage;

  bool flag = true;

  @override
  void initState() {
    super.initState();
  }

  _listener() {
    eventBus.on<CategoryEvent>().listen((event) => _updateView(event));
  }

  _updateView(CategoryEvent event) {
    if (flag) {
      flag = false;
      setState(() {
        categoryId = event.id;
        categoryName = event.categoryName;
        categoryImage = event.categoryImage;
      });

      _getSubCategory(event.id);
    }
  }

  _getSubCategory(int id) {
    var params = {"id": id};
    print("_getSubCategory : params = $params");

    categoryService.getSubCategoryData(params, (newModels) {
      flag = true;
      setState(() {
        subCategoryModels = newModels;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _listener();
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(ScreenUtil.instance.setWidth(20)),
            height: ScreenUtil.instance.setWidth(200),
            child: categoryImage != null
                ? Image.network(
                    categoryImage,
                    fit: BoxFit.fill,
                  )
                : Container(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4),
          ),
          Center(
            child: Text(
              categoryName ?? "",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: subCategoryModels.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return _getItemWidget(subCategoryModels[index]);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.85),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
        ],
      ),
    );
  }

  Widget _getItemWidget(SubCategoryModel model) {
    return GestureDetector(
      onTap: () => _itemClick(model.id),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Image.network(
              model.picUrl ?? "",
              fit: BoxFit.fill,
              height: 60,
            ),
            Text(
              model.name,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }

  void _itemClick(int id) {
    NavigatorUtil.goCategoryGoodsListPage(context, categoryName, id);
  }
}
