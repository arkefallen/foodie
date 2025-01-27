import 'package:foodie/data/model/customer_review_model.dart';

sealed class AddReviewState {}

class AddReviewInitial extends AddReviewState {}

class AddReviewLoading extends AddReviewState {}

class AddReviewSuccess extends AddReviewState {
  final List<CustomerReview> reviews;
  final String message;

  AddReviewSuccess(this.reviews, this.message);
}

class AddReviewError extends AddReviewState {
  final String error;

  AddReviewError(this.error);
}
