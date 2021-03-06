import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/entity/student_evaluation.dart';
import 'package:flutter_module/model/main_model.dart';
import 'package:flutter_module/plugins/seekbar_plugin.dart';
import 'dart:ui' as ui;
import 'package:localstorage/localstorage.dart';
import 'package:oktoast/oktoast.dart';
import 'package:scoped_model/scoped_model.dart';

import '../main.dart';

class DropdownListDemo extends StatefulWidget {
  @override
  _DropdownListDemoState createState() => _DropdownListDemoState();
}

class _DropdownListDemoState extends State<DropdownListDemo> {
  var v;
  ui.Image _image;
  ui.Image _bubble1;
  ui.Image _bubble2;
  ui.Image _bubble3;
  ui.Image _bubble4;
  List<ui.Image> _imageBubbles;
  String assessment;  //  前期评估
  //  本地存储
  final LocalStorage storage = new LocalStorage('evaluation');

  StudentEvaluation studentEvaluation;

  TextStyle nameFont = TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(32));
  TextStyle textFont = TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(28));
  TextStyle btnFont = TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(40));
  TextStyle saveFont = TextStyle(color: Color(0xff29D9D6), fontSize: ScreenUtil().setSp(40));
  TextStyle selectFont = TextStyle(color: Color(0xff29D9D6), fontSize: ScreenUtil().setSp(32));

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

  ///  提交
  void onConfirm(Results item) async {
    List<int> list = new List();
    item.questions.forEach((Questions res) {
      list.add(res.score == -1 ? 0 : res.score);
    });

    await mainModel.submitStudentEvaluation(item.id, item.content, list, new List());
    await mainModel.getStudentEvaluation(item.schoolCourseScheduleId);
    setState(() {});
  }

  //  保存
  saveResult(Results result) {
    if (result.evaluateDatetime == null) {
      storage.setItem('evaluation', {result.id.toString(): result});
      showToast('保存成功');
    } else {
      showToast('您已评价过了，无法保存~');
    }

    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final mainModel = ScopedModel.of<MainModel>(context, rebuildOnChange: true);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);

    setState(() {
      _imageBubbles = [_bubble1, _bubble2, _bubble3, _bubble4];
    });

    if (mainModel.studentEvaluation != null && mainModel.studentEvaluation != studentEvaluation) {
      studentEvaluation = mainModel.studentEvaluation;
      //  这里查找本地缓存有没有临时保存的评价
      studentEvaluation.results = studentEvaluation.results.map((result) {
        String key = result.id.toString();

        /**
         * 所有学生评价数据，判断未提交过，
         * storage不为NULL
         * storage有对应的评价id，取保存的值
         * */
        if (result.evaluateDatetime == null &&
            storage.getItem('evaluation') != null &&
            storage.getItem('evaluation').containsKey(key)) {
          Results data = Results.fromJson(storage.getItem('evaluation')[key]);

          result = data;
        }

        return result;
      }).toList();

      _loadImage('lib/assets/icon_switch.png').then((res) {
        setState(() {
          _image = res;
        });
      });
    }

    return new ListView.builder(
      itemBuilder: (context, i) => ExpansionTile(
        title: header(i),
        children: questions(i),
        initiallyExpanded: false,  //默认打开关闭
      ),
      itemCount: studentEvaluation.results.length,
    );
  }

  Widget header(i) {
    Results item = studentEvaluation.results[i];

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
                  backgroundImage: item.studentLogo == "" ? AssetImage('lib/assets/default_avatar.png') : NetworkImage(item.studentLogo)
              ),
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(28), right: ScreenUtil().setWidth(48)),
            ),
            Container(
              width: ScreenUtil().setWidth(288),
              child: Text(item.studentName, style: nameFont),
            ),
            Text(item.evaluateDatetime == null ? '' : '已提交', style: selectFont, textAlign: TextAlign.right,)
          ],
        ),
    );
  }

  List<Widget> questions(i) {
    Results item = studentEvaluation.results[i];

    return item.evaluationType == 'six' ? evaluateSix(item) : evaluateSeven(item);
  }

  List<Widget> evaluateSix(Results item) {
    return [
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
      questionList(item),
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
                child: MyTextField(item: item)
            ),
          ),
        ),
        margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(48)),
      ),  //  评语
      item.evaluateDatetime == null && item.questions.length != 0 ? Container(
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
              onTap: () => saveResult(item),
            )
          ],
        ),
        margin: EdgeInsets.only(top: ScreenUtil().setWidth(0), bottom: ScreenUtil().setWidth(80)),
      ) : Container(),  //  提交
    ];
  }

  List<Widget> evaluateSeven(Results item) {
    return [
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
            Text('周期评估', style: nameFont,)
          ],
        ),
      ),
      questionList(item),
      item.evaluateDatetime == null && item.questions.length != 0 ? Container(
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
              onTap: () => onConfirm(item),
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
              onTap: () => saveResult(item),
            ),
          ],
        ),
        margin: EdgeInsets.only(top: ScreenUtil().setWidth(48), bottom: ScreenUtil().setWidth(80)),
      ) : Container(),  //  提交
    ];
  }

  //  评价列表
  Widget questionList(Results result) {
    List<Widget> tiles = [];
    Widget content;
    for(int i = 0; i < result.questions.length; i++) {
      Questions item = result.questions[i];
      tiles.add(
        Container(
          width: MediaQuery.of(context).size.width,
          color: i % 2 == 0 ? Color(0xffF7F8F9) : Colors.white,
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(48), bottom: ScreenUtil().setWidth(20)),
          child: Column(
            children: <Widget>[
              Container(
                  width: ScreenUtil().setWidth(590),
                  child: Text(item.content, style: textFont,)
              ),
              result.evaluationType == 'six' ?
              SeekbarSix(item, result) :
              SeekbarSeven(item, result)
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

  //  前期评估
  Container SeekbarSix(Questions item, Results results) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(40), ScreenUtil().setWidth(40), ScreenUtil().setWidth(40), ScreenUtil().setWidth(40)),
              width: ScreenUtil().setWidth(528),
              child: SeekBar(
                isCanTouch: results.evaluateDatetime == null ? true : false,
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
  Widget SeekbarSeven(Questions item, Results results) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(40), ScreenUtil().setWidth(40), ScreenUtil().setWidth(40), ScreenUtil().setWidth(40)),
                width: ScreenUtil().setWidth(476),
                child: SeekBar(
                  isCanTouch: results.evaluateDatetime == null ? true : false,
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

  Image starIcon() => Image.asset('lib/assets/icon_star_evaluation.png', width: ScreenUtil().setWidth(48), height: ScreenUtil().setWidth(48),);
}


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
//          _textController.text = value;
        });
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    mainModel.studentEvaluation = null;
  }
}