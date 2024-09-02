import 'dart:math';
import 'package:flutter/material.dart';

/*class ShapeScreen extends StatefulWidget {
  const ShapeScreen({super.key});

  @override
  State<ShapeScreen> createState() => _ShapeScreenState();
}

class _ShapeScreenState extends State<ShapeScreen> {
  int index = 0;
  List<ShapeModel> shapeList = [];

  addShape()
  {
    var rng = Random();
    double x=0;
    double y=0;
    bool isPositive=false;
    Alignment align=const Alignment(0,0);
    ShapeModel shapeModel;

    ///x scale
    isPositive = rng.nextBool();
    x = isPositive?rng.nextDouble():(-rng.nextDouble());




    ///y scale
    isPositive = rng.nextBool();
    y = isPositive?rng.nextDouble():(-rng.nextDouble());


    align=Alignment(x, y);
    shapeModel=ShapeModel(shapeIndex: index, align: align);
    for(ShapeModel data in shapeList)
    {
      RenderBox box1 = data.widgetKey.currentContext!.findRenderObject() as RenderBox;
      RenderBox box2 = shapeModel.widgetKey.currentContext!.findRenderObject() as RenderBox;
      final size1 = box1.size;
      final size2 = box2.size;
      final position1 = box1.localToGlobal(Offset.zero);
      final position2=box2.localToGlobal(Offset.zero);
      final collide = (position1.dx < position2.dx + size2.width &&
          position1.dx + size1.width > position2.dx &&
          position1.dy < position2.dy + size2.height &&
          position1.dy + size1.height > position2.dy);
      if(collide)
        {
          addShape();
          break;
        }
    }
    shapeList.add(shapeModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: FloatingActionButton(onPressed: () {
      shapeList.clear();
      setState(() {

      });
    },child: const Icon(Icons.refresh)),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.square, size: 25, color: Colors.red),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.circle, size: 25, color: Colors.green),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.square_foot, size: 25, color: Colors.yellow),
                label: ''),
          ],
          onTap: (value) {
            index = value;
            addShape();
            setState(() {});
          },
          backgroundColor: Colors.grey,
          currentIndex: index,
          iconSize: 20),
      body: SafeArea(
        child: Stack(
            children: shapeList
                .map((e) => Align(
                    alignment: e.align,
                    child: GestureDetector(
                      onTap: () {
                        if (e.shapeIndex == 2) {
                          e.shapeIndex = 1;
                        } else if (e.shapeIndex == 1) {
                          e.shapeIndex = 0;
                        } else {
                          shapeList.remove(e);
                        }
                        setState(() {});
                      },
                      child: Icon(
                          e.shapeIndex == 0
                              ? Icons.rectangle
                              : e.shapeIndex == 1
                                  ? Icons.circle
                                  : Icons.square_foot,
                          size: 40,key: e.widgetKey,
                          color: e.shapeIndex == 0
                              ? Colors.red
                              : e.shapeIndex == 1
                                  ? Colors.green
                                  : Colors.yellow),
                    )))
                .toList()),
      ),
    );
  }
  */ /*final containerKey1 = GlobalKey();
  final containerKey2 = GlobalKey();

  Alignment box2Align = Alignment.topRight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                key: containerKey1,
                color: Colors.pink,
                width: 100.0,
                height: 100.0,
              ),
            ),
            Align(
              alignment: box2Align,
              child: Transform.translate(
                offset: const Offset(10.0, 10.0),
                child: Container(
                  key: containerKey2,
                  color: Colors.purple.withOpacity(0.75),
                  width: 100.0,
                  height: 100.0,
                ),
              ),
            ),
            // Buttons
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  child: Text('Move containers'),
                  onPressed: () => setState(() {
                    if (box2Align == Alignment.topRight)
                      box2Align = Alignment.topLeft;
                    else
                      box2Align = Alignment.topRight;
                  }),
                ),
                ElevatedButton(
                  child: Text('Check if boxesCollide'),
                  onPressed: _onCheckTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onCheckTap() {
    RenderBox? box1 = containerKey1.currentContext!.findRenderObject() as RenderBox?;
    RenderBox? box2 = containerKey2.currentContext!.findRenderObject() as RenderBox?;

    final size1 = box1!.size;
    final size2 = box2!.size;

    final position1 = box1.localToGlobal(Offset.zero);
    final position2 = box2.localToGlobal(Offset.zero);

    final collide = (position1.dx < position2.dx + size2.width &&
        position1.dx + size1.width > position2.dx &&
        position1.dy < position2.dy + size2.height &&
        position1.dy + size1.height > position2.dy);

    print('Containers collide: $collide');
  }*/ /*
}

class ShapeModel {
  int shapeIndex;
  Alignment align;
  final widgetKey=GlobalKey();

  ShapeModel(
      {required this.shapeIndex,
      required this.align});
}*/

class ShapeScreen extends StatefulWidget {
  const ShapeScreen({super.key});

  @override
  State<ShapeScreen> createState() => _ShapeScreenState();
}

class _ShapeScreenState extends State<ShapeScreen> {
  int index = 0;
  List<ShapeModel> shapeList = [];
  final double shapeSize = 40.0;

  void addShape() {
    var rng = Random();
    Alignment align;
    bool collision;
    int round = 0;

    do {
      round++;
      double x = rng.nextDouble() * 2 - 1; // Random x between -1 and 1
      double y = rng.nextDouble() * 2 - 1; // Random y between -1 and 1
      align = Alignment(x, y);
      collision = false;

      // Check collision with existing shapes
      for (ShapeModel data in shapeList) {
        if (_checkCollision(data.align, align)) {
          collision = true;
          break;
        }
      }
      if (round >= 20) {
        print('enough space=-=-');
        break;
      }
    } while (collision);

    if (!collision) {
      shapeList.add(ShapeModel(shapeIndex: index, align: align));
    }
  }

  bool _checkCollision(Alignment align1, Alignment align2) {
    final dx = (align1.x - align2.x).abs();
    final dy = (align1.y - align2.y).abs();
    return dx < 2 * shapeSize / MediaQuery.of(context).size.width &&
        dy < 2 * shapeSize / MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          shapeList.clear();
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.square, size: 25, color: Colors.red),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle, size: 25, color: Colors.green),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.square_foot, size: 25, color: Colors.yellow),
            label: '',
          ),
        ],
        onTap: (value) {
          setState(() {
            index = value;
            addShape();
          });
        },
        backgroundColor: Colors.grey,
        currentIndex: index,
        iconSize: 20,
      ),
      body: SafeArea(
        child: Stack(
          children: shapeList.map((e) {
            return Align(
              alignment: e.align,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (e.shapeIndex == 2) {
                      e.shapeIndex = 1;
                    } else if (e.shapeIndex == 1) {
                      e.shapeIndex = 0;
                    } else {
                      shapeList.remove(e);
                    }
                  });
                },
                child: Icon(
                  e.shapeIndex == 0
                      ? Icons.rectangle
                      : e.shapeIndex == 1
                          ? Icons.circle
                          : Icons.square_foot,
                  size: shapeSize,
                  color: e.shapeIndex == 0
                      ? Colors.red
                      : e.shapeIndex == 1
                          ? Colors.green
                          : Colors.yellow,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ShapeModel {
  int shapeIndex;
  Alignment align;

  ShapeModel({required this.shapeIndex, required this.align});
}
