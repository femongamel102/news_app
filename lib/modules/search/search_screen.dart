import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {

        var list = NewsCubit.get(context).search;

        return SafeArea(
          child: Scaffold(
            extendBody: true,
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultTextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      NewsCubit.get(context).getSearch(value);
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    labelText: 'Search',
                    prefixIcon: Icons.search,
                  ),
                ),
                Expanded(
                    child: articleBuilder(list,isSearch: true)),
              ],
            ),
          ),
        );
      },
    );
  }
}
