/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2020-6-17
 **/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/plugins/calendar_plugin/model/date_model.dart';
import 'package:flutter_module/plugins/seekbar_plugin.dart';
import 'dart:ui' as ui;

import '../main.dart';

//import 'package:flutter_seekbar/seekbar/progress_value.dart';

class AssessmentPage extends StatefulWidget {
  @override
  AssessmentPageState createState() => AssessmentPageState();
}

class AssessmentPageState extends State<AssessmentPage> {
  final TextEditingController _textController = new TextEditingController();

  var v;
  ui.Image _image;
  ui.Image _imageBtn;
  ui.Image _bubble1;
  ui.Image _bubble2;
  ui.Image _bubble3;
  ui.Image _bubble4;
  List<ui.Image> _imageBubbles;

  num progressValue = 0.0;

  String assessment;  //  前期评估

  @override
  void initState() {
    super.initState();

    _loadImage('lib/assets/bubble_smile1.png').then((res) {
      _bubble1 = res;
    });

    _loadImage('lib/assets/bubble_smile2.png').then((res) {
      _bubble2 = res;
    });

    _loadImage('lib/assets/bubble_smile3.png').then((res) {
      _bubble3 = res;
    });

    _loadImage('lib/assets/bubble_smile4.png').then((res) {
      _bubble4 = res;
    });

    setState(() {});
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
    DateModel date = mainModel.currentDateModel;
    TextStyle selectFont = TextStyle(color: Color(0xff29D9D6), fontSize: ScreenUtil().setSp(32));
    TextStyle nameFont = TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(32));
    TextStyle textFont = TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(28));
    TextStyle btnFont = TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(40));
    TextStyle saveFont = TextStyle(color: Color(0xff29D9D6), fontSize: ScreenUtil().setSp(40));

    _imageBubbles = [_bubble1, _bubble2, _bubble3, _bubble4];

    _loadImage('lib/assets/icon_switch.png').then((res) {
      _image = res;
      setState(() {});
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('课堂表现', style: TextStyle(fontSize: ScreenUtil().setSp(40), color: Color(0xff6D7993))),
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: ScreenUtil().setWidth(112),
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: Color.fromRGBO(41, 217, 214, 0.2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${date.year}年${date.month}月${date.day}日 ', style: selectFont),
                  Text('数学课', style: selectFont)
                ],
              ),
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(64), right: ScreenUtil().setWidth(64)),
            ),
          ),
          Container(
            height: ScreenUtil().setWidth(144),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(96),
                  height: ScreenUtil().setWidth(96),
                  child: CircleAvatar(
                      radius: ScreenUtil().setWidth(96),
                      //头像图片 -> NetworkImage网络图片，AssetImage项目资源包图片, FileImage本地存储图片
                      backgroundImage: AssetImage('lib/assets/avatar.JPG')
                  ),
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(48), right: ScreenUtil().setWidth(48)),
                ),
                Text('丁丁', style: nameFont,)
              ],
            ),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Color.fromRGBO(240,241,244,1)))
            ),
          ),
          Container(
            height: ScreenUtil().setWidth(114),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(20),
                  height: ScreenUtil().setWidth(20),
                  decoration: BoxDecoration(
                      color: Color(0xff29D9D6),
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(20)))
                  ),
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(48), right: ScreenUtil().setWidth(20)),
                ),
                Text('前期评估', style: nameFont,)
              ],
            ),
          ),
          Container(
            color: Color(0xffF7F8F9),
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(48), bottom: ScreenUtil().setWidth(20)),
            child: Column(
              children: <Widget>[
                Container(
                    width: ScreenUtil().setWidth(590),
                    child: Text('在游戏或活动时，儿童能够遵守教师或同伴所订下的活动规则，例如主动轮候、在指定范围内活动、不骚扰别人。', style: textFont,)
                ),
                Seekbar(),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(48), bottom: ScreenUtil().setWidth(20)),
            child: Column(
              children: <Widget>[
                Container(
                    width: ScreenUtil().setWidth(590),
                    child: Text('在游戏或活动时，儿童能够遵守教师或同伴所订下的活动规则，例如主动轮候、在指定范围内活动、不骚扰别人。', style: textFont,)
                ),
                Seekbar(),
              ],
            ),
          ),

          Container(
            height: ScreenUtil().setWidth(114),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: Text('前期评估', style: nameFont),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(48)),
          ),
          Container(
            child: Center(
              child: Container(
                width: ScreenUtil().setWidth(658),
                height: ScreenUtil().setWidth(224),
                decoration: BoxDecoration(
                    color: Color(0xffF8F8FA),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(8.0)),
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: '请输入评语',
                      hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.25), height: ScreenUtil().setWidth(0.8)),
                      fillColor: Color(0xffF8F8FA),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        assessment = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(304),
                  height: ScreenUtil().setWidth(112),
                  child: Center(
                    child: Text('提交', style: btnFont,),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(112)),
                      color: Color(0xff29D9D6)
                  ),
                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(46)),
                ),
                Container(
                  width: ScreenUtil().setWidth(304),
                  height: ScreenUtil().setWidth(112),
                  child: Center(
                    child: Text('保存', style: saveFont,),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(112)),
                      color: Color(0xffffffff),
                    border: Border.all(color: Color(0xff29D9D6), width: 2)
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(48), bottom: ScreenUtil().setWidth(80)),
          ),
        ],
      ),
    );
  }

  Container Seekbar() {
    return Container(
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(40), ScreenUtil().setWidth(40), ScreenUtil().setWidth(40), ScreenUtil().setWidth(40)),
                width: ScreenUtil().setWidth(558),
                child: SeekBar(
                  progressHeight: ScreenUtil().setWidth(32),
                  value: progressValue,
                  sectionCount: 4,
                  sectionRadius: ScreenUtil().setWidth(16),
                  isRound: true,
                  showSectionText: false,
                  progressColor: Color(0xff29D9D6),
                  backgroundColor: Color(0xffF0F1F4),
                  sectionTextMarginTop: 2,
                  sectionDecimal: 0,
                  sectionTextSize: 14,
                  hideBubble: false,
                  afterDragShowSectionText: false,
                  progressImage: _image,
                  bubbleImage: _bubble1,
                  bubbleImages: _imageBubbles,
                  onValueChanged: (res) {
                    setState(() {
                      progressValue = res.value;
                    });
                  },
                )
            ),
          ],
        ),
      );
  }
}