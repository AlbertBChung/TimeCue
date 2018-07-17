import 'package:flutter/material.dart';
import 'package:time_cue_app/components/particle/water2.dart';
import 'dart:math';
import 'dart:async';
import 'dart:core';

class WaterController extends StatefulWidget {

  final String title;
  final int amt = 100;
  final Map grid = new Map(); //maps idx -> List<int> id of water
  final List<Positioned> particles= []; //Containers
  final double size = 30.0;


  final double screen_h = 683.0;
  final double screen_w = 411.4;
  final int gw = (411.4 / 30.0).round();
  final int gh = (683.0 / 30.0).round();


  final List<double> VXs = [];
  final List<double> VYs = [];
  final List<double> DXs = [];
  final List<double> DYs = [];


  @override
  _WaterControllerState createState() => new _WaterControllerState();
}

class _WaterControllerState extends State<WaterController> {
  List<double> Xs = [];
  List<double> Ys = [];

  @override
  void initState() {
    super.initState();
    var rng = new Random();

    for(var i = 0; i < widget.amt; i++){
      double x = rng.nextDouble()*widget.screen_w;
      Ys.add(44.0);
      Xs.add(x);
      widget.VXs.add(0.0);
      widget.VYs.add(0.0);
      widget.DXs.add(0.0);
      widget.DYs.add(0.0);

//      widget.particles.add(new Positioned( // red box
//        child: Water(width: widget.size, height: widget.size),
//        left: Xs[i],
//        top: Ys[i],
//      ));
    }

    //START RUNNING
    const oneMilli = const Duration(milliseconds:50);
    print(true ? 'a': 'b');
    new Timer.periodic(oneMilli, (Timer t) => run());


    const q = const Duration(seconds:10);
    print(true ? 'a': 'b');
    new Timer.periodic(q, (Timer t) => reset());
  }

  void reset(){
    Ys.clear();
    Xs.clear();
    widget.VXs.clear();
    widget.VYs.clear();
    widget.DXs.clear();
    widget.DYs.clear();
    var rng = new Random();
    for(var i =0; i< widget.amt; i++){
      double x = rng.nextDouble()*widget.screen_w;
      Ys.add(44.0);
      Xs.add(x);
      widget.VXs.add(0.0);
      widget.VYs.add(0.0);
      widget.DXs.add(0.0);
      widget.DYs.add(0.0);
    }
  }

  void run(){
    widget.grid.clear();
    for(var i = 0; i < widget.amt; i++){
      physics(i);
    }
    for(var j = 0; j < widget.amt; j++){
      move(j);
      print('b' + j.toString());
    }
  }

  void physics(int i){
    //accel
    widget.VYs[i] += .9;
    Xs[i] += widget.VXs[i];
    Ys[i] += widget.VYs[i];
    
    // collision
    if (Xs[i] < widget.size * .5) widget.DXs[i] += (widget.size * .5 - Xs[i]);
    else if (Xs[i] > widget.screen_w - widget.size * .5) widget.DXs[i] -= (Xs[i] - widget.screen_w + widget.size * .5);

    if (Ys[i] < widget.size * .5) widget.DYs[i] += (widget.size * .5 - Ys[i]);
    else if (Ys[i] > widget.screen_h - widget.size * .5) widget.DYs[i] -= (Ys[i] - widget.screen_h + widget.size * .5);
    else if ((Xs[i] - 200).abs() < 100 && (Ys[i] - (310 - widget.size * .5)).abs() < 20 ){
      widget.VYs[i] = -0.3;
      widget.DYs[i] = -0.3;
      Ys[i] = 300.0;
    }
    // widget.grid coordinates
    var gx = (Xs[i] / widget.size).round();
    var gy = (Ys[i] / widget.size).round();

    // neighbors constraints
    for (var ix = gx - 1; ix <= gx + 1; ix++) {
      for (var iy = gy - 1; iy <= gy + 1; iy++) {
        var g = widget.grid.containsKey(iy * widget.gw + ix) ? widget.grid[iy * widget.gw + ix]:[];
        var l = g.length;
        for (var j = 0; j < l; j++) {
          var idx = g[j];
          var dx = Xs[idx] - Xs[i];
          var dy = Ys[idx] - Ys[i];
          var d = sqrt(dx * dx + dy * dy);
          if (d < widget.size && d > 0) {
            dx = (dx / d) * (widget.size - d) * .25;
            dy = (dy / d) * (widget.size - d) * .25;
            widget.DXs[i] -= dx;
            widget.DYs[i] -= dy;
            widget.DXs[idx] += dx;
            widget.DYs[idx] += dy;
          }
        }
      }
    }
    // update neighbors array
    if (widget.grid[gy * widget.gw + gx] == null) widget.grid[gy * widget.gw + gx] = [i];
    else widget.grid[gy * widget.gw + gx].add(i);
  }

  void move(int idx){
    setState(() {
      Xs[idx] += widget.DXs[idx];
      Ys[idx] += widget.DYs[idx];
      widget.VXs[idx] += widget.DXs[idx];
      widget.VYs[idx] += widget.DXs[idx];
      widget.DXs[idx] = 0.0;
      widget.DYs[idx] = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    List<Positioned> w = [];
    for(var i = 0; i < widget.amt; i++){
      w.add(new Positioned( // red box
        child: Water(width: widget.size, height: widget.size),
        left: Xs[i],
        top: Ys[i],
      ));
    }

    return Container( // grey box
      child: Stack(
        children: w
      ),
      width: mediaQueryData.size.width,
      height: mediaQueryData.size.height,
      color: Colors.tealAccent,
    );
  }
}