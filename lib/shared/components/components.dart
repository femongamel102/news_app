
import 'package:flutter/material.dart';

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItem(article)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(
                    '${article['urlToImage']}'),
                fit: BoxFit.cover
            )
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
                child: Text('${article['title']} ',style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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