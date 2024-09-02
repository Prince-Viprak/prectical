import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prectical/practical2/api_controller.dart';
import 'package:prectical/practical2/page/add_cartView.dart';
import 'package:prectical/practical2/page/product_detailView.dart';

class ApiDemo extends StatefulWidget {
  const ApiDemo({super.key});

  @override
  State<ApiDemo> createState() => _ApiDemoState();
}

class _ApiDemoState extends State<ApiDemo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<ApiController>().getProductData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Product List',
            style: TextStyle(
                color: Colors.black,
                fontSize: Get.width / 15,
                fontWeight: FontWeight.w500)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(onTap: () {
              Get.to(const CartView());
            },
              child: Icon(Icons.add_shopping_cart_outlined,
                  size: Get.width / 15, color: Colors.black),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(child: GetBuilder<ApiController>(builder: (controller) {
        return controller.productList.isEmpty
            ? const Center(
                child: Text('Loading...'),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(onTap: () {
                      Get.to(ProductDetailView(index: index));
                    },
                      child: SizedBox(
                        height: Get.height / 7,
                        child: Row(
                          children: [
                            Image.network(controller.productList[index].image,
                                height: Get.height / 7,
                                width: Get.height / 7,
                                fit: BoxFit.fill),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: Get.width / 1.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    maxLines: 2,
                                    textAlign: TextAlign.justify,
                                    controller.productList[index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: Get.width / 25),
                                  ),
                                  Text(
                                    maxLines: 2,
                                    textAlign: TextAlign.justify,
                                    controller.productList[index].description,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade700,
                                        fontSize: Get.width / 30),
                                  ),
                                  const Spacer(),
                                  Text(
                                    maxLines: 2,
                                    textAlign: TextAlign.justify,
                                    controller.productList[index].price
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: Get.width / 25),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                padding: const EdgeInsets.all(15),
                itemCount: controller.productList.length,
              );
      })),
    );
  }
}
