part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

final class HomeInitial extends HomeState {}
final class GetDataLoadingState extends HomeState {}
final class GetDataSuccessState extends HomeState {}
final class GetDataErrorState extends HomeState {}
