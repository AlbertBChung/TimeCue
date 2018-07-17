import 'package:flutter/material.dart';

class Water extends StatefulWidget {
  @override
  _WaterState createState() => new _WaterState();
}


class _WaterState extends State<Water> {
  double _x = 0.0;
  double _y = 0.0;
  double _vx = 0.0;
  double _vy = 0.0;
  double _ax = 0.0;
  double _ay = 0.0;
  double size = 10.0;



  void move(){

    setState(() {
      _x += _ax;
      _y += _ay;
      _vx += _ax;
      _vy += _ay;
      _ax = 0.0;
      _ay = 0.0;
    });
  }

//  void physics() {
//    //accelerations
//    _vy += .5;
//    _x += _vx;
//    _y += _vy;
//
//    // collisions
//    if (_x < _size * .5) _dx += (_size * .5 - _x);
//    else if (_x > nw - _size * .5) _dx -= (_x - nw + _size * .5);
//
//    if (_y < _size * .5) _dy += (_size * .5 - _y);
//    else if (_y > nh - _size * .5) _dy -= (_y - nh + _size * .5);
//    else if (Math.abs(_x - 200) < 20 && Math.abs(_y - (300 - _size * .5)) < 10 ){
//      _vy = -0.1;
//      _dy = -0.1;
//      _y = 300;
//    }
//    // grid coordinates
//    var gx = Math.round(_x / _size);
//    var gy = Math.round(_y / _size);
//    // neightbors constraints
//    for (var ix = gx - 1; ix <= gx + 1; ix++) {
//      for (var iy = gy - 1; iy <= gy + 1; iy++) {
//        var g = grid[iy * gw + ix] || [];
//        for (j = 0, l = g.length; j < l; j++) {
//          var that = g[j];
//          var dx = that.x - _x;
//          var dy = that.y - _y;
//          var d = Math.sqrt(dx * dx + dy * dy);
//          if (d < _size && d > 0) {
//            dx = (dx / d) * (_size - d) * .25;
//            dy = (dy / d) * (_size - d) * .25;
//            _dx -= dx;
//            _dy -= dy;
//            that.dx += dx;
//            that.dy += dy;
//          }
//        }
//      }
//    }
//    // update neighbors array
//    if (!grid[gy * gw + gx]) grid[gy * gw + gx] = [this];
//    else grid[gy * gw + gx].push(this);
//  }

  
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: [
        Positioned( // red box
          child:  Container(
            child: Text(
              "Lorem ipsum",
            ),
            decoration: BoxDecoration(
              color: Colors.red[400],
            ),
            padding: EdgeInsets.all(16.0),
          ),
          left: 44.0,
          top: 24.0,
        ),
      ],
    );
  }
}