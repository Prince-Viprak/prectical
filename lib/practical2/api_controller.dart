import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prectical/practical2/model.dart';
import 'package:prectical/practical2/page/add_cartView.dart';

class ApiController extends GetxController {
  List<ProductModel> productList = [];

  getProductData() async{
    try {
      http.Response res=await http.get(Uri.parse('https://fakestoreapi.com/products/'));
      if(res.statusCode==200)
        {
          List json=jsonDecode(res.body);
          productList=json.map((e) => ProductModel.fromJson(e)).toList();
        }
    } catch (e) {
      rethrow;
    }
    update();
  }

  addToCart(int index) async{
    if(productList[index].itemCount>0)
      {
        productList[index].isAddCart=true;
        Get.off(const CartView());
      }
    else
      {
        Get.showSnackbar(const GetSnackBar(message: 'Add Quantity'));
      }
    update();
  }

  itemDecrement(int index) async{
if(productList[index].itemCount>0)
  {
    if(productList[index].itemCount==1)
      {
        productList[index].isAddCart=false;
      }
    productList[index].itemCount--;
  }
else
  {
    Get.showSnackbar(const GetSnackBar(message: 'Item quantity minus not possible!'));
  }
    update();
  }
  itemIncrement(int index) async{
    if(productList[index].itemCount==0)
    {
      productList[index].isAddCart=true;
    }
    productList[index].itemCount++;
    update();
  }
}

class InitialScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiController());
  }
}
