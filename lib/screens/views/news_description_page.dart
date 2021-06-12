import 'package:flutter/material.dart';
import 'package:flutter_news_app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/services.dart';

class NewsDescription extends StatelessWidget {
  final String? imageUrl;
  final String? content;
  final String? title;
  final String? sourceName;
  final String? publishedAt;
  final String? url;
  NewsDescription({
    this.imageUrl,
    this.content,
    this.title,
    this.sourceName,
    this.publishedAt,
    this.url,
  });

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Center buildReadmoreButton() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: [Color(0xff0C9AEC), Color(0xffB185B6)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(3, -3),
              blurRadius: 5,
              color: Colors.grey.shade400,
            ),
          ],
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Color(0xffB185B6),
          child: InkWell(
            onTap: () {
              if (url != null) {
                _launchUrl(url!);
              } else {
                return Get.snackbar(
                  "Could not launch",
                  "Url not found",
                  snackPosition: SnackPosition.TOP,
                );
              }
            },
            child: Container(
              child: Text(
                'Read More ➡',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildContentContainer() {
    return Container(
      child: Text(
        content ?? "No content available",
        style: TextStyle(
          color: AppColor.lightBlueColor,
        ),
      ),
    );
  }

  Row _buildSourceDateRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [Color(0xff0C9AEC), Color(0xffB185B6)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Text(
            sourceName ?? "",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Container(
          child: Text(
            "$publishedAt",
            style: TextStyle(
              color: AppColor.lightBlueColor,
            ),
          ),
        ),
      ],
    );
  }

  Container _buildNewsTitle() {
    return Container(
      child: Text(
        title ?? "No title",
        style: TextStyle(
          color: AppColor.darkBlueColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      toolbarHeight: 80,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 6),
                  blurRadius: 6,
                  color: Colors.grey.withOpacity(0.3),
                )
              ],
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new,
                    color: AppColor.darkBlueColor)),
          ),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 6),
                  blurRadius: 6,
                  color: Colors.grey.withOpacity(0.3),
                )
              ],
            ),
            child: IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: url)).then((value) =>
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Url copied to clipboard"))));
              },
              icon: Icon(
                Icons.share,
                // color: AppColor.darkBlueColor,
              ),
              color: AppColor.darkBlueColor,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildImageContainer() {
    return Container(
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
        tag: "image$imageUrl",
        child: FadeInImage.memoryNetwork(
          imageErrorBuilder: (context, exception, stackTrace) {
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
          image: imageUrl!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageContainer(),
              SizedBox(height: 20),
              _buildNewsTitle(),
              SizedBox(height: 20),
              _buildSourceDateRow(),
              SizedBox(height: 20),
              _buildContentContainer(),
              SizedBox(height: 10),
              buildReadmoreButton(),
            ],
          ),
        ),
      ),
    );
  }
}
