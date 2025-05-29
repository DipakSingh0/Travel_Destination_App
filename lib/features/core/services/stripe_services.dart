import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:travel_ease/common/utils/consts.dart';
import 'package:travel_ease/features/core/model/destination_model.dart';

class StripeService {
  StripeService._(); //private constructor

  static final StripeService instance = StripeService._();

  Future<void> makePayment({
    required String currency,
    required Destination destination,
    // Removed 'required int amount' and 'required String description'
    // as they can be derived from the 'destination' object.
  }) async {
    try {
      final double amount = _parsePriceString(destination.price);

      if (amount <= 0) {
        throw Exception(
            'Invalid payment amount. Amount must be greater than 0.');
      }

      String? paymentIntentClientSecret = await _createPaymentIntent(
        amount: amount,
        currency: currency,
        description:
            'Booking for ${destination.name}', // Pass description from here
      );

      if (paymentIntentClientSecret == null) {
        throw Exception(
            'Failed to create PaymentIntent. Client secret is null.');
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: "D's Travel",
          paymentIntentClientSecret: paymentIntentClientSecret,
          style: ThemeMode.system,
          // Optional: You can add customer info if you have it
          // customerId: 'CUSTOMER_ID',
          // customerEphemeralKeySecret: 'EPHEMERAL_KEY',
        ),
      );

      await _processPayment();
      debugPrint('Payment successful!');
    } catch (e) {
      debugPrint('Payment error: $e');
      rethrow;
    }
  }

  Future<String?> _createPaymentIntent({
    required double amount,
    required String currency,
    String? description, // Added description parameter here
  }) async {
    try {
      final Dio dio = Dio();
      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: {
          'amount': _calculateAmount(amount), // Amount in cents
          'currency': currency,
          if (description != null)
            'description': description, // Include description if provided
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded',
          },
          validateStatus: (status) {
            return status != null && status >= 200 && status < 300;
          },
        ),
      );

      if (response.data != null && response.data.containsKey('client_secret')) {
        return response.data['client_secret'];
      }

      throw Exception(
          'Invalid response from Stripe API: missing client_secret');
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            'Dio Error creating PaymentIntent: ${e.response!.statusCode} - ${e.response!.data}');
        if (e.response!.statusCode == 401) {
          throw Exception(
              'Authentication failed for Stripe API. Check your Secret Key.');
        } else if (e.response!.statusCode == 400) {
          final String errorMessage = e.response!.data?['error']?['message'] ??
              'Bad request to Stripe API.';
          throw Exception('Bad request to Stripe API: $errorMessage');
        }
      } else {
        debugPrint('Dio Error creating PaymentIntent (no response): $e');
      }
      rethrow;
    } catch (e) {
      debugPrint('General Error creating PaymentIntent: $e');
      rethrow;
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      debugPrint('Payment Sheet presented successfully');
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        debugPrint('Payment Sheet was cancelled by the user.');
        throw Exception('Payment cancelled.');
      }
      debugPrint('Stripe Error processing payment: ${e.error.message}');
      rethrow;
    } catch (e) {
      debugPrint('General Error processing payment: $e');
      rethrow;
    }
  }

  String _calculateAmount(double amount) {
    return (amount * 100).round().toString();
  }

  double _parsePriceString(String priceString) {
    String cleanPrice = priceString.replaceAll('\$', '').replaceAll(',', '');
    return double.tryParse(cleanPrice) ?? 0.0;
  }
}
