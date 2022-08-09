part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class LodinSearchState extends SearchState {}

class GoodSearchState extends SearchState {}

class BadSearchState extends SearchState {}
