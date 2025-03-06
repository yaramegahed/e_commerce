part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

final class HomeInitial extends HomeState {}
final class GetDataLoadingState extends HomeState {}
final class GetDataSuccessState extends HomeState {}
final class GetDataErrorState extends HomeState {}

final class AddToFavLoadingState extends HomeState {}
final class AddToFavSuccessState extends HomeState {}
final class AddToFavErrorState extends HomeState {}

final class RemoveFavLoadingState extends HomeState {}
final class RemoveFavSuccessState extends HomeState {}
final class RemoveFavErrorState extends HomeState {}

final class BuyLoadingState extends HomeState {}
final class BuySuccessState extends HomeState {}
final class BuyErrorState extends HomeState {}
