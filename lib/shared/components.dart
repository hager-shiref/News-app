import 'package:flutter/material.dart';
import 'package:news_app/shared/web_view.dart';

Widget buildArticleItem(list, context) => InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebViewScreen(
            url: list['url'],
          );
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: list['urlToImage'] != null
                        ? NetworkImage('${list['urlToImage']}')
                        : const NetworkImage(
                            'https://play-lh.googleusercontent.com/pHkMbBQj7MnKj7SYhVMan82alGvqDODnzO_sEeDiM91UfH4_mc05KtcXA4_ujSe-ag=s180-rw'),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: SizedBox(
              height: 120.0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text("${list['title']} ",
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      "${list['publishedAt']}",
                      style: const TextStyle(color: Colors.grey),
                    )
                  ]),
            ),
          )
        ]),
      ),
    );
//=======================================================================================================================================================
Widget myDivider() => Container(
      margin: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );
//=======================================================================================================================================================

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function onChanged,
  required final validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      onChanged: (value) {
        onChanged(value);
      },
      controller: controller,
      keyboardType: type,
      enabled: isClickable,
       validator: validate,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[100],
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );
//=======================================================================================================================================================
