// To parse this JSON data, do
//
//     final paymentCustomerCreation = paymentCustomerCreationFromJson(jsonString);

import 'dart:convert';

PaymentCustomerCreation paymentCustomerCreationFromJson(String str) =>
    PaymentCustomerCreation.fromJson(json.decode(str));

String paymentCustomerCreationToJson(PaymentCustomerCreation data) =>
    json.encode(data.toJson());

class PaymentCustomerCreation {
  PaymentCustomerCreation({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory PaymentCustomerCreation.fromJson(Map<String, dynamic> json) =>
      PaymentCustomerCreation(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
