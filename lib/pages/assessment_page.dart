/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2020-6-17
 **/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/plugins/seekbar_plugin.dart';
import 'dart:ui' as ui;

import 'package:flutter_seekbar/seekbar/progress_value.dart';

class AssessmentPage extends StatefulWidget {
  @override
  AssessmentPageState createState() => AssessmentPageState();
}

class AssessmentPageState extends State<AssessmentPage> {
  var v;
  ui.Image _image;
  ui.Image _bubble1;
  ui.Image _bubble2;
  ui.Image _bubble3;
  ui.Image _bubble4;
  List<ui.Image> _imageBubbles;
  num progressValue = 0.0;

  @override
  void initState() {
    super.initState();

    _loadImage('lib/assets/icon_switch.png').then((res) {
      _image = res;
    });

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
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);

    _imageBubbles = [_bubble1, _bubble2, _bubble3, _bubble4];

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(40, 40, 40, 40),
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
                    afterDragShowSectionText: true,
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
                Text('${progressValue}')
              ],
            ),
        ),
      ),
    );
  }
}