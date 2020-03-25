import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttershop/event/cart_number_event.dart';

typedef OnNumberChange(int num);

class CartNumberWidget extends StatefulWidget {
  OnNumberChange onNumberChange;

  int _number;

  CartNumberWidget(this._number, this.onNumberChange);

  @override
  State<StatefulWidget> createState() => _CartNumberWidgetState();
}

class _CartNumberWidgetState extends State<CartNumberWidget> {
  int goodsNumber;

  OnNumberChange onNumberChange;

  @override
  void initState() {
    super.initState();

    goodsNumber = widget._number;
    onNumberChange = widget.onNumberChange;
  }

  _listener() {
    cartNumberEventBus
        .on<CartNumberEvent>()
        .listen((CartNumberEvent cartNumberEvent) {
      setState(() {
        goodsNumber = cartNumberEvent.number;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _listener();

    return Container(
      width: ScreenUtil.instance.setWidth(150),
      height: ScreenUtil.instance.setHeight(50),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: _reduce,
            child: Container(
              width: ScreenUtil.instance.setWidth(50),
              height: double.infinity,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                  shape: Border.all(color: Colors.grey, width: 1)),
              child: Text(
                '-',
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: ScreenUtil.instance.setSp(26)),
              ),
            ),
          ),
          Container(
            width: ScreenUtil.instance.setWidth(50),
            height: double.infinity,
            alignment: Alignment.center,
            decoration: ShapeDecoration(
                shape: Border(
                    top: BorderSide(color: Colors.grey, width: 1),
                    bottom: BorderSide(color: Colors.grey, width: 1))),
            child: Text(
              '$goodsNumber',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: ScreenUtil.instance.setSp(26)),
            ),
          ),
          InkWell(
            onTap: _add,
            child: Container(
              width: ScreenUtil.instance.setWidth(50),
              height: double.infinity,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                  shape: Border.all(color: Colors.grey, width: 1)),
              child: Text(
                '+',
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: ScreenUtil.instance.setSp(26)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _reduce() {
    if (goodsNumber > 1) {
      setState(() {
        goodsNumber--;
        print("_reduce after, goodsNumber = $goodsNumber");

        onNumberChange(goodsNumber);
      });
    }
  }

  _add() {
    setState(() {
      goodsNumber++;
      print("_add after, goodsNumber = $goodsNumber");
      onNumberChange(goodsNumber);
    });
  }
}
