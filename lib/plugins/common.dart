import 'dart:ffi';

/**
 * @ClassName common
 * @Author wushaohang
 * @Date 2020/7/12
 **/

class Common {
  //  判断第几节课
  int getDuration(String start_time) {
    List dateArr = start_time.split(":");


    DateTime oldDate = new DateTime(1970, 1, 1, int.parse(dateArr[0]), int.parse(dateArr[1]), int.parse(dateArr[2]));

    //  课程列表
    List<DateTime> duration = [
      DateTime(1970, 1, 1, 7, 0, 0),
      DateTime(1970, 1, 1, 8, 0, 0),
      DateTime(1970, 1, 1, 9, 0, 0),
      DateTime(1970, 1, 1, 10, 0, 0),
      DateTime(1970, 1, 1, 11, 0, 0),
      DateTime(1970, 1, 1, 14, 0, 0),
      DateTime(1970, 1, 1, 15, 0, 0),
      DateTime(1970, 1, 1, 16, 0, 0),
      DateTime(1970, 1, 1, 17, 0, 0),
      DateTime(1970, 1, 1, 18, 0, 0)
    ];

    if (oldDate == duration[0]) {
      //  早读
      return 0;
    } else if (oldDate == duration[1]) {
      //  第一节课
      return 1;
    } else if (oldDate == duration[2]) {
      //  第二节课
      return 2;
    } else if (oldDate == duration[3]) {
      //  第三节课
      return 3;
    } else if (oldDate == duration[4]) {
      //  第四节课
      return 4;
    } else if (oldDate == duration[5]) {
      //  第五节课，跳过两个午休
      return 7;
    } else if (oldDate == duration[6]) {
      //  第六节课
      return 8;
    } else if (oldDate == duration[7]) {
      //  第七节课
      return 9;
    } else if (oldDate == duration[8]) {
      //  第八节课
      return 10;
    } else {
      return -1;
    }
  }

  //  判断七边形区间
  int getQiSkills(int score) {
    if (score > 1 && score <= 4) {
      return 1;
    } else if (score > 4 && score <= 8) {
      return 2;
    } else if (score > 8) {
      return 3;
    } else {
      return 0;
    }
  }
}