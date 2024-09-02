import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prectical/practical2/api_controller.dart';
import 'package:prectical/practical2/page/product_list.dart';
import 'package:prectical/prectical1/home_screen.dart';
import 'package:prectical/shape_task.dart';

double height = 0;
double width = 0;

void main() {
  runApp(GetMaterialApp(
    //first practical
    home: HomeScreen(),
    //second practical
    // home: const ShapeScreen(),initialBinding: InitialScreenBindings(),
  ));
}

