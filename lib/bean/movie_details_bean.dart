import 'image_bean.dart';
import 'filmmaker_bean.dart';
import 'rating_bean.dart';

class MovieDetailsBean {

  /**
   * douban_site : ""
   * year : "2017"
   * alt : "https://movie.douban.com/subject/26942674/"
   * id : "26942674"
   * mobile_url : "https://movie.douban.com/subject/26942674/mobile"
   * title : "神秘巨星"
   * share_url : "https://m.douban.com/movie/subject/26942674"
   * schedule_url : ""
   * original_title : "Secret Superstar"
   * summary : "少女伊西亚（塞伊拉·沃西 Zaira Wasim 饰）拥有着一副天生的好嗓子，对唱歌充满了热爱的她做梦都想成为一名歌星。然而，伊西亚生活在一个不自由的家庭之中，母亲娜吉玛（梅·维贾 Meher Vij 饰）常常遭到性格爆裂独断专横的父亲法鲁克（拉杰·阿晶 Raj Arjun 饰）的拳脚相向，伊西亚知道，想让父亲支持自己的音乐梦想是完全不可能的事情。\n某日，母亲卖掉了金项链给伊西亚买了一台电脑，很快，伊西亚便发现，虽然无法再现实里实现梦想，但是网络中存在着更广阔的舞台。伊西亚录制了一段蒙着脸自弹自唱的视屏上传到了优兔网上，没想到收获了异常热烈的反响，著名音乐人夏克提（阿米尔·汗 Aamir Khan 饰）亦向她抛出了橄榄枝。©豆瓣"
   * subtype : "movie"
   * reviews_count : 3944
   * wish_count : 34919
   * collect_count : 374407
   * comments_count : 91723
   * ratings_count : 280396
   * images : {"small":"https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2508925590.jpg","large":"https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2508925590.jpg","medium":"https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2508925590.jpg"}
   * rating : {"max":10,"average":7.7,"stars":"40","min":0}
   * aka : ["秘密巨星","隐藏的大明星(台)","打死不离歌星梦(港)","सीक्रेट सुपरस्टार"]
   * countries : ["印度"]
   * genres : ["剧情","音乐"]
   * casts : [{"alt":"https://movie.douban.com/celebrity/1373292/","avatars":{"small":"https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1494080264.12.jpg","large":"https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1494080264.12.jpg","medium":"https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1494080264.12.jpg"},"name":"塞伊拉·沃西","id":"1373292"},{"alt":"https://movie.douban.com/celebrity/1383897/","avatars":{"small":"https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1510229457.27.jpg","large":"https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1510229457.27.jpg","medium":"https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1510229457.27.jpg"},"name":"梅·维贾","id":"1383897"},{"alt":"https://movie.douban.com/celebrity/1031931/","avatars":{"small":"https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p13628.jpg","large":"https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p13628.jpg","medium":"https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p13628.jpg"},"name":"阿米尔·汗","id":"1031931"},{"alt":"https://movie.douban.com/celebrity/1383898/","avatars":{"small":"https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1510229759.29.jpg","large":"https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1510229759.29.jpg","medium":"https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1510229759.29.jpg"},"name":"拉杰·阿晶","id":"1383898"}]
   * directors : [{"alt":"https://movie.douban.com/celebrity/1379532/","avatars":{"small":"https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1509423054.09.jpg","large":"https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1509423054.09.jpg","medium":"https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1509423054.09.jpg"},"name":"阿德瓦·香登","id":"1379532"}]
   */

  String douban_site;
  String year;
  String alt;
  String id;
  String mobile_url;
  String title;
  String share_url;
  String schedule_url;
  String original_title;
  String summary;
  String subtype;
  int reviews_count;
  int wish_count;
  int collect_count;
  int comments_count;
  int ratings_count;
  ImagesBean images;
  RatingBean rating;
  List<String> aka;
  List<String> countries;
  List<String> genres;
  List<FilmmakerBean> casts;
  List<FilmmakerBean> directors;

  static MovieDetailsBean fromMap(Map<String, dynamic> map) {
    MovieDetailsBean movie_details_bean = new MovieDetailsBean();
    movie_details_bean.douban_site = map['douban_site'];
    movie_details_bean.year = map['year'];
    movie_details_bean.alt = map['alt'];
    movie_details_bean.id = map['id'];
    movie_details_bean.mobile_url = map['mobile_url'];
    movie_details_bean.title = map['title'];
    movie_details_bean.share_url = map['share_url'];
    movie_details_bean.schedule_url = map['schedule_url'];
    movie_details_bean.original_title = map['original_title'];
    movie_details_bean.summary = map['summary'];
    movie_details_bean.subtype = map['subtype'];
    movie_details_bean.reviews_count = map['reviews_count'];
    movie_details_bean.wish_count = map['wish_count'];
    movie_details_bean.collect_count = map['collect_count'];
    movie_details_bean.comments_count = map['comments_count'];
    movie_details_bean.ratings_count = map['ratings_count'];
    movie_details_bean.images = ImagesBean.fromMap(map['images']);
    movie_details_bean.rating = RatingBean.fromMap(map['rating']);
    movie_details_bean.casts = FilmmakerBean.fromMapList(map['casts']);
    movie_details_bean.directors = FilmmakerBean.fromMapList(map['directors']);

    List<dynamic> dynamicList0 = map['aka'];
    movie_details_bean.aka = new List();
    movie_details_bean.aka.addAll(dynamicList0.map((o) => o.toString()));

    List<dynamic> dynamicList1 = map['countries'];
    movie_details_bean.countries = new List();
    movie_details_bean.countries.addAll(dynamicList1.map((o) => o.toString()));

    List<dynamic> dynamicList2 = map['genres'];
    movie_details_bean.genres = new List();
    movie_details_bean.genres.addAll(dynamicList2.map((o) => o.toString()));

    return movie_details_bean;
  }

  static List<MovieDetailsBean> fromMapList(dynamic mapList) {
    List<MovieDetailsBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}