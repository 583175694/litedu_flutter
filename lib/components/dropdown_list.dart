import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/entity/student_evaluation.dart';
import 'package:flutter_module/plugins/seekbar_plugin.dart';
import 'dart:ui' as ui;

import '../main.dart';

/// 用于管理状态
class ExpandState {
  bool isOpen;
  var index;

  ExpandState(this.isOpen, this.index);
}

class DropdownList extends StatefulWidget {
  @override
  _DropdownListState createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  var v;
  ui.Image _image;
  ui.Image _bubble1;
  ui.Image _bubble2;
  ui.Image _bubble3;
  ui.Image _bubble4;
  List<ui.Image> _imageBubbles;
  final TextEditingController _textController = new TextEditingController();
  String assessment;  //  前期评估

  StudentEvaluation studentEvaluation;
  List<ExpandState> expandStateList;    //开展开的状态列表， ExpandStateBean是自定义的类

  TextStyle nameFont = TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(32));
  TextStyle textFont = TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(28));
  TextStyle btnFont = TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(40));
  TextStyle saveFont = TextStyle(color: Color(0xff29D9D6), fontSize: ScreenUtil().setSp(40));

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

    studentEvaluation = mainModel.studentEvaluation;
    List<ExpandState> list = new List();
    for (int i = 0; i < studentEvaluation.results.length; i++) {
      list.add(ExpandState(false, i));
    }
    expandStateList = list;

    setState(() {});
  }

  /// 加载图片
  Future<ui.Image> _loadImage(String path) async {
    var data = await rootBundle.load(path);
    var codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    var info = await codec.getNextFrame();
    return info.image;
  }

  /// 修改列表项展开与闭合的方法
  _setExpandOpenOrClose(int index, isExpand) {
    setState(() {
      /// 遍历可展开状态列表
      expandStateList.forEach((item){
        if(item.index==index){
          /// 取反
          item.isOpen = !isExpand;
        }
      });
    });
  }

  ///  提交
  void onConfirm(Results item) {
    List<int> list = new List();
    item.questions.forEach((Questions res) {
      list.add(res.score);
    });

    print(item.content);
    mainModel.submitStudentEvaluation(item.id, item.content, list, new List());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);

    _imageBubbles = [_bubble1, _bubble2, _bubble3, _bubble4];

    _loadImage('lib/assets/icon_switch.png').then((res) {
      _image = res;
      setState(() {});
    });

    return Column(
      children: <Widget>[
        evaluationList()
      ],
    );
  }

  Container Seekbar(Questions item) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(40), ScreenUtil().setWidth(40), ScreenUtil().setWidth(40), ScreenUtil().setWidth(40)),
              width: ScreenUtil().setWidth(558),
              child: SeekBar(
                progressHeight: ScreenUtil().setWidth(32),
                value: item.score == -1 ? 0 : ((item.score - 2) / 8 * 100).toDouble(), //  换算成 0~100
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
                    //  2，4，6，8，10 五段
                    item.score = ((res.value * 8 / 100) + 2).toInt();
                    print(item.score);
                  });
                },
              )
          ),
        ],
      ),
    );
  }

  //  孩子列表
  Widget evaluationList() {
    List<ExpansionPanel> tiles = [];
    Widget content;
    for(int i = 0; i < studentEvaluation.results.length; i++) {
      Results item = studentEvaluation.results[i];
      tiles.add(
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              height: ScreenUtil().setWidth(144),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(96),
                    height: ScreenUtil().setWidth(96),
                    child: CircleAvatar(
                        radius: ScreenUtil().setWidth(96),
                        backgroundImage: NetworkImage(item.studentLogo)
                    ),
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(48), right: ScreenUtil().setWidth(48)),
                  ),
                  Text(item.studentName, style: nameFont,)
                ],
              ),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color.fromRGBO(240,241,244,1)))
              ),
            );
          },
          body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
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
                questionList(item.questions),
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
                              item.content = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),  //  评语
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
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
                        onTap: () => onConfirm(item),
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
                ),  //  提交
              ],
            ),
          ),
          isExpanded: expandStateList[i].isOpen, // 设置面板的状态，true展开，false折叠
        ),
      );
    }
    content = ExpansionPanelList( // 点击折叠按钮实现面板的伸缩
      expansionCallback: (int panelIndex, bool isExpanded) {
        _setExpandOpenOrClose(panelIndex, isExpanded);
      },
      children: tiles,
    );
    return content;
  }

  //  评价列表
  Widget questionList(List<Questions> list) {
    List<Widget> tiles = [];
    Widget content;
    for(var item in list) {
      tiles.add(
        Container(
          width: MediaQuery.of(context).size.width,
          color: Color(0xffF7F8F9),
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(48), bottom: ScreenUtil().setWidth(20)),
          child: Column(
            children: <Widget>[
              Container(
                  width: ScreenUtil().setWidth(590),
                  child: Text(item.content, style: textFont,)
              ),
              Seekbar(item),
            ],
          ),
        )
      );
    }
    content = new Column(
        children: tiles
    );
    return content;
  }
}