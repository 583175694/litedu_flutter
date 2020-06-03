/**
 * @ClassName 模板
 * @Author wushaohang
 * @Date 2019-12-14
 **/
import 'package:flutter/material.dart';
import 'package:flutter_module/components/widget_spider.dart';

class StudentFile extends StatefulWidget {
  @override
  StudentFileState createState() => StudentFileState();
}

class StudentFileState extends State<StudentFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Transform.rotate(
        angle: 0.0,
        child: SpiderStatefulWidget()
      ),
    );
  }
}