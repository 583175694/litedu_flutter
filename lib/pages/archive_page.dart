/**
 * @ClassName 学生档案
 * @Author wushaohang
 * @Date 2020-06-04
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/components/student_assessment.dart';
import 'package:flutter_module/components/student_attendance.dart';
import 'package:flutter_module/components/student_data.dart';
import 'package:flutter_module/components/student_portraits.dart';
import 'package:flutter_module/plugins/custom_underline_tab_indicator.dart';

class ArchivePage extends StatefulWidget {
  @override
  ArchivePageState createState() => ArchivePageState();
}

class ArchivePageState extends State<ArchivePage> {
  List tabs = [
    {"title": "成长档案", "icon": "lib/assets/icon_file.png"},
    {"title": "精彩瞬间", "icon": "lib/assets/icon_moment.png"},
    {"title": "亲子时光", "icon": "lib/assets/icon_family_time.png"}
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: ScreenUtil().setWidth(336.0),
                forceElevated: false,
                flexibleSpace: FlexibleSpaceBar(
                  //可以展开区域，通常是一个FlexibleSpaceBar
                  centerTitle: true,
                  background: Container(
                    child: header(),
                    margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(48.0)),
                  ),
                ),
                floating: true,
                pinned: true,
                snap: false,    // <--- this is required if I want the application bar to show when I scroll up
                bottom: PreferredSize(
                  preferredSize: Size(MediaQuery.of(context).size.width, ScreenUtil().setWidth(176.0)),
                  child: tabbar(),
                ),
                elevation: 0,
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: <Widget>[
                    //  学生数据
                    Container(
                      height: ScreenUtil().setWidth(560),
                      child: Stack(
                        children: <Widget>[
                          title('学生数据'),
                          Positioned(
                            child: StudentData(),
                            top: ScreenUtil().setWidth(152),
                          ),
                        ],
                      ),
                      color: Colors.white,
                    ),
                    //  学生评估
                    Container(
                      height: ScreenUtil().setWidth(662),
                      child: Stack(
                        children: <Widget>[
                          title('学生评估'),
                          Positioned(
                            child: StudentAssessment(),
                            top: ScreenUtil().setWidth(108),
                            left: ScreenUtil().setWidth(286),
                          ),
                          Positioned(
                            child: Text('- 最新评估 -', style: TextStyle(fontSize: ScreenUtil().setSp(22), color: Color(0xffB6BCC9))),
                            bottom: ScreenUtil().setWidth(44),
                            left: ScreenUtil().setWidth(314),
                          )
                        ],
                      ),
                      color: Colors.white,
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                    ),
                    //  学生画像
                    Container(
                      height: ScreenUtil().setWidth(662),
                      child: Stack(
                        children: <Widget>[
                          title('学生画像'),
                          Container(
                            child: StudentPortraits(),
                            margin: EdgeInsets.only(top: ScreenUtil().setWidth(126)),
                          ),
                        ],
                      ),
                      color: Colors.white,
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                    ),
                    //  学生考勤
                    Container(
                      height: ScreenUtil().setWidth(496),
                      child: Stack(
                        children: <Widget>[
                          title('考勤统计'),
                          Container(
                            child: StudentAttendance(),
                            margin: EdgeInsets.only(top: ScreenUtil().setWidth(118)),
                          ),
                        ],
                      ),
                      color: Colors.white,
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                    ),
                    //  注意事项
                    Container(
                      child: Stack(
                        children: <Widget>[
                          title('注意事项'),
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(56), top: ScreenUtil().setWidth(64)),
                              width: ScreenUtil().setWidth(622),
                              child: Text('丁丁吃海鲜会过敏哟，老师们要注意哟～', style: TextStyle(fontSize: ScreenUtil().setSp(32), color: Color(0xffB6BCC9))),
                              margin: EdgeInsets.only(top: ScreenUtil().setWidth(66)),
                            ),
                          ),
                        ],
                      ),
                      color: Colors.white,
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20), bottom: ScreenUtil().setHeight(120)),
                    ),
                  ],
                ),
              ),
              Container(),
              Container()
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize buildPreferredSize() {
    return PreferredSize(
          preferredSize: Size.fromHeight(ScreenUtil().setWidth(336)),
          child: AppBar(
            flexibleSpace: Container(
              child: header(),
              margin: EdgeInsets.only(top: ScreenUtil().setWidth(94)),
            ),
            elevation: 0,
            bottom: tabbar(),
          ),
        );
  }

  TabBar tabbar() {
    return TabBar(
      tabs: [
        for (var item in tabs) Container(
          width: ScreenUtil().setWidth(112),
          height: ScreenUtil().setWidth(132),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(48),
                height: ScreenUtil().setWidth(44),
                child: Image.asset(item["icon"]),
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(22)),
              ),
              Text(item["title"], style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xff6D7993)), softWrap: false)
            ],
          ),
        )
      ],
      indicatorColor: Color(0xff29D9D6),
      indicatorSize: TabBarIndicatorSize.label,
      indicator: CustomUnderlineTabIndicator(
        borderSide: BorderSide(width: ScreenUtil().setWidth(8), color: Color(0xff29D9D6))),
    );
  }

  Widget header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(64),
          height: ScreenUtil().setWidth(64),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/avatar.JPG'),
            ),
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(64)))
          ),
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(48)),
        ),
        Container(
          child: Text('金贝贝', style: TextStyle(fontSize: ScreenUtil().setSp(40), color: Color(0xff6D7993)),),
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(32)),
        ),
        Container(
          width: ScreenUtil().setWidth(48),
          height: ScreenUtil().setWidth(48),
          child: Center(
              child: Image.asset('lib/assets/icon_switch1.png', width: ScreenUtil().setWidth(36), height: ScreenUtil().setWidth(20))
          ),
          decoration: BoxDecoration(
              color: Color(0xffF0F1F4),
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(28)))
          ),
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
        ),
        Container(
          width: ScreenUtil().setWidth(228),
          height: ScreenUtil().setWidth(56),
          child: Center(
            child: Text("08.08 - 03.02", style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xff6D7993))),
          ),
          decoration: BoxDecoration(
              color: Color(0xffF0F1F4),
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(28)))
          ),
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(134)),
        )
      ],
    );
  }

  Container line() {
    return Container(
        height: ScreenUtil().setHeight(20),
        color: Color(0xffF0F1F4)
    );
  }

  Widget title(String arg) {
    return Positioned(
      top: ScreenUtil().setWidth(46.0),
      left: ScreenUtil().setWidth(48.0),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(8.0),
            height: ScreenUtil().setWidth(24.0),
            decoration: BoxDecoration(
              color: Color(0xffFFA938),
              borderRadius: BorderRadius.all(Radius.circular(4))
            ),
            margin: EdgeInsets.only(right: ScreenUtil().setWidth(16.0)),
          ),
          Text(arg, style: TextStyle(fontSize: ScreenUtil().setSp(32.0), color: Color(0xff6D7993)))
        ],
      ),
    );
  }
}