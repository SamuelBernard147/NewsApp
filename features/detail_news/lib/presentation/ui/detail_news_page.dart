import 'package:dependencies/dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_news/domain/entities/article_entity.dart';
import 'package:shared/common/common.dart';
import 'package:shared/widget/widget.dart';

class DetailNewsPage extends StatelessWidget {
  final ArticleEntity article;

  const DetailNewsPage({@required this.article});

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          article.urlToImage == null
              ? Container(
                  height: 200.h,
                  child: Center(child: Icon(Icons.error)),
                )
              : Hero(
                  tag: article.urlToImage,
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                  ),
                ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.description ?? "",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Divider(),
                Text(
                  article.title ?? "",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Divider(),
                Text(
                  'Date: ${article.publishedAt}',
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(height: 10.h),
                Text(
                  'Author: ${article.author}',
                  style: Theme.of(context).textTheme.caption,
                ),
                Divider(),
                Text(
                  article.content ?? "",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 10.h),
                RaisedButton(
                  child: Text(Modular.get<LocaleKeys>().btnReadMore.tr()),
                  onPressed: () => Modular.link.pushNamed(
                      Modular.get<NamedRoutes>().detailWebViewPage,
                      arguments: article.url),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Modular.get<LocaleKeys>().detailNewsTitle.tr()),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: Text(Modular.get<LocaleKeys>().detailNewsTitle.tr()),
      ),
      child: SafeArea(child: _buildBody(context)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
