import 'package:agence/modeles/changeFavoritesModel.dart';

abstract class ShopeHomeStates {}

class InitialHomeState extends ShopeHomeStates {}

class ChangeNaveIndex extends ShopeHomeStates {}

class ChangeSwitchState extends ShopeHomeStates {}

class LodinHomeState extends ShopeHomeStates {}

class GoodHomeDataState extends ShopeHomeStates {}

class BadHomeDataState extends ShopeHomeStates {}

class GoodCategoriesState extends ShopeHomeStates {}

class BadCategoriesState extends ShopeHomeStates {}

class GoodFavoritesChangeState extends ShopeHomeStates {
  final ChangeFavoritesModel model;

  GoodFavoritesChangeState(this.model);
}

class GoodFavoritesChangeIconState extends ShopeHomeStates {}

class BadFavoritesChangeState extends ShopeHomeStates {}

class GoodGetFavoriteState extends ShopeHomeStates {}

class BadGetFavoriteState extends ShopeHomeStates {}

class LodinGetFevorite extends ShopeHomeStates {}

class GoodGetUserDataState extends ShopeHomeStates {}

class BadGetUserDataState extends ShopeHomeStates {}

class LodinGetUserDataState extends ShopeHomeStates {}
