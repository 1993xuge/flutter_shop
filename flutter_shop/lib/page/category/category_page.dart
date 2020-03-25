
import 'package:flutter/material.dart';
import 'package:fluttershop/config/index.dart';
import 'package:fluttershop/page/category/sub_category.dart';

import 'first_category.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KString.CATEGORY_TITLE),
        centerTitle: true,
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: FirstCategoryWidget(),
            ),
            Expanded(
              flex: 8,
              child: SubCategoryWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
