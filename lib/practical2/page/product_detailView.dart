import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prectical/main.dart';
import 'package:prectical/practical2/api_controller.dart';
import 'package:prectical/practical2/model.dart';

class ProductDetailView extends StatelessWidget {
  final int index;

  const ProductDetailView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: GetBuilder<ApiController>(builder: (controller) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back_ios_rounded,
                            size: Get.width / 15, color: Colors.black)),
                  ),
                  SizedBox(height: Get.height / 25),
                  Image.network(controller.productList[index].image,
                      height: Get.height / 3.5,
                      width: Get.height / 3.5,
                      fit: BoxFit.contain),
                  SizedBox(height: height / 30),
                  Text(
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                    "\$${controller.productList[index].price.toString()}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: Get.width / 18),
                  ),
                  SizedBox(height: Get.height / 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.star,
                          color: Colors.yellow, size: Get.width / 18),
                      const SizedBox(width: 8),
                      Text(
                        controller.productList[index].rating.rate.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: Get.width / 22),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    controller.productList[index].title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: Get.width / 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    textAlign: TextAlign.justify,
                    controller.productList[index].description,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                        fontSize: Get.width / 30),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Get.width / 2.8,
                              height: Get.height / 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.green.shade700),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Get.find<ApiController>()
                                            .itemDecrement(index);
                                      },
                                      child: Icon(Icons.remove,
                                          color: Colors.white,
                                          size: Get.width / 20)),
                                  Text(
                                    controller.productList[index].itemCount.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: Get.width / 25),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Get.find<ApiController>()
                                            .itemIncrement(index);
                                      },
                                      child: Icon(Icons.add,
                                          color: Colors.white,
                                          size: Get.width / 20)),
                                ],
                              ),
                            ),
                            InkWell(onTap: () {
                              Get.find<ApiController>().addToCart(index);
                            },
                              child: Container(
                                width: Get.width / 2,
                                height: Get.height / 18,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.amber),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.shopping_cart,
                                        color: Colors.black, size: Get.width / 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Add to Cart',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: Get.width / 25),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              );
            },),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
