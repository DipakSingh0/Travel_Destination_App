import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hero_anim/common/utils/consts.dart';

class StripeService {
  StripeService._(); //private constructor

  static final StripeService instance = StripeService._();

  Future<void> makePayment(
      {required String currency,
      required double amount,
      required String description}) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(
        amount: amount,
        currency: currency,
      );

      if (paymentIntentClientSecret == null) {
        throw Exception('Failed to create PaymentIntent');
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: "Your Merchant Name",
          paymentIntentClientSecret: paymentIntentClientSecret,
        ),
      );

      await _processPayment();
    } catch (e) {
      rethrow; // Rethrow the error to be caught by the caller
    }
  }

  Future<String?> _createPaymentIntent(
      {required double amount, required String currency}) async {
    try {
      final Dio dio = Dio();
      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: {
          'amount': _calculateAmount(amount),
          'currency': currency,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.data != null && response.data.containsKey('client_secret')) {
        return response.data['client_secret'];
      }
    } catch (e) {
      print('Error creating PaymentIntent: $e');
    }
    return null;
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print('Error processing payment: $e');
      rethrow;
    }
  }

  String _calculateAmount(double amount) {
    // Assuming amount is in dollars, convert to cents
    return (amount * 100).toInt().toString();
  }
}
