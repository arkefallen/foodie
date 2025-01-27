import 'dart:convert';

import 'package:foodie/data/model/customer_review_model.dart';

class AddReview {
    final bool error;
    final String message;
    final List<CustomerReview> customerReviews;

    AddReview({
        required this.error,
        required this.message,
        required this.customerReviews,
    });

    factory AddReview.fromRawJson(String str) => AddReview.fromJson(json.decode(str));

    factory AddReview.fromJson(Map<String, dynamic> json) => AddReview(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
    );
}