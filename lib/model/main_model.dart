import 'package:flutter_module/plugins/http.dart';
/**
 * @ClassName main_model
 * @Author wushaohang
 * @Date 2020/6/2
 **/
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_common_utils/http/http_manager.dart';
import 'package:flutter_common_utils/http/http_error.dart';
import 'package:dio/dio.dart';

import 'calendar_model.dart';

class MainModel extends Model with CalendarModel {
// GET 请求
// 返回的结果直接就是 json 格式
// 要使用 await，必须在方法名后面加上 async
  handleGetShelf() async {
    var result = await HttpUtils.request('/sell/buyer/product/list', method: HttpUtils.GET, data: {
      'id': 1,
    });
  }

// POST 请求
  handleAddShelf() async {
    var result = await HttpUtils.request('/gysw/shelf', method: HttpUtils.POST, data: {
      'id': 1,
    });
  }

// PUT 请求
  handleEditShelf() async {
    var result = await HttpUtils.request('/gysw/shelf/:id', method: HttpUtils.PUT, data: {
      'id': 1,
    });
  }

// DELETE 请求
  handleDelShelf() async {
    var result = await HttpUtils.request('/gysw/shelf/:id', method: HttpUtils.DELETE, data: {
      'id': 1,
    });
  }

  MainModel of(context) => ScopedModel.of(context);
}
