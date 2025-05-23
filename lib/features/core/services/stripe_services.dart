import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hero_anim/common/utils/consts.dart';

class StripeService {
  StripeService._(); //private constructor

  static final StripeService instance = StripeService._();

  Future<void> makePayment({
    required String currency,
    required double amount,
    required String description,
  }) async {
    try {
      if (amount <= 0) {
        throw Exception('Invalid payment amount');
      }

      String? paymentIntentClientSecret = await _createPaymentIntent(
        amount: amount,
        currency: currency,
      );

      if (paymentIntentClientSecret == null) {
        throw Exception('Failed to create PaymentIntent');
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: "D's Travel",
          paymentIntentClientSecret: paymentIntentClientSecret,
          style: ThemeMode.system,
        ),
      );

      await _processPayment();
    } catch (e) {
      debugPrint('Payment error: $e');
      rethrow;
    }
  }

  Future<String?> _createPaymentIntent({
    required double amount,
    required String currency,
  }) async {
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

      if (response.statusCode != 200) {
        throw Exception('Failed to create payment intent: ${response.statusMessage}');
      }

      if (response.data != null && response.data.containsKey('client_secret')) {
        return response.data['client_secret'];
      }
      
      throw Exception('Invalid response from Stripe API');
    } catch (e) {
      debugPrint('Error creating PaymentIntent: $e');
      rethrow;
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      debugPrint('Error processing payment: $e');
      rethrow;
    }
  }

  String _calculateAmount(double amount) {
    // Convert amount to cents and ensure it's a whole number
    return (amount * 100).round().toString();
  }
}
