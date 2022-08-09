import 'package:agence/home/cubitHome/cupit_home.dart';
import 'package:agence/home/search.dart';
import 'package:agence/modeles/categoriesmodel.dart';
import 'package:agence/modeles/homemodeles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cubitHome/homeStates.dart';

class Offers extends StatelessWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CupitHome, ShopeHomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
            appBar: AppBar(
              elevation: 10,
              title: Text(
                'Offers',
                style: Theme.of(context).textTheme.headline4,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Search()));
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                    ))
              ],
            ),
            body: ConditionalBuilder(
              builder: (BuildContext context) {
                return ProductBuilder(CupitHome.get(context).homeModel!,
                    CupitHome.get(context).categoriesModel!, context);
              },
              condition: CupitHome.get(context).homeModel != null &&
                  CupitHome.get(context).categoriesModel != null &&
                  CupitHome.get(context).favorites.isNotEmpty,
              fallback: (BuildContext context) {
                return const Center(child: CircularProgressIndicator());
              },
            ));
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

  // ListItembuilder(context) => NeumorphicButton(
  //       style: NeumorphicStyle(
  //           color:
  //               CupitHome.get(context).dartSwitch ? Colors.black : Colors.white,
  //           depth: 0),
  //       onPressed: () {},
  //       child: Column(mainAxisSize: MainAxisSize.min, children: [
  //         Container(
  //           height: 150,
  //           width: double.infinity,
  //           decoration: const BoxDecoration(
  //             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //             image: DecorationImage(
  //                 image: AssetImage('assets/images/building.jpg'),
  //                 fit: BoxFit.cover),
  //           ),
  //         ),
  //         Container(
  //           decoration: BoxDecoration(
  //             color: CupitHome.get(context).dartSwitch
  //                 ? Colors.black
  //                 : Colors.white,
  //           ),
  //           child:
  //               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             Text(
  //               "\$245.00",
  //               style: Theme.of(context).textTheme.headline4?.copyWith(
  //                     fontSize: 32,
  //                   ),
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             Text(
  //               '730 Columbus Ave, Manhattan, \n Ny 10025',
  //               style: Theme.of(context).textTheme.bodyText2,
  //               maxLines: 2,
  //               overflow: TextOverflow.ellipsis,
  //             )
  //           ]),
  //           height: 100,
  //           width: double.infinity,
  //         )
  //       ]),
  //     );

  Widget ProductBuilder(
      HomeModel model, CategoriesModel modelCategories, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.data?.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image),
                        width: 400,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                initialPage: 0,
                viewportFraction: 1.0,
              )),
          // CarouselSlider.builder(
          //     itemCount: model.data?.banners.length,
          //     itemBuilder: (context, index, p) => Image(
          //           image: NetworkImage(model.data!.banners[index].image),
          //           fit: BoxFit.cover,
          //           width: 400,
          //         ),
          //     options: CarouselOptions(
          //         autoPlay: true, initialPage: 0, viewportFraction: 1.0)),

          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          CateforiesProducts(modelCategories.data.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 5,
                          ),
                      itemCount: modelCategories.data.data.length),
                )
              ],
            ),
          ),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: 1 / 1.65,
            children: List.generate(
                model.data!.products.length,
                (index) =>
                    ItemProductGrid(model.data!.products[index], context)),
          )
        ],
      ),
    );
  }

  Widget CateforiesProducts(DataModel model) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
            child: Text(
              model.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            width: 100,
            color: Colors.black,
          )
        ],
      );

  Widget ItemProductGrid(ProductModel model, context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: AlignmentDirectional.bottomStart, children: [
            Image(
              image: NetworkImage(
                model.image,
              ),
              width: double.infinity,
              height: 200,
            ),
            if (model.discount != 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              )
          ]),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      '${model.price}\$',
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice}\$',
                        style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor:
                          CupitHome.get(context).favorites[model.id]!
                              ? Colors.red
                              : Colors.grey,
                      child: IconButton(
                        onPressed: () {
                          print(model.id);
                          CupitHome.get(context).changeFavorites(model.id);
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(0),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      );
}
