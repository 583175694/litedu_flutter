# flutter_module

A new Flutter module.

## 运行项目

混合开发项目，执行顺序

1. 下载FlutterPod到本地
2. lit、FlutterPod、flutter_module 三个文件需要在同一个目录下
3. 在lit项目的PodFile中添加  pod 'FlutterPod', :path => '../FlutterPod'， 并 pod install
4. 在flutter_module目录下执行 build-ios.sh脚本； 真机：sh build-ios.sh  模拟器：sh build-ios.hs --simulator
5. flutter项目 flutter get pub
6. ios项目 pod install 再开模拟器

## 包管理

1. flutter_boost：闲鱼开原混合应用框架
2. cupertino_icons：图标库
3. json_annotation：序列化工具（解析请求到的json）
4. json_serializable：反序列化工具
4. dio：网络请求
5. flutter_custom_dialog：flutter弹窗组件
6. sliding_up_panel：可定制的上下滑出抽屉（新日历所用到的组件，暂时没替换）
7. flutter_spinkit：进度指示器
8. sticky_and_expandable_list：吸顶、展开列表
9. oktoast：全局toast提示框
10. scoped_model：状态管理
11. provider跨组件状态共享（日历那块有用到）
12. charts_flutter：flutter统计图
13. connectivity：Flutter-手机网络状态监听
