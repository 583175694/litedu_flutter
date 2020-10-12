import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/entity/student_evaluation.dart';
import 'package:flutter_module/plugins/mock_data.dart';
import 'package:flutter_module/plugins/seekbar_plugin.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';
import 'dart:ui' as ui;

import '../main.dart';
import 'dropdown_list.dart';

class ExampleSliver extends StatefulWidget {
  @override
  _ExampleSliverState createState() => _ExampleSliverState();
}

class _ExampleSliverState extends State<ExampleSliver> {
  ui.Image _image;
  ui.Image _bubble1;
  ui.Image _bubble2;
  ui.Image _bubble3;
  ui.Image _bubble4;
  List<ui.Image> _imageBubbles;
  String assessment;  //  前期评估

  StudentEvaluation studentEvaluation;

  TextStyle nameFont = TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(32));
  TextStyle textFont = TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(28));
  TextStyle btnFont = TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(40));
  TextStyle saveFont = TextStyle(color: Color(0xff29D9D6), fontSize: ScreenUtil().setSp(40));
  TextStyle selectFont = TextStyle(color: Color(0xff29D9D6), fontSize: ScreenUtil().setSp(32));

  List<ExampleSection> sectionList;

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

  ///  提交
  void onConfirm(Results item) async {
    List<int> list = new List();
    item.questions.forEach((Questions res) {
      list.add(res.score);
    });

    await mainModel.submitStudentEvaluation(item.id, item.content, list, new List());
    await mainModel.getStudentEvaluation(mainModel.studentId);
    setState(() {});
  }

  //  加载列表
  static List<ExampleSection> getExampleSections(List<Results> results) {
    var sections = List<ExampleSection>();
    for (int i = 0; i < results.length; i++) {
      Results item = results[i];
      var section = ExampleSection()
        ..header = item.studentName
        ..items = List.generate(item.questions.length, (index) => item.questions[index].content)
        ..expanded = true;
      sections.add(section);
    }
    return sections;
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);

    _imageBubbles = [_bubble1, _bubble2, _bubble3, _bubble4];

    //  获取学生评价数据
    if (studentEvaluation == null && mainModel.studentEvaluation != null) {
      studentEvaluation = mainModel.studentEvaluation;
      sectionList = getExampleSections(studentEvaluation.results);
    }

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverExpandableList(
              builder: SliverExpandableChildDelegate<String, ExampleSection>(
                sectionList: sectionList,
                headerBuilder: _buildHeader,  //  头部
                itemBuilder: (context, sectionIndex, itemIndex, index) {
                  //  问题content
                  String item = sectionList[sectionIndex].items[itemIndex];

                  // 所有学生评价数据
                  Results result = studentEvaluation.results[sectionIndex];

                  return Container(
                    width: MediaQuery.of(context).size.width,
                    color: index % 2 == 0 ? Color(0xffF7F8F9) : Colors.white,
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(48), bottom: ScreenUtil().setWidth(20)),
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: ScreenUtil().setWidth(590),
                            child: Text(item, style: textFont,)
                        ),
                        //  六边形、七边形评估
                        result.evaluationType == 'six' ? SeekbarSix(result.questions[itemIndex]) : SeekbarSeven(result.questions[itemIndex]),
                        //  最后一个增加确认按钮
                        Offstage(
                          offstage: itemIndex != sectionList[sectionIndex].items.length - 1,
                          child: Container(
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
                                    child: MyTextField(item: result)
                                ),
                              ),
                            ),
                            margin: EdgeInsets.only(top: ScreenUtil().setWidth(28), bottom: ScreenUtil().setWidth(48)),
                          ),  //  评语,
                        ),
                        Offstage(
                          offstage: itemIndex != sectionList[sectionIndex].items.length - 1,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  child: Container(
                                    width: ScreenUtil().setWidth(304),
                                    height: ScreenUtil().setWidth(112),
                                    child: Center(
                                      child: Text('提交', style: btnFont),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(112)),
                                        color: Color(0xff29D9D6)
                                    ),
                                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(46)),
                                  ),
                                  onTap: () => onConfirm(result),
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
                            margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(80)),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  头部
  Widget _buildHeader(BuildContext context, int sectionIndex, int index) {
    ExampleSection section = sectionList[sectionIndex];
    Results item = studentEvaluation.results[sectionIndex];

    return InkWell(
        child: Container(
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
              Text(item.studentName, style: nameFont),
              Container(
                child: Text(item.evaluateDatetime == null ? '' : '已提交', style: selectFont),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(268)),
              )
            ],
          ),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Color.fromRGBO(240,241,244,1))),
              color: Colors.white
          ),
        ),
        onTap: () {
          //toggle section expand state
          setState(() {
            section.setSectionExpanded(!section.isSectionExpanded());
          });
        }
      );
  }

  //  前期评估
  Container SeekbarSix(Questions item) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(40), ScreenUtil().setWidth(40), ScreenUtil().setWidth(40), ScreenUtil().setWidth(40)),
              width: ScreenUtil().setWidth(528),
              child: SeekBar(
                progressHeight: ScreenUtil().setWidth(32),
                value: item.score == -1 ? 0 : ((item.score - 2) / 8 * 100).toDouble(), //  换算成 0~100
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
                  });
                },
              )
          ),
          Container(
            child: Text(
                item.score <= 4 ? '一般' : item.score > 4 && item.score <= 8 ? '良好' : item.score > 8 && item.score <= 10 ? '优秀' : '',
                style: TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(32))),
          )
        ],
      ),
    );
  }

  //  中期评估
  Widget SeekbarSeven(Questions item) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(40), ScreenUtil().setWidth(40), ScreenUtil().setWidth(40), ScreenUtil().setWidth(40)),
                width: ScreenUtil().setWidth(476),
                child: SeekBar(
                  progressHeight: ScreenUtil().setWidth(32),
                  value: item.score == -1 ? 0 : ((item.score - 2) / 8 * 100).toDouble(), //  换算成 0~100
                  isRound: true,
                  showSectionText: false,
                  progressColor: Color(0xffFFAB3B),
                  backgroundColor: Color(0xffF0F1F4),
                  sectionTextMarginTop: 2,
                  sectionDecimal: 0,
                  sectionTextSize: 14,
                  hideBubble: true,
                  afterDragShowSectionText: false,
                  progressImage: _image,
                  onValueChanged: (res) {
                    setState(() {
                      //  2，4，6，8，10 五段
                      item.score = ((res.value * 8 / 100) + 2).toInt();

                      if (item.score <= 4) {
                        item.typeName = '有待进步';
                      } else if (item.score > 4 && item.score <= 7) {
                        item.typeName = '勉强凑合';
                      } else if (item.score > 8 && item.score <= 10) {
                        item.typeName = '精妙绝伦';
                      }
                    });
                  },
                )
            ),
            Container(
              child: Text(item.typeName == "" ? '有待进步' : item.typeName, style: TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(32))),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Container(
                child: starIcon(),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(168)),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    starIcon(),
                    starIcon()
                  ],
                ),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(100)),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    starIcon(),
                    starIcon(),
                    starIcon()
                  ],
                ),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(80)),
              )
            ],
          ),
        )
      ],
    );
  }

  Image starIcon() => Image.asset('lib/assets/icon_star_evaluation.png', width: ScreenUtil().setWidth(48), height: ScreenUtil().setWidth(48));
}
