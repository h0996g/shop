import 'package:agence/diohelper/dio_helper.dart';
import 'package:agence/home/favorites.dart';

import 'package:agence/login/other/cachhelper.dart';
import 'package:agence/modeles/categoriesmodel.dart';
import 'package:agence/modeles/changeFavoritesModel.dart';
import 'package:agence/modeles/homemodeles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/constante.dart';
import '../categories.dart';
import '../offers.dart';
import '../setting.dart';
import 'homeStates.dart';

class CupitHome extends Cubit<ShopeHomeStates> {
  CupitHome() : super(InitialHomeState());
  List<Widget> body = [
    const Offers(),
    const AddPost(),
    Faverites(),
    const Setting(),
  ];

  static CupitHome get(context) => BlocProvider.of(context);
  int currentindex = 0;
  void changenav(value) {
    currentindex = value;
    emit(ChangeNaveIndex());
  }

  bool dartSwitch = false;
  void changeSwitch({value, darkswitchmain}) {
    if (darkswitchmain != null) {
      dartSwitch = darkswitchmain;
    } else {
      dartSwitch = value;
    }
    CachHelper.putcache(key: 'dartswitch', value: dartSwitch).then((value) {
      emit(ChangeSwitchState());
    });
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    // emit(LodinHomeState());
    DioHelper.getData(url: HOME, token: TOKEN).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel?.data?.products[0].id);

      homeModel!.data!.products.forEach(
        (element) {
          favorites.addAll({element.id: element.inFavorites});
        },
      );
      print(favorites);
      print(TOKEN);

      emit(GoodHomeDataState());
    }).catchError((error) {
      emit(BadHomeDataState());
      print(error.toString());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(url: CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // print(categoriesModel!.status);
      // print(categoriesModel!.data.currentPage);
      emit(GoodCategoriesState());
    }).catchError((e) {
      print(e);
      emit(BadCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(GoodFavoritesChangeIconState());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': '$productId'}, token: TOKEN)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      // print(changeFavoritesModel!.message);
      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      }

      emit(GoodFavoritesChangeState(changeFavoritesModel!));
    }).catchError((e) {
      favorites[productId] = !favorites[productId]!;
      emit(BadFavoritesChangeState());
      print(e.toString());
    });
  }
}
