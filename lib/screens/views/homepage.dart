import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/constants/constants.dart';
import 'package:flutter_news_app/screens/model/article_model.dart';
import 'package:flutter_news_app/screens/views/news_description_page.dart';
import 'package:flutter_news_app/services.dart';
import 'package:flutter_news_app/widgets/tabbarview_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatelessWidget {
  final ApiServices client = ApiServices();

  Padding _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBreakingNews(),
          _buildOtherNews(),
        ],
      ),
    );
  }

  Expanded _buildOtherNews() {
    return Expanded(
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              height: 20,
              width: double.infinity,
              child: TabBar(
                unselectedLabelColor: AppColor.lightBlueColor,
                labelColor: Colors.blue,
                tabs: [
                  Tab(
                    text: "All",
                  ),
                  Tab(
                    text: "Technology",
                  ),
                  Tab(
                    text: "Business",
                  ),
                  Tab(
                    text: "Sports",
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  TabbarView(
                    client: client,
                    serviceUrl: 'everything?q=nepal&pageSize=20',
                  ),
                  TabbarView(
                      client: client,
                      serviceUrl:
                          'top-headlines?country=us&category=technology&pageSize=20'),
                  TabbarView(
                      client: client,
                      serviceUrl:
                          'top-headlines?country=us&category=business&pageSize=20'),
                  TabbarView(
                      client: client,
                      serviceUrl:
                          'top-headlines?country=us&category=sports&pageSize=20'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder _buildBreakingNews() {
    return FutureBuilder(
      future: client
          .getData('top-headlines?country=us&category=business&pageSize=1'),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          var error = snapshot.error;
          return Center(
            child: Text("$error"),
          );
        } else if (snapshot.hasData) {
          List<Article> articles = snapshot.data;
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Breaking News",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColor.darkBlueColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDescription(
                          imageUrl: articles[0].urlToImage,
                          content: articles[0].description,
                          sourceName: articles[0].source!.name,
                          title: articles[0].title,
                          publishedAt: articles[0].formattedDate,
                          url: articles[0].url,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10, right: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 6),
                          blurRadius: 7,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xff0c7bb3),
                                Color(0xfff2baeb),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Hero(
                            tag: "image${articles[0].urlToImage}",
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
                              fadeInCurve: Curves.easeIn,
                              fadeInDuration: Duration(seconds: 3),
                              placeholder: kTransparentImage,
                              image: articles[0].urlToImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            articles[0].title!,
                            // " A team of mountaineers will mark a line between the Nepal and Chinese side to stop climbers mixing.",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColor.darkBlueColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    // CircleAvatar(
                                    //   backgroundColor:
                                    //       Colors.blue.withOpacity(0.2),
                                    // ),
                                    // SizedBox(width: 20),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff0C9AEC),
                                            Color(0xffB185B6)
                                          ],
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                        ),
                                      ),
                                      child: Text(
                                        articles[0].source!.name!,
                                        // "John Smith",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Text(
                                  articles[0].formattedDate,
                                  style: TextStyle(
                                    color: AppColor.lightBlueColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white.withOpacity(0.1),
      leading: Padding(
        padding: const EdgeInsets.only(
          left: 20,
        ),
        child: CircleAvatar(
          backgroundColor: Colors.blue.withOpacity(0.4),
          child: Icon(
            Icons.people,
            color: Colors.blueGrey,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(
            Icons.search,
            color: AppColor.darkBlueColor,
            size: 25,
          ),
        ),
      ],
      title: Text(
        todayDate,
        style: TextStyle(
          color: AppColor.lightBlueColor,
          fontSize: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}
