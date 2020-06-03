/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';

class GradeChoiceModel extends StatefulWidget {
  @override
  GradeChoiceModelState createState() => GradeChoiceModelState();
}

class GradeChoiceModelState extends State<GradeChoiceModel> {
  List<String> _className = new List();
  int currentSelect = 0;

  @override
  void initState() {
    super.initState();

    _className = ['三年1班', '三年2班', '四年1班', '四年2班', '五年1班'];
  }

  Widget classList() {
    List<Widget> tiles = [];
    Widget content;
    TextStyle defaultStyle = TextStyle(fontSize: ScreenUtil().setWidth(32), color: Color(0xff6D7993), fontWeight: FontWeight.normal, decoration: TextDecoration.none);
    TextStyle selectStyle = TextStyle(fontSize: ScreenUtil().setWidth(32), color: Color(0xffffffff), fontWeight: FontWeight.normal, decoration: TextDecoration.none);

    for(int i = 0; i < _className.length; i++) {
      tiles.add(
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 196,
                height: 40,
                child: Center(
                  child: new Text(_className[i], style: currentSelect == i ? selectStyle : defaultStyle)
                ),
                margin: EdgeInsets.only(top: 13, bottom: 13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: currentSelect == i ? Color(0xff29D9D6) : Colors.white
                ),
              ),
              onTap: () {
                setState(() {
                  currentSelect = i;
                });
              },
            ),
          ]
        )
      );
    }
    content = new ListView(
        children: tiles
    );
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: ScreenUtil().setWidth(670),
        height: ScreenUtil().setWidth(662),
        child: Column(
          children: <Widget>[
            Container(
              height: 56,
              child: Center(
                child: Text('选择班级', style: TextStyle(fontSize: ScreenUtil().setWidth(32), color: Color(0xff6D7993), fontWeight: FontWeight.normal, decoration: TextDecoration.none)),
              ),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.06)))
              ),
            ),
            Container(
              height: ScreenUtil().setWidth(438),
              child: classList(),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.06)))
              ),
            ),
            GestureDetector(
              child: Container(
                height: ScreenUtil().setWidth(112),
                width: ScreenUtil().setWidth(670),
                child: Center(
                  child: Text('确定', style: TextStyle(fontSize: ScreenUtil().setWidth(32), color: Color(0xff29D9D6), fontWeight: FontWeight.normal, decoration: TextDecoration.none)),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
      ),
    );
  }
}