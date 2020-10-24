import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/entity/student_evaluation.dart';
import 'package:flutter_module/plugins/calendar_plugin/model/date_model.dart';
import 'package:flutter_module/plugins/seekbar_plugin.dart';
import 'package:flutter_module/plugins/expandable_plugin/sliver_expandable_list.dart';
import 'package:localstorage/localstorage.dart';
import 'package:oktoast/oktoast.dart';

import 'dart:ui' as ui;

import '../main.dart';

class AssessmentPage extends StatefulWidget {
  final String courseName;
  AssessmentPage({Key key, @required this.courseName}):super(key:key);

  @override
  _AssessmentPageState createState() => _AssessmentPageState(this.courseName);
}

class _AssessmentPageState extends State<AssessmentPage> {
  _AssessmentPageState(this.courseName);
  final String courseName;

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

  List<ListSection> sectionList = new List();

  //  本地存储
  final LocalStorage storage = new LocalStorage('evaluation');
  @override
  void initState() {
    super.initState();

    _loadImageList(); //  初始化指示器
  }

  //  加载进度条指示器、笑脸等图片
  _loadImageList() async {
    _image = await _loadImage('lib/assets/icon_switch.png');
    _bubble1 = await _loadImage('lib/assets/bubble_smile1.png');
    _bubble2 = await _loadImage('lib/assets/bubble_smile2.png');
    _bubble3 = await _loadImage('lib/assets/bubble_smile3.png');
    _bubble4 = await _loadImage('lib/assets/bubble_smile4.png');
    print(_bubble1);
    _imageBubbles = [_bubble1, _bubble2, _bubble3, _bubble4];

    setState(() {});
  }

  // 加载图片
  Future<ui.Image> _loadImage(String path) async {
    var data = await rootBundle.load(path);
    var codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    var info = await codec.getNextFrame();
    return info.image;
  }

  //  确认提交
  void showCupertinoDialog(Results result, ListSection section) {
    var dialog = CupertinoAlertDialog(
      content: Text(
        "确认提交评价",
        style: TextStyle(fontSize: 20),
      ),
      actions: <Widget>[
        CupertinoButton(
          child: Text("取消"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoButton(
          child: Text("确定"),
          onPressed: () {
            onConfirm(result, section);
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (_) => dialog);
  }

  //  提交
  void onConfirm(Results result, ListSection section) async {

    List<int> list = new List();
    result.questions.forEach((Questions res) {
      list.add(res.score);
    });

    //  请求提交评价接口
    await mainModel.submitStudentEvaluation(result.id, result.content, list, new List());
    //  重新请求评价列表接口
    await mainModel.getStudentEvaluation(result.schoolCourseScheduleId);
    studentEvaluation = mainModel.studentEvaluation;

    sectionList.forEach((e) {
      e.setSectionExpanded(false);
    });

    setState(() {});
  }

  //  保存
  saveResult(Results result) {
    if (result.evaluateDatetime == null) {
      storage.setItem('evaluation', {result.id.toString(): result});
      showToast('保存成功');

      sectionList.forEach((e) {
        e.setSectionExpanded(false);
      });
    } else {
      showToast('您已评价过了，无法保存~');
    }

    setState(() {});
  }

  //  加载列表
  static List<ListSection> getExampleSections(List<Results> results) {
    var sections = List<ListSection>();
    for (int i = 0; i < results.length; i++) {
      Results item = results[i];
      var section = ListSection()
        ..header = item.studentName
        ..items = List.generate(item.questions.length, (index) => item.questions[index].content)
        ..expanded = false;
      sections.add(section);
    }
    return sections;
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);

    DateModel date = mainModel.currentDateModel;
    TextStyle selectFont = TextStyle(color: Color(0xff29D9D6), fontSize: ScreenUtil().setSp(32));
    String _courseName = this.courseName;

    //  获取学生评价数据
    if (studentEvaluation == null && mainModel.studentEvaluation != null) {
      studentEvaluation = mainModel.studentEvaluation;

      //  这里查找本地缓存有没有临时保存的评价
      studentEvaluation.results = studentEvaluation.results.map((result) {
        String key = result.id.toString();

        /// 所有学生评价数据，判断未提交过，
        /// storage不为NULL
        /// storage有对应的评价id，取保存的值
        if (result.evaluateDatetime == null &&
            storage.getItem('evaluation') != null &&
            storage.getItem('evaluation').containsKey(key)) {
          Results data = Results.fromJson(storage.getItem('evaluation')[key]);

          result = data;
        }

        return result;
      }).toList();

      sectionList = getExampleSections(studentEvaluation.results);
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              child: Container(
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: Color(0xff6D7993),
                  size: ScreenUtil().setWidth(80),
                ),
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(120)),
              ),
              onTap: () => {
                FlutterBoost.singleton.channel.invokeMethod('app/navBack')
              },
            ),
            Text('课堂表现', style: TextStyle(fontSize: ScreenUtil().setSp(40), color: Color(0xff6D7993))),
          ],
        ),
        elevation: 0.0,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 触摸收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
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
                    Container(
                        width: ScreenUtil().setWidth(200),
                        child: Text(_courseName ?? '', style: selectFont, overflow: TextOverflow.ellipsis,))
                  ],
                ),
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(64), right: ScreenUtil().setWidth(64)),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - ScreenUtil().setWidth(268),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverExpandableList(
                    builder: SliverExpandableChildDelegate<String, ListSection>(
                      sectionList: sectionList,
                      headerBuilder: _buildHeader,  //  头部
                      itemBuilder: (context, sectionIndex, itemIndex, index) {
                        //  问题content
                        String item = sectionList[sectionIndex].items[itemIndex];
                        //  每一位学生
                        ListSection section = sectionList[sectionIndex];
                        //  每一位学生的评价数据
                        Results result = studentEvaluation.results[sectionIndex];

                        return Container(
                          width: MediaQuery.of(context).size.width,
                          color: index % 2 == 0 ? Color(0xffF7F8F9) : Colors.white,
                          padding: EdgeInsets.only(top: ScreenUtil().setWidth(38), bottom: ScreenUtil().setWidth(20)),
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
                                        onTap: () => showCupertinoDialog(result, section),
                                      ),
                                      GestureDetector(
                                        child: Container(
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
                                        onTap: () => saveResult(result),
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
          ],
        ),
      ),
    );
  }

  //  头部
  Widget _buildHeader(BuildContext context, int sectionIndex, int index) {
    ListSection section = sectionList[sectionIndex];
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
              Container(
                  width: ScreenUtil().setWidth(360),
                  child: Text(item.studentName, style: nameFont)
              ),
              Container(
                child: Text(item.evaluateDatetime == null ? '' : '已提交', style: selectFont),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(28)),
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
          mainModel.listHeight = sectionIndex;

          setState(() {
            section.setSectionExpanded(!section.isSectionExpanded());
          });
        }
      );
  }

  //  六边形评估进度条
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

  //  七边形评估进度条
  Widget SeekbarSeven(Questions item) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(40), ScreenUtil().setWidth(40), ScreenUtil().setWidth(40), ScreenUtil().setWidth(10)),
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

//  输入框
class MyTextField extends StatefulWidget {
  MyTextField({Key key, @required this.item}):super(key:key);
  final Results item;

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField> {
  final TextEditingController _textController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = widget.item.content;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
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
          widget.item.content = value;
        });
      },
    );
  }
}

class ListSection implements ExpandableListSection<String> {
  //store expand state.
  bool expanded;
  //return item model list.
  List<String> items;

  //example header, optional
  String header;

  @override
  List<String> getItems() {
    return items;
  }

  @override
  bool isSectionExpanded() {
    return expanded;
  }

  @override
  void setSectionExpanded(bool expanded) {
    this.expanded = expanded;
  }
}