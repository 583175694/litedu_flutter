/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/expansion_tile.dart';
import 'package:flutter_module/components/screen_fit.dart';

class Item {
  Item({
         this.expandedValue,
         this.headerValue,
         this.isExpanded = false,
       });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class EvaluationReportPage extends StatefulWidget {
  @override
  EvaluationReportPageState createState() => EvaluationReportPageState();
}

class EvaluationReportPageState extends State<EvaluationReportPage> {
  List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1624)
      ..init(context);
    TextStyle fontTitle = TextStyle(fontSize: ScreenUtil().setSp(40), color: Colors.white);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('2019下学期', style: fontTitle),
            Container(
              child: Image.asset('lib/assets/icon_updown.png',
                width: ScreenUtil().setWidth(16),
                height: ScreenUtil().setWidth(32),
                fit: BoxFit.contain,
              ),
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(26)),
            )
          ],
        ),
        backgroundColor: Color(0xff29D9D6),
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xff29D9D6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(686),
              height: ScreenUtil().setWidth(192),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(144),
                          height: ScreenUtil().setWidth(144),
                          decoration: BoxDecoration(
                            color: Color(0xffBEF3F2),
                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(72)))
                          ),
                        ),
                        Positioned(
                          top: ScreenUtil().setWidth(8),
                          left: ScreenUtil().setWidth(8),
                          child: Container(
                            width: ScreenUtil().setWidth(128),
                            height: ScreenUtil().setWidth(128),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('lib/assets/avatar.JPG'),
                                    fit: BoxFit.contain
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(64)))
                            ),
                          ),
                        ),
                        Positioned(
                          top: ScreenUtil().setWidth(0.0),
                          right: ScreenUtil().setWidth(-3.0),
                          width: ScreenUtil().setWidth(52),
                          height: ScreenUtil().setWidth(52),
                          child: Image.asset('lib/assets/icon_sex_girl.png')
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(32)),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('李丁丁', style: TextStyle(color: Color(0xff6D7993), fontSize: ScreenUtil().setSp(40)),),
                        Container(
                          child: Text('深圳小学 | 01133973', style: TextStyle(color: Color(0xffB6BCC9), fontSize: ScreenUtil().setSp(28)),),
                          margin: EdgeInsets.only(top: ScreenUtil().setWidth(8)),
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(28)),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16)
                ),
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(686),
              height: 1.0,
              color: Color(0xffF0F1F4),
            ),

            //  报告
            Container(
              width: ScreenUtil().setWidth(686),
              height: ScreenUtil().setHeight(1136),
              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(32)),
              child: ExpansionTileSample(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)
                ),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle: Text('To delete this panel, tap the trash can icon '),
              trailing: Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}