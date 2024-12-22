import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/app/data/models/sale_model.dart';
import 'package:millsellers/app/data/models/seller_resource_model.dart';
import 'package:millsellers/utils/contants.dart';

class ApiService extends GetConnect {
    final string baseUrl = "";
    final authManager = Get.find<AuthController>();

    Future<Response> getWithToken(string endpoint) async {

        try{
            const token = await GetStorage().read('auth_token');
            if(!token){
                throw Exception("Token not found !");
            }
            const headers = {
                "Content-Type":"application/json",
                'Authorization': 'Bearer ${authManager.getToken()}',
                'Accept':'application/json'
            }
            const response = await get(url, headers: headers);
            if(response.status != 200){
                return Exception("${response.statusCode}");
            }
            return reponse
        }catch(e, t){
            throw Exception(e);
        }


        Future<List<Sale>> getSales(){
            List<Sale> sales = [];
            try{
                const response = await getWithToken('/seller/sales');
                sales = (response.body!['data'] as List).map((e)=> Sale.fromJson(e)).toList()
            }catch(e){
                throw Exception(e);
            }
        }

    }

}