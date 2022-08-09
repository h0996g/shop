import 'package:agence/home/cubit_Search/cubit/search_cubit.dart';
import 'package:agence/home/favorites.dart';
import 'package:agence/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  var search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return SearchCubit();
      },
      child: BlocConsumer<SearchCubit, SearchState>(
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultForm(
                      controller: search,
                      type: TextInputType.text,
                      valid: () {},
                      lable: const Text('search'),
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(Icons.search),
                      onchange: (String? text) {
                        SearchCubit.get(context).search(text!);
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  if (state is LodinSearchState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 15,
                  ),
                  if (state is GoodSearchState)
                    Expanded(
                        child: ListView.separated(
                            itemBuilder: ((context, index) => ItemFav(
                                SearchCubit.get(context)
                                    .searchmodel!
                                    .data!
                                    .data![index],
                                context,
                                isOldprice: false)),
                            separatorBuilder: (context, indext) =>
                                SizedBox(height: 5),
                            itemCount: SearchCubit.get(context)
                                .searchmodel!
                                .data!
                                .data!
                                .length))
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
