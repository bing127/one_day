import 'package:fluro/fluro.dart';
import 'package:one_day/routers/router_init.dart';
import 'detail_page.dart';
import 'add_page.dart';

class AppRouter implements IRouterProvider{

  static String detailPage = "/detail";
  static String addPage = "/add";

  @override
  void initRouter(Router router) {
    router.define(detailPage, handler: Handler(handlerFunc: (_, params){
      String title = params['title'].first;
      String date = params['date'].first;
      String tag = params['tag'].first;
      String thumbnail = params['thumbnail'].first;
      return DetailPage(title:title,date:date,tag: tag,thumbnail: thumbnail,);
    }));

    router.define(addPage, handler: Handler(handlerFunc: (_, params) => AddPage()));

  }

}