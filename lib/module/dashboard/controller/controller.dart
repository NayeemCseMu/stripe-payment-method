import 'package:get/get.dart';
import 'package:payment_method_stripe/service/payment_service.dart';

class Controller extends GetxController {
  var isLoading = false.obs;
  var paymentResponse = "".obs;

  Future<TransactionResponse> paymentController() async {
    try {
      isLoading(true);
      final response = await PaymentService.instance
          .payWithNewCard(amount: '15000', currency: 'usd');

      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    } finally {
      isLoading(false);
    }
  }
}
