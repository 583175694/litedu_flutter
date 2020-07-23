/**
 * @ClassName 学生数据
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/entity/student_archive.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_module/model/main_model.dart';

class StudentData extends StatefulWidget {
  @override
  StudentDataState createState() => StudentDataState();
}

class StudentDataState extends State<StudentData> {

  Basics basics = Basics(0, 0, 0, '');

  @override
  Widget build(BuildContext context) {
    final mainModel = ScopedModel.of<MainModel>(context, rebuildOnChange: true);
    TextStyle fontTitle = TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xff6D7993));
    TextStyle fontValue = TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xff29D9D6));

    basics = mainModel.studentArchive == null ? Basics(0, 0, 0, '') : mainModel.studentArchive.basics;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil().setWidth(348),
      child: Stack(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(348),
            height: ScreenUtil().setWidth(348),
            child: Image.asset('lib/assets/img_litedu.png'),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(202)),
          ),
          Positioned(
            top: 0,
            left: ScreenUtil().setWidth(502),
            child: Row(
              children: <Widget>[
                Text('身高：', style: fontTitle),
                Text('${basics.height}cm', style: fontValue),
              ],
            ),
          ),
          Positioned(
            top: ScreenUtil().setWidth(142),
            left: ScreenUtil().setWidth(24),
            child: Row(
              children: <Widget>[
                Text('体重：', style: fontTitle),
                Text('${basics.weight}kg', style: fontValue),
              ],
            ),
          ),
          Positioned(
            top: ScreenUtil().setWidth(314),
            left: ScreenUtil().setWidth(496),
            child: Row(
              children: <Widget>[
                Text('脚掌：', style: fontTitle),
                Text('${basics.soles}cm', style: fontValue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}