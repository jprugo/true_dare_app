import 'package:flutter/material.dart';

class DiagonalClipper extends CustomClipper<Path> {
  final bool isTop;

  final double clipHeightRatio;
  double _higherEnding;
  double _lowerEnding;

  DiagonalClipper({this.isTop,this.clipHeightRatio = 0.5}){
    this._higherEnding = clipHeightRatio + 0.1;
    this._lowerEnding = clipHeightRatio - 0.1;
  }

  _getClipTop(Size size) {
    var path = Path();

    path.moveTo(0.0, size.height);
    path.lineTo(0.0, size.height * _higherEnding);
    path.lineTo(size.width, size.height * _lowerEnding);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);

    path.close();
    return path;
  }

  _getClipBottom(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height * _higherEnding);
    path.lineTo(size.width, size.height * _lowerEnding);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(DiagonalClipper oldClipper) => false;

  @override
  Path getClip(Size size) {
    if (this.isTop) {
      return _getClipBottom(size);
    } else {
      return _getClipTop(size);
    }
  }
}