import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef TextViewCreatedCallback = void Function(TextViewController controller);

class TextView extends StatefulWidget {
  const TextView({
    Key key,
    this.onTextViewCreated,
  }) : super(key: key);

  final TextViewCreatedCallback onTextViewCreated;

  @override
  State<StatefulWidget> createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'plugins.test/view',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return Text(
        '$defaultTargetPlatform is not yet supported by the text_view plugin');
  }

  void _onPlatformViewCreated(int id) {
    if (widget.onTextViewCreated == null) {
      return;
    }
    widget.onTextViewCreated(TextViewController._(id));
  }
}

class TextViewController {
  TextViewController._(int id)
      : _channel = MethodChannel('plugins.felix.angelov/textview_$id');

  final MethodChannel _channel;

  Future<void> setText(String text) async {
    assert(text != null);
    return _channel.invokeMethod('setText', text);
  }
}


class PlatformRouteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        appBar: AppBar(title: const Text('Platform Route')),
        body:  Center(
          child: RaisedButton(
            child: const TextView(),
            onPressed: () {
              print('open second page!');
            },
          ),
        ),
      ),
    );
  }
}

class RoundSliderTrackShape extends SliderTrackShape {

  const RoundSliderTrackShape({this.disabledThumbGapWidth = 2.0, this.radius = 0});

  final double disabledThumbGapWidth;
  final double radius;

  @override
  Rect getPreferredRect({
    RenderBox parentBox,
    Offset offset = Offset.zero,
    SliderThemeData sliderTheme,
    bool isEnabled,
    bool isDiscrete,
  }) {
    final double overlayWidth = sliderTheme.overlayShape.getPreferredSize(isEnabled, isDiscrete).width;
    final double trackHeight = sliderTheme.trackHeight;
    assert(overlayWidth >= 0);
    assert(trackHeight >= 0);
    assert(parentBox.size.width >= overlayWidth);
    assert(parentBox.size.height >= trackHeight);

    final double trackLeft = offset.dx + overlayWidth / 2;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;

    final double trackWidth = parentBox.size.width - overlayWidth;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
      PaintingContext context,
      Offset offset, {
        RenderBox parentBox,
        SliderThemeData sliderTheme,
        Animation<double> enableAnimation,
        TextDirection textDirection,
        Offset thumbCenter,
        bool isDiscrete,
        bool isEnabled,
      }) {
    if (sliderTheme.trackHeight == 0) {
      return;
    }

    final ColorTween activeTrackColorTween =
    ColorTween(begin: sliderTheme.disabledActiveTrackColor, end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween =
    ColorTween(begin: sliderTheme.disabledInactiveTrackColor, end: sliderTheme.inactiveTrackColor);
    final Paint activePaint = Paint()..color = activeTrackColorTween.evaluate(enableAnimation);
    final Paint inactivePaint = Paint()..color = inactiveTrackColorTween.evaluate(enableAnimation);
    Paint leftTrackPaint;
    Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    double horizontalAdjustment = 0.0;
    if (!isEnabled) {
      final double disabledThumbRadius =
          sliderTheme.thumbShape.getPreferredSize(false, isDiscrete).width / 2.0;
      final double gap = disabledThumbGapWidth * (1.0 - enableAnimation.value);
      horizontalAdjustment = disabledThumbRadius + gap;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    //进度条两头圆角
    final RRect leftTrackSegment = RRect.fromLTRBR(trackRect.left, trackRect.top,
        thumbCenter.dx - horizontalAdjustment, trackRect.bottom, Radius.circular(radius));
    context.canvas.drawRRect(leftTrackSegment, leftTrackPaint);
    final RRect rightTrackSegment = RRect.fromLTRBR(thumbCenter.dx + horizontalAdjustment, trackRect.top,
        trackRect.right, trackRect.bottom, Radius.circular(radius));
    context.canvas.drawRRect(rightTrackSegment, rightTrackPaint);
  }
}

class EmbeddedFirstRouteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmbeddedFirstRouteWidgetState();
}

class _EmbeddedFirstRouteWidgetState extends State<EmbeddedFirstRouteWidget> {
  double value = 0.0;
  @override
  Widget build(BuildContext context) {
    print('_EmbededFirstRouteWidgetState build called!');
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child:  SliderTheme( //自定义风格
            data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.pink, //进度条滑块左边颜色
                inactiveTrackColor: Colors.blue, //进度条滑块右边颜色
                trackShape: RoundSliderTrackShape(radius: 10),//进度条形状,这边自定义两头显示圆角
                thumbColor: Colors.yellow, //滑块颜色
                overlayColor: Colors.green, //滑块拖拽时外圈的颜色
                overlayShape: RoundSliderOverlayShape(//可继承SliderComponentShape自定义形状
                  overlayRadius: 25, //滑块外圈大小
                ),
                thumbShape: RoundSliderThumbShape(//可继承SliderComponentShape自定义形状
                  disabledThumbRadius: 15, //禁用是滑块大小
                  enabledThumbRadius: 15, //滑块大小
                ),
                inactiveTickMarkColor: Colors.black,
                tickMarkShape: RoundSliderTickMarkShape(//继承SliderTickMarkShape可自定义刻度形状
                  tickMarkRadius: 4.0,//刻度大小
                ),
                showValueIndicator: ShowValueIndicator.onlyForDiscrete,//气泡显示的形式
                valueIndicatorColor: Colors.red,//气泡颜色
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),//气泡形状
                valueIndicatorTextStyle: TextStyle(color: Colors.black),//气泡里值的风格
                trackHeight: 10 //进度条宽度
            ),
            child: Slider(
              value: value,
              onChanged: (v) {
                setState(() => value = v);
              },
              label: "气泡:$value",//气泡的值
              divisions: 10, //进度条上显示多少个刻度点
              max: 100,
              min: 0,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('[XDEBUG]:_EmbededFirstRouteWidgetState disposing~');
    super.dispose();
  }
}