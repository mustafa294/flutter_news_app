import 'package:flutter/material.dart';
import 'package:flutter_news_app/constants/constants.dart';
import 'package:flutter_news_app/screens/model/article_model.dart';
import 'package:flutter_news_app/screens/views/news_description_page.dart';
import 'package:flutter_news_app/services.dart';
import 'package:transparent_image/transparent_image.dart';

class TabbarView extends StatelessWidget {
  TabbarView({
    Key? key,
    required this.client,
    required this.serviceUrl,
  }) : super(key: key);

  final ApiServices client;
  final String serviceUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 30),
      child: FutureBuilder(
        future: client.getData(serviceUrl),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasError) {
            var error = snapshot.error;
            return Center(
              child: Text("$error"),
            );
          } else if (snapshot.hasData) {
            List<Article>? articles = snapshot.data;

            return ListView.builder(
              itemCount: articles!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDescription(
                          imageUrl: articles[index].urlToImage,
                          content: articles[index].description,
                          sourceName: articles[index].source!.name,
                          title: articles[index].title,
                          url: articles[index].url,
                          publishedAt: articles[index].formattedDate,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    height: 80,
                    child: Row(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                            // image: DecorationImage(
                            //   image:
                            //       NetworkImage("${articles[index].urlToImage}"),
                            //   fit: BoxFit.fill,
                            // ),
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xff0c7bb3),
                                Color(0xfff2baeb),
                              ],
                            ),
                          ),
                          child: Hero(
                            tag: "image${articles[index].urlToImage}",
                            child: FadeInImage.memoryNetwork(
                              imageErrorBuilder:
                                  (context, exception, stackTrace) {
                                return Center(
                                  child: Text(
                                    'Image not\nfound',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                );
                              },
                              fadeInCurve: Curves.easeOutCirc,
                              fadeInDuration: Duration(seconds: 5),
                              placeholder: kTransparentImage,
                              image: articles[index].urlToImage!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                articles[index].title!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColor.darkBlueColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_view_month,
                                            color: AppColor.lightBlueColor,
                                            size: 12,
                                          ),
                                          SizedBox(width: 5),
                                          Flexible(
                                            child: Text(
                                              articles[index].source!.name!,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: AppColor.lightBlueColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          color: AppColor.lightBlueColor,
                                          size: 12,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          articles[index].formattedDate,
                                          style: TextStyle(
                                            color: AppColor.lightBlueColor,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
