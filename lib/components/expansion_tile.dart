/**
 * @ClassName list_demo
 * @Author wushaohang
 * @Date 2020/6/16
 **/

import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/components/student_portraits.dart';
import 'package:flutter_module/plugins/app_expansion_tile.dart';

enum Level {
  gold,
  silver,
  cuprum
}

class ExpansionTileSample extends StatefulWidget {
  @override
  ExpansionTileSampleState createState() => new ExpansionTileSampleState();
}

class ExpansionTileSampleState extends State<ExpansionTileSample> {

  final GlobalKey<AppExpansionTileState> expansionTile = new GlobalKey();
  String foos = 'One';
  List list = [{
    'title': '阶段性评估',
    'item': [{
      'subtitle': '前期评估',
      'describe': '在游戏或活动时，儿童能够遵守教师或同伴所订下的活动规则，例如主动轮候、在指定范围内活动、不骚扰别人。具备良好的合作',
      'level': null
    }, {
      'subtitle': '中期评估',
      'describe': '在游戏或活动时，儿童能够遵守教师或同伴所订下的活动规则，例如主动轮候、在指定范围内活动、不骚扰别人。具备良好的合作',
      'level': null
    }, {
      'subtitle': '后期评估',
      'describe': '在游戏或活动时，儿童能够遵守教师或同伴所订下的活动规则，例如主动轮候、在指定范围内活动、不骚扰别人。具备良好的合作',
      'level': null
    }]
  }, {
    'title': '体能指标',
    'item': [{
      'subtitle': '',
      'describe': '在游戏或活动时，儿童能够遵守教师或同伴所订下的活动规则，例如主动轮候、在指定范围内活动、不骚扰别人。',
      'level': Level.gold
    }, {
      'subtitle': '',
      'describe': '在游戏或活动时，儿童能够遵守教师或同伴所订下的活动规则，例如主动轮候、在指定范围内活动、不骚扰别人。',
      'level': Level.silver
    }, {
      'subtitle': '',
      'describe': '在游戏或活动时，儿童能够遵守教师或同伴所订下的活动规则，例如主动轮候、在指定范围内活动、不骚扰别人。',
      'level': Level.cuprum
    }]
  }, {
    'title': '社交指标',
    'item': [{
      'subtitle': '',
      'describe': '在游戏或活动时，儿童能够遵守教师或同伴所订下的活动规则，例如主动轮候、在指定范围内活动、不骚扰别人。',
      'level': Level.gold
    }, {
      'subtitle': '',
      'describe': '在游戏或活动时，儿童能够遵守教师或同伴所订下的活动规则，例如主动轮候、在指定范围内活动、不骚扰别人。',
      'level': Level.silver
    }, {
      'subtitle': '',
      'describe': '在游戏或活动时，儿童能够遵守教师或同伴所订下的活动规则，例如主动轮候、在指定范围内活动、不骚扰别人。',
      'level': Level.cuprum
    }]
  }];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);

    return _reportList();
  }

  Widget _reportList() {
    List<Widget> tiles = [];
    Widget content;
    tiles.add(
      Stack(
        children: <Widget>[
          Positioned(
              top: ScreenUtil().setWidth(32),
              left: ScreenUtil().setWidth(32),
              width: ScreenUtil().setWidth(152),
              height: ScreenUtil().setWidth(56),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('lib/assets/icon_switch1.png',
                      width: ScreenUtil().setWidth(36),
                      height: ScreenUtil().setWidth(20),
                    ),
                    Container(
                      child: Text('切换', style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Colors.white),),
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xff29D9D6),
                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(28)))
                ),
              ),
          ),
          Container(
              margin: EdgeInsets.only(top: ScreenUtil().setWidth(64)),
              child: StudentPortraits()
          )
        ],
      )
    );

    for(int i = 0; i < list.length; i++) {
      tiles.add(
          AppExpansionTile(
            title: Row(
              children: <Widget>[
                //  原点
                i == 0 ? Container(
                  width: ScreenUtil().setWidth(8),
                  height: ScreenUtil().setWidth(56),
                  decoration: BoxDecoration(
                    color: Color(0xff29D9D6),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8))
                  ),
                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(40), left: ScreenUtil().setWidth(0)),
                ) : Container(
                  width: ScreenUtil().setWidth(20),
                  height: ScreenUtil().setWidth(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(20))),
                    color: Color(0xff29D9D6)
                  ),
                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(24), left: ScreenUtil().setWidth(48), ),
                ),
                Text(list[i]["title"], style: TextStyle(fontSize: ScreenUtil().setSp(32), color: Color(0xff6D7993))),
              ],
            ),
            children: _itemList(list[i]["item"]),
          )
      );
    }
    content = new ListView(
        children: tiles
    );
    return content;
  }

  List<Widget> _itemList(List list) {
    List<Widget> tiles = [];

    for(int i = 0; i < list.length; i ++) {
      tiles.add(
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(32), bottom: ScreenUtil().setWidth(40), left: ScreenUtil().setWidth(48), right: ScreenUtil().setWidth(48)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Offstage(
                offstage: list[i]['subtitle'] == '',
                child: Container(
                    child: Text(list[i]['subtitle'], style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xff6D7993)),),
                    margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(20)),
                ),
              ),
              Container(
//                  width: ScreenUtil().setWidth(562.0),
                  child: Text(list[i]['describe'], style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xff6D7993)),)
              ),
              Offstage(
                offstage: list[i]['level'] == null,
                child: Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(64),
                          height: ScreenUtil().setWidth(64),
                          child: Image.asset(list[i]['level'] == Level.gold ? 'lib/assets/medal_gold.png' : list[i]['level'] == Level.silver ? 'lib/assets/medal_silver.png' : 'lib/assets/medal_cuprum.png'),
                          margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                        ),
                        Text(list[i]['level'] == Level.gold ? '优秀' : list[i]['level'] == Level.silver ? '良好' : '合格', style: TextStyle(fontSize: ScreenUtil().setSp(32), color: Color(0xff29D9D6)),)
                      ],
                    ),
                  margin: EdgeInsets.only(top: ScreenUtil().setWidth(28), left: ScreenUtil().setWidth(434)),
                ),
              ),
            ],
          ),
          color: i % 2 == 0 ? Color(0xffF7F8F9) : Colors.white,
        )
      );
    }
    return tiles;
  }
}