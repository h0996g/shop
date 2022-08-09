import 'package:agence/modeles/favoritesModel.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cubitHome/cupit_home.dart';
import 'cubitHome/homeStates.dart';

class Faverites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CupitHome, ShopeHomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
              title: Text(
            'Favorites',
            style: Theme.of(context).textTheme.headline4,
          )),
          body: ConditionalBuilder(
            builder: (BuildContext context) {
              return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                    itemBuilder: ((context, index) => ItemFav(
                        CupitHome.get(context)
                            .favoritemodel!
                            .data!
                            .data![index]
                            .product!,
                        context)),
                    itemCount: CupitHome.get(context)
                        .favoritemodel!
                        .data!
                        .data!
                        .length,
                  ));
            },
            condition: CupitHome.get(context).favoritemodel != null &&
                state is! LodinGetFevorite,
            fallback: (BuildContext context) {
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is GoodFavoritesChangeState) {
          if (!state.model.status) {
            Fluttertoast.showToast(
                msg: CupitHome.get(context).changeFavoritesModel!.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state.model.status) {
            Fluttertoast.showToast(
                msg: CupitHome.get(context).changeFavoritesModel!.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
    );
  }
}

ItemFav(model, context, {isOldprice = true}) =>
    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // const SizedBox(
      //   width: 150,
      //   height: 150,
      //   child: Image(
      //       fit: BoxFit.cover,
      //       image: NetworkImage(
      //           'https://student.valuxapps.com/storage/uploads/products/1644374518pTaSB.10.jpg')),
      // ),

      Stack(alignment: AlignmentDirectional.bottomStart, children: [
        Container(
          height: 150,
          width: 150,
          child: Image(
            // fit: BoxFit.cover,
            image: NetworkImage(model.image!),
          ),
        ),
        if (model.discount != 0 && isOldprice)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            color: Colors.red,
            child: const Text(
              'discont',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          )
      ]),

      const SizedBox(
        width: 20,
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${model.description}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Text(
                  '${model.price}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  width: 10,
                ),
                if (model.oldPrice != model.price && isOldprice)
                  Text(
                    '${model.oldPrice}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: CupitHome.get(context).favorites[model.id]!
                      ? Colors.red
                      : Colors.grey,
                  child: IconButton(
                    onPressed: () {
                      CupitHome.get(context).changeFavorites(model.id!);
                      // CupitHome.get(context).getFAvorite();
                    },
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(0),
                  ),
                ),
              ],
            )
          ],
        ),
      )
    ]);
