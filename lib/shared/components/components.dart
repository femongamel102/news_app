
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItem(article,context)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: article['urlToImage'] != null ? DecorationImage(
              image: NetworkImage(article['urlToImage']),
              fit: BoxFit.cover,
            ): const DecorationImage(image: AssetImage('assets/images/placeholder.jpg')),
        ),
      ),
      const SizedBox(width: 20,),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              Expanded(
                child: Text('${article['title']} ',style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text('${article['publishedAt']}',style: const TextStyle(
                color: Colors.grey,
              ),)
            ],
          ),
        ),
      )
    ],
  ),
);

Widget articleBuilder(list)=> ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context) =>ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context,index)=>buildArticleItem(list[index],context),
        separatorBuilder: (context,index)=> myDivider(),
        itemCount: list.length),
    fallback: (context) => const Center(child: CircularProgressIndicator()));