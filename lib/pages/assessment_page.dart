/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2020-6-17
 **/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_module/components/dropdown_list.dart';
import 'package:flutter_module/components/loading.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/model/main_model.dart';
import 'package:flutter_module/plugins/calendar_plugin/model/date_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:ui' as ui;

class ExpandState{
  bool isOpen;
  int index;

  ExpandState(this.isOpen, this.index);
}

class AssessmentPage extends StatefulWidget {
  final String courseName;
  AssessmentPage({Key key, @required this.courseName}):super(key:key);

  @override
  AssessmentPageState createState() => AssessmentPageState(this.courseName);
}

class AssessmentPageState extends State<AssessmentPage> {
  AssessmentPageState(this.courseName);
  final String courseName;

  List<ExpandState> expandStateList;    //开展开的状态列表， ExpandStateBean是自定义的类
  List<int> mList;   // 组成一个int类型数组，用来控制索引

  var v;

  num progressValue = 0.0;

  String assessment;  //  前期评估

  @override
  void initState() {
    super.initState();
  }

  /// 加载图片
  Future<ui.Image> _loadImage(String path) async {
    var data = await rootBundle.load(path);
    var codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    var info = await codec.getNextFrame();
    return info.image;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);

    final mainModel = ScopedModel.of<MainModel>(context, rebuildOnChange: true);
    DateModel date = mainModel.currentDateModel;
    TextStyle selectFont = TextStyle(color: Color(0xff29D9D6), fontSize: ScreenUtil().setSp(32));
    String _courseName = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('课堂表现', style: TextStyle(fontSize: ScreenUtil().setSp(40), color: Color(0xff6D7993))),
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
              height: ScreenUtil().setWidth(112),
              width: MediaQuery.of(context).size.width,
            child: Container(
              color: Color.fromRGBO(41, 217, 214, 0.2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${date.year}年${date.month}月${date.day}日 ', style: selectFont),
                  Container(
                    width: ScreenUtil().setWidth(300),
                    child: Text(_courseName ?? '', style: selectFont, overflow: TextOverflow.ellipsis), alignment: Alignment.centerRight,)
                ],
              ),
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(64), right: ScreenUtil().setWidth(64)),
            ),
          ),
          Positioned(
            top: ScreenUtil().setWidth(112),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - ScreenUtil().setWidth(212),
            child: DropdownListDemo(),
          ),
          Loading()
        ],
      ),
    );
  }
}