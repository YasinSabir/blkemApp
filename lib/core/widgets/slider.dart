import 'package:carousel_slider/carousel_slider.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:colibri/extensions.dart';
class CustomSlider extends StatefulWidget {
  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  int _current = 0;

  var imgList=List.generate(3, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider.builder(
        itemCount: 3,
        options: CarouselOptions(
          height: 150,
          aspectRatio: 16/9,
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
         onPageChanged: (i,_){
            setState(() {
              _current=i;
            });
         }
        ),
        itemBuilder: (BuildContext context, int itemIndex) =>
            Container(
              child:            "https://images.pexels.com/photos/747964/pexels-photo-747964.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
                  .toNetWorkImage(
                  height: 150, width: double.infinity, borderRadius: 4),
            ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) =>   Container(
    width: 16.0,
    height: 2.0,
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
    decoration: BoxDecoration(
    shape: BoxShape.rectangle,
    color: _current == index
    ? AppColors.colorPrimary
        : Color.fromRGBO(0, 0, 0, 0.4)),
    )),
        ),
      
    ]);
  }
}
