import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentHandler {
  final String? payIntentId;
  final bool isError;
  final String message;

  PaymentHandler({
    this.payIntentId,
    required this.isError,
    required this.message,
  });
}

class PaymentService {
  PaymentService();

  Future<PaymentHandler> initPaymentSheet(User user, double totalAmount) async {
    try {
// 1. create payment intent on the server
      final response = await http.post(
          // sends information to the server and receives a response
          Uri.parse(
              'https://us-central1-ecommerce-flutter-ab483.cloudfunctions.net/stripePaymentIntentRequest'),
          body: {
            'email': user.email,
            'amount': (totalAmount * 100).toString(),
          });

      final jsonResponse = jsonDecode(response.body);

//2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Enable custom flow
          customFlow: true,
          // Main params
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: jsonResponse['paymentIntent'],
          // Customer keys
          customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
          customerId: jsonResponse['customer'],
          // Extra options
          testEnv: true,
          applePay: true,
          googlePay: true,
          style: ThemeMode.dark,
          merchantCountryCode: 'DE',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      return PaymentHandler(
          isError: false,
          message: "Success",
          payIntentId: jsonResponse['paymentIntent']);
    } catch (e) {
      if (e is StripeException) {
        return PaymentHandler(
            isError: true,
            message: 'Error from Stripe: ${e.error.localizedMessage}');
      } else {
        return PaymentHandler(isError: true, message: 'Error: ${e}');
      }
    }
  }
}
