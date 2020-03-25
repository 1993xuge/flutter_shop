import 'package:flutter/material.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/event/category_event.dart';
import 'package:fluttershop/model/first_category_model.dart';
import 'package:fluttershop/service/category_service.dart';

class FirstCategoryWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FirstCategoryWidget();
}

class _FirstCategoryWidget extends State<FirstCategoryWidget> {
  CategoryService categoryService = CategoryService();

  List<FirstCategoryModel> firstCategoryList = List();

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    categoryService.getFirstCategoryData((list) {
      dispatchCategoryEvent(list[0]);
      setState(() {
        firstCategoryList = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: firstCategoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return _getFirstLevelItemWidget(firstCategoryList[index], index);
          }),
    );
  }

  Widget _getFirstLevelItemWidget(
      FirstCategoryModel firstCategoryModel, int index) {
    return GestureDetector(
      onTap: () => _itemClick(index),
      child: Container(
        width: 100,
        height: 50,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              height: 48,
              alignment: Alignment.center,
              child: Text(
                firstCategoryModel.name,
                style: index == _selectedIndex
                    ? TextStyle(
                        fontSize: 14, color: KColor.categorySelectedColor)
                    : TextStyle(
                        fontSize: 14, color: KColor.categoryDefaultColor),
              ),
            ),
            index == _selectedIndex
                ? Divider(height: 2, color: KColor.categorySelectedColor)
                : Divider(height: 1, color: Colors.white),
          ],
        ),
      ),
    );
  }

  void _itemClick(int index) {
    setState(() {
      _selectedIndex = index;
    });
    dispatchCategoryEvent(firstCategoryList[index]);
  }

  void dispatchCategoryEvent(FirstCategoryModel model) {
    // 分发事件
    eventBus.fire(CategoryEvent(
      model.id,
      model.name,
      model.picUrl,
    ));
  }
}
