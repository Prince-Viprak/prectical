import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prectical/practical2/api_controller.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Cart List',
            style: TextStyle(
                color: Colors.black,
                fontSize: Get.width / 15,
                fontWeight: FontWeight.w500)),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(child: GetBuilder<ApiController>(builder: (controller) {
        return controller.productList.isEmpty
            ? const Center(
          child: Text('Loading...'),
        )
            : ListView.builder(
          itemBuilder: (context, index) {
            return Visibility(visible: controller.productList[index].isAddCart,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: Get.height / 5,
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
                            const SizedBox(height: 8),
                            Container(
                              width: Get.width / 5,
                              height: Get.height / 28,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
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
                            const Spacer(),
                            Text(
                              maxLines: 2,
                              textAlign: TextAlign.justify,
                              "${controller.productList[index].price*controller.productList[index].itemCount}",
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
