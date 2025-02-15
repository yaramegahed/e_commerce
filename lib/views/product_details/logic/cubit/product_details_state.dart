part of 'product_details_cubit.dart';

@immutable
abstract class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}
final class GetRateLoadingState extends ProductDetailsState {}
final class GetRateSuccessState extends ProductDetailsState {}
final class GetRateErrorState extends ProductDetailsState {}

final class PatchRateLoadingState extends ProductDetailsState {}
final class PatchRateSuccessState extends ProductDetailsState {}
final class PatchRateErrorState extends ProductDetailsState {}

final class PostCommentLoadingState extends ProductDetailsState {}
final class PostCommentSuccessState extends ProductDetailsState {}
final class PostCommentErrorState extends ProductDetailsState {}

final class GetCommentLoadingState extends ProductDetailsState {}
final class GetCommentSuccessState extends ProductDetailsState {}
final class GetCommentErrorState extends ProductDetailsState {}
