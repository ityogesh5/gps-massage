// To parse this JSON data, do
//
//     final paymentCustomerCharge = paymentCustomerChargeFromJson(jsonString);

import 'dart:convert';

PaymentCustomerCharge paymentCustomerChargeFromJson(String str) =>
    PaymentCustomerCharge.fromJson(json.decode(str));

String paymentCustomerChargeToJson(PaymentCustomerCharge data) =>
    json.encode(data.toJson());

class PaymentCustomerCharge {
  PaymentCustomerCharge({
    this.status,
    this.message,
    this.data,
  });

  String status;
  Message message;
  Data data;

  factory PaymentCustomerCharge.fromJson(Map<String, dynamic> json) =>
      PaymentCustomerCharge(
        status: json["status"],
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.userId,
    this.customerId,
    this.paymentId,
    this.paymentMethodTypes,
    this.cardId,
    this.receivedAmount,
    this.paymentStatus,
    this.createdUser,
    this.updatedUser,
    this.updatedAt,
    this.createdAt,
  });

  int id;
  int userId;
  String customerId;
  String paymentId;
  String paymentMethodTypes;
  String cardId;
  int receivedAmount;
  bool paymentStatus;
  String createdUser;
  String updatedUser;
  DateTime updatedAt;
  DateTime createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["userId"],
        customerId: json["customerId"],
        paymentId: json["paymentId"],
        paymentMethodTypes: json["paymentMethodTypes"],
        cardId: json["cardId"],
        receivedAmount: json["receivedAmount"],
        paymentStatus: json["paymentStatus"],
        createdUser: json["createdUser"],
        updatedUser: json["updatedUser"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "customerId": customerId,
        "paymentId": paymentId,
        "paymentMethodTypes": paymentMethodTypes,
        "cardId": cardId,
        "receivedAmount": receivedAmount,
        "paymentStatus": paymentStatus,
        "createdUser": createdUser,
        "updatedUser": updatedUser,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}

class Message {
  Message({
    this.id,
    this.object,
    this.amount,
    this.amountCapturable,
    this.amountReceived,
    this.application,
    this.applicationFeeAmount,
    this.canceledAt,
    this.cancellationReason,
    this.captureMethod,
    this.charges,
    this.clientSecret,
    this.confirmationMethod,
    this.created,
    this.currency,
    this.customer,
    this.description,
    this.invoice,
    this.lastPaymentError,
    this.livemode,
    this.metadata,
    this.nextAction,
    this.onBehalfOf,
    this.paymentMethod,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.receiptEmail,
    this.review,
    this.setupFutureUsage,
    this.shipping,
    this.source,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    this.status,
    this.transferData,
    this.transferGroup,
  });

  String id;
  String object;
  int amount;
  int amountCapturable;
  int amountReceived;
  dynamic application;
  dynamic applicationFeeAmount;
  dynamic canceledAt;
  dynamic cancellationReason;
  String captureMethod;
  Charges charges;
  String clientSecret;
  String confirmationMethod;
  int created;
  String currency;
  String customer;
  dynamic description;
  dynamic invoice;
  dynamic lastPaymentError;
  bool livemode;
  Metadata metadata;
  dynamic nextAction;
  dynamic onBehalfOf;
  String paymentMethod;
  PaymentMethodOptions paymentMethodOptions;
  List<String> paymentMethodTypes;
  String receiptEmail;
  dynamic review;
  dynamic setupFutureUsage;
  dynamic shipping;
  dynamic source;
  dynamic statementDescriptor;
  dynamic statementDescriptorSuffix;
  String status;
  dynamic transferData;
  dynamic transferGroup;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        object: json["object"],
        amount: json["amount"],
        amountCapturable: json["amount_capturable"],
        amountReceived: json["amount_received"],
        application: json["application"],
        applicationFeeAmount: json["application_fee_amount"],
        canceledAt: json["canceled_at"],
        cancellationReason: json["cancellation_reason"],
        captureMethod: json["capture_method"],
        charges: Charges.fromJson(json["charges"]),
        clientSecret: json["client_secret"],
        confirmationMethod: json["confirmation_method"],
        created: json["created"],
        currency: json["currency"],
        customer: json["customer"],
        description: json["description"],
        invoice: json["invoice"],
        lastPaymentError: json["last_payment_error"],
        livemode: json["livemode"],
        metadata: Metadata.fromJson(json["metadata"]),
        nextAction: json["next_action"],
        onBehalfOf: json["on_behalf_of"],
        paymentMethod: json["payment_method"],
        paymentMethodOptions:
            PaymentMethodOptions.fromJson(json["payment_method_options"]),
        paymentMethodTypes:
            List<String>.from(json["payment_method_types"].map((x) => x)),
        receiptEmail: json["receipt_email"],
        review: json["review"],
        setupFutureUsage: json["setup_future_usage"],
        shipping: json["shipping"],
        source: json["source"],
        statementDescriptor: json["statement_descriptor"],
        statementDescriptorSuffix: json["statement_descriptor_suffix"],
        status: json["status"],
        transferData: json["transfer_data"],
        transferGroup: json["transfer_group"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "amount": amount,
        "amount_capturable": amountCapturable,
        "amount_received": amountReceived,
        "application": application,
        "application_fee_amount": applicationFeeAmount,
        "canceled_at": canceledAt,
        "cancellation_reason": cancellationReason,
        "capture_method": captureMethod,
        "charges": charges.toJson(),
        "client_secret": clientSecret,
        "confirmation_method": confirmationMethod,
        "created": created,
        "currency": currency,
        "customer": customer,
        "description": description,
        "invoice": invoice,
        "last_payment_error": lastPaymentError,
        "livemode": livemode,
        "metadata": metadata.toJson(),
        "next_action": nextAction,
        "on_behalf_of": onBehalfOf,
        "payment_method": paymentMethod,
        "payment_method_options": paymentMethodOptions.toJson(),
        "payment_method_types":
            List<dynamic>.from(paymentMethodTypes.map((x) => x)),
        "receipt_email": receiptEmail,
        "review": review,
        "setup_future_usage": setupFutureUsage,
        "shipping": shipping,
        "source": source,
        "statement_descriptor": statementDescriptor,
        "statement_descriptor_suffix": statementDescriptorSuffix,
        "status": status,
        "transfer_data": transferData,
        "transfer_group": transferGroup,
      };
}

class Charges {
  Charges({
    this.object,
    this.data,
    this.hasMore,
    this.totalCount,
    this.url,
  });

  String object;
  List<dynamic> data;
  bool hasMore;
  int totalCount;
  String url;

  factory Charges.fromJson(Map<String, dynamic> json) => Charges(
        object: json["object"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        hasMore: json["has_more"],
        totalCount: json["total_count"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "data": List<dynamic>.from(data.map((x) => x)),
        "has_more": hasMore,
        "total_count": totalCount,
        "url": url,
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}

class PaymentMethodOptions {
  PaymentMethodOptions({
    this.card,
  });

  Card card;

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) =>
      PaymentMethodOptions(
        card: Card.fromJson(json["card"]),
      );

  Map<String, dynamic> toJson() => {
        "card": card.toJson(),
      };
}

class Card {
  Card({
    this.installments,
    this.network,
    this.requestThreeDSecure,
  });

  dynamic installments;
  dynamic network;
  String requestThreeDSecure;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        installments: json["installments"],
        network: json["network"],
        requestThreeDSecure: json["request_three_d_secure"],
      );

  Map<String, dynamic> toJson() => {
        "installments": installments,
        "network": network,
        "request_three_d_secure": requestThreeDSecure,
      };
}
