import 'package:colibri/core/theme/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:colibri/extensions.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay/overlay.dart';
import 'dart:math' as math;
class StoryList extends StatefulWidget {
  @override
  _StoryListState createState() => _StoryListState();
}

class _StoryListState extends State<StoryList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      itemBuilder: (c,index){
        if(index==0)return SizedBox(
          height: 20,
          child: Column(
            children: [
              2.toSizedBox,
              CustomPaint(
                painter: DashRectPainter(color: AppColors.colorPrimary, strokeWidth: 2, gap: 2),
                child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                child: Center(
                  child: Container(
                  height: 50,
                  width: 50.toWidth,
                  color: Colors.white,
                  child: Icon(Icons.add,color: Colors.black,),
                  ),
                ),),
              ),
              2.toSizedBox,
              "New".toCaption(fontWeight: FontWeight.bold)
            ],
          ).toHorizontalPadding(16),
        );
        // return ;
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            "https://i.pravatar.cc/150?img=$index".toNetWorkImage(borderRadius: 4,width: 60).toHorizontalPadding(8),
            2.toSizedBox,
            "Name $index".toCaption(maxLines: 1,fontWeight: FontWeight.bold)
          ],
        ).toContainer().onTap(() {
          OverlayEntry(
              builder: (context) => Positioned(
                width: 80.toWidth,
                child: CompositedTransformFollower(
                  link: LayerLink(),
                  showWhenUnlinked: false,
                  offset: Offset(0.0, context.getScreenHeight + 5.0),
                  child: Material(
                    elevation: 4.0,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: <Widget>[
                        ListTile(
                          title: Text('Syria'),
                          onTap: () {
                            print('Syria Tapped');
                          },
                        ),
                        ListTile(
                          title: Text('Lebanon'),
                          onTap: () {
                            print('Lebanon Tapped');
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )
          );
          // CountriesField();
          // CustomOverlay(
          //   context: context,
          //   // overlayWidget: Container(),
          //   // Builder passes aa function removeOverlay as argument which can be used to manually remove the overlay
          //   builder: (removeOverlay) =>
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Card(
          //           child: Padding(
          //             padding: EdgeInsets.all(8),
          //             child: Column(
          //               children: <Widget>[
          //                 Text(
          //                   'This widget is passed to the overlay using the builder method so there is a close button, but you can also close this overlay by tapping anywhere in the darker areas.',
          //                 ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.end,
          //                   children: <Widget>[
          //                     FlatButton(
          //                         onPressed: removeOverlay,
          //                         child: Text('Close'))
          //                   ],
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //
          // )..buildOverlay(context);
        });
      },
      scrollDirection: Axis.horizontal,);
  }
}
class CountriesField extends StatefulWidget {
  @override
  _CountriesFieldState createState() => _CountriesFieldState();
}

class _CountriesFieldState extends State<CountriesField> {

  final FocusNode _focusNode = FocusNode();

  OverlayEntry _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {

        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this._overlayEntry);

      } else {
        this._overlayEntry.remove();
      }
    });
  }

  OverlayEntry _createOverlayEntry() {

    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;

    return OverlayEntry(
        builder: (context) => Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: this._layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height + 5.0),
            child: Material(
              elevation: 4.0,
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    title: Text('Syria'),
                    onTap: () {
                      print('Syria Tapped');
                    },
                  ),
                  ListTile(
                    title: Text('Lebanon'),
                    onTap: () {
                      print('Lebanon Tapped');
                    },
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: this._layerLink,
      child: TextFormField(
        focusNode: this._focusNode,
        decoration: InputDecoration(
            labelText: 'Country'
        ),
      ),
    );
  }
}

class DashedRect extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedRect(
      {this.color = Colors.black, this.strokeWidth = 1.0, this.gap = 5.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(strokeWidth / 2),
        child: CustomPaint(
          painter:
          DashRectPainter(color: color, strokeWidth: strokeWidth, gap: gap),
        ),
      ),
    );
  }
}

class DashRectPainter extends CustomPainter {
  double strokeWidth;
  Color color;
  double gap;

  DashRectPainter(
      {this.strokeWidth = 5.0, this.color = Colors.red, this.gap = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path _topPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(x, 0),
      gap: gap,
    );

    Path _rightPath = getDashedPath(
      a: math.Point(x, 0),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _bottomPath = getDashedPath(
      a: math.Point(0, y),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _leftPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(0.001, y),
      gap: gap,
    );

    canvas.drawPath(_topPath, dashedPaint);
    canvas.drawPath(_rightPath, dashedPaint);
    canvas.drawPath(_bottomPath, dashedPaint);
    canvas.drawPath(_leftPath, dashedPaint);
  }

  Path getDashedPath({
    @required math.Point<double> a,
    @required math.Point<double> b,
    @required gap,
  }) {
    Size size = Size(b.x - a.x, b.y - a.y);
    Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    math.Point currentPoint = math.Point(a.x, a.y);

    num radians = math.atan(size.height / size.width);

    num dx = math.cos(radians) * gap < 0
        ? math.cos(radians) * gap * -1
        : math.cos(radians) * gap;

    num dy = math.sin(radians) * gap < 0
        ? math.sin(radians) * gap * -1
        : math.sin(radians) * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw
          ? path.lineTo(currentPoint.x, currentPoint.y)
          : path.moveTo(currentPoint.x, currentPoint.y);
      shouldDraw = !shouldDraw;
      currentPoint = math.Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}