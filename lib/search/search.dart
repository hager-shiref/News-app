import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/shared/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  onChanged: (String value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  label: 'Search',
                  type: TextInputType.text,
                  prefix: Icons.search,
                  controller: searchController,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return "search mustn't be empty";
                    }
                  },
                ),
              ),
              list.isNotEmpty
                  ? Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildArticleItem(list[index], context);
                          },
                          separatorBuilder: (context, index) {
                            return myDivider();
                          },
                          itemCount: list.length),
                    )
                  : Container()
            ],
          ),
        );
      },
    );
  }
}
