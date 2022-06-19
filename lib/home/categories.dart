import 'package:agence/home/cubitHome/cupit_home.dart';
import 'package:agence/modeles/categoriesmodel.dart';
import 'package:flutter/material.dart';

class AddPost extends StatelessWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          title: Text(
            'Categories',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => CategoriesListItem(
                    CupitHome.get(context).categoriesModel!.data.data[index]),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount:
                    CupitHome.get(context).categoriesModel!.data.data.length)));
  }

  Widget CategoriesListItem(DataModel model) => Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 6,
            child: Text(
              model.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Spacer(),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              padding: const EdgeInsets.all(0),
            ),
          )
        ],
      );
}
