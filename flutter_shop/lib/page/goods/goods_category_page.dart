import 'package:flutter/material.dart';
import 'package:fluttershop/model/category_title_model.dart';
import 'package:fluttershop/page/goods/goods_list_page.dart';
import 'package:fluttershop/service/goods_service.dart';

class GoodsCategoryPage extends StatefulWidget {
  int categoryId;
  String categoryName;

  GoodsCategoryPage(
      {Key key, @required this.categoryName, @required this.categoryId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _GoodsCategoryPageState();
}

class _GoodsCategoryPageState extends State<GoodsCategoryPage>
    with TickerProviderStateMixin {
  ScrollController _scrollController;

  TabController _tabController;

  GoodsService _goodsService = GoodsService();

  CategoryTitleModel _categoryTitleModel;

  List<CategoryModel> brotherCategory = List();

  var categoryFuture;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    var params = {'id': widget.categoryId};
    categoryFuture = _goodsService.getGoodsCategory(params, (categoryTitles) {
      _categoryTitleModel = categoryTitles;
      brotherCategory = _categoryTitleModel.brotherCategory;

      currentIndex = getCurrentIndex();
    }, (fail) {});
  }

  getCurrentIndex() {
    for (int i = 0; i < brotherCategory.length; i++) {
      if (brotherCategory[i].id == _categoryTitleModel.currentCategory.id) {
        return i;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: categoryFuture,
          builder: (BuildContext context, AsyncSnapshot shop) {
            _scrollController = ScrollController();
            _tabController = TabController(
                initialIndex: currentIndex,
                length: brotherCategory.length,
                vsync: this);

            return Scaffold(
              appBar: AppBar(
                title: Text(widget.categoryName),
                centerTitle: true,
                bottom: TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  tabs: getTabBars(),
                ),
              ),
              body: TabBarView(
                children: getTabBarViews(),
                controller: _tabController,
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> getTabBars() {
    List<Widget> tabBars = List();

    for (var category in brotherCategory) {
      tabBars.add(getTabBarWidget(category));
    }

    return tabBars;
  }

  Widget getTabBarWidget(CategoryModel category) {
    return Tab(
      text: category.name,
    );
  }

  List<Widget> getTabBarViews() {
    List<Widget> tabBarViews = List();

    for (int index = 0; index < brotherCategory.length; index++) {
      tabBarViews.add(GoodsListPage(brotherCategory[index].id));
    }

    return tabBarViews;
  }
}
