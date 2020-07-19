/**
 * @ClassName list_demo
 * @Author wushaohang
 * @Date 2020/6/16
 **/

import 'package:flutter/material.dart';
import 'package:flutter_module/components/screen_fit.dart';
import 'package:flutter_module/components/student_portraits.dart';
import 'package:flutter_module/entity/student_evaluation_stages.dart';
import 'package:flutter_module/main.dart';
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
  List<Results> stagesList = new List();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);

    stagesList = mainModel.studentEvaluationStages == null ? new List() : mainModel.studentEvaluationStages.results;
    print(stagesList.length);

    return ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
//              Positioned(
//                top: ScreenUtil().setWidth(32),
//                left: ScreenUtil().setWidth(32),
//                width: ScreenUtil().setWidth(152),
//                height: ScreenUtil().setWidth(56),
//                child: Container(
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Image.asset('lib/assets/icon_switch1.png',
//                        width: ScreenUtil().setWidth(36),
//                        height: ScreenUtil().setWidth(20),
//                      ),
//                      Container(
//                        child: Text('切换', style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Colors.white),),
//                        margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
//                      ),
//                    ],
//                  ),
//                  decoration: BoxDecoration(
//                      color: Color(0xff29D9D6),
//                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(28)))
//                  ),
//                ),
//              ),
              Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setWidth(64)),
                  child: StudentPortraits(origin: 'evaluationReport',)
              )
            ],
          ),
          AppExpansionTile(
              title: Row(
                children: <Widget>[
                  //  原点
                  Container(
                    width: ScreenUtil().setWidth(8),
                    height: ScreenUtil().setWidth(56),
                    decoration: BoxDecoration(
                        color: Color(0xff29D9D6),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8))
                    ),
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(40), left: ScreenUtil().setWidth(0)),
                  ),
                  Text('阶段性评估', style: TextStyle(fontSize: ScreenUtil().setSp(32), color: Color(0xff6D7993))),
                ],
              ),
              children: _itemList(),
              initiallyExpanded: true
          )
        ],
    );
  }


  List<Widget> _itemList() {
    List<Widget> tiles = [];

    for(int i = 0; i < stagesList.length; i ++) {
      Results item = stagesList[i];
      tiles.add(
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(32), bottom: ScreenUtil().setWidth(40), left: ScreenUtil().setWidth(48), right: ScreenUtil().setWidth(48)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(item.evaluationType ?? '', style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xff6D7993)),),
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(20)),
              ),
              Container(
                  child: Text(item.content, style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Color(0xff6D7993)),)
              ),
//              Offstage(
//                offstage: list[i]['level'] == null,
//                child: Container(
//                    child: Row(
//                      children: <Widget>[
//                        Container(
//                          width: ScreenUtil().setWidth(64),
//                          height: ScreenUtil().setWidth(64),
//                          child: Image.asset(list[i]['level'] == Level.gold ? 'lib/assets/medal_gold.png' : list[i]['level'] == Level.silver ? 'lib/assets/medal_silver.png' : 'lib/assets/medal_cuprum.png'),
//                          margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
//                        ),
//                        Text(list[i]['level'] == Level.gold ? '优秀' : list[i]['level'] == Level.silver ? '良好' : '合格', style: TextStyle(fontSize: ScreenUtil().setSp(32), color: Color(0xff29D9D6)),)
//                      ],
//                    ),
//                  margin: EdgeInsets.only(top: ScreenUtil().setWidth(28), left: ScreenUtil().setWidth(434)),
//                ),
//              ),
            ],
          ),
          color: Color(0xffF7F8F9),
        )
      );
    }
    return tiles;
  }
}