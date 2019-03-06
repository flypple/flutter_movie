import 'image_bean.dart';

class FilmmakerBean{

  /**
   * alt : "https://movie.douban.com/celebrity/1379532/"
   * name : "阿德瓦·香登"
   * id : "1379532"
   * avatars : {"small":"https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1509423054.09.jpg","large":"https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1509423054.09.jpg","medium":"https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1509423054.09.jpg"}
   */

  String alt;
  String name;
  String id;
  ImagesBean avatars;

  static FilmmakerBean fromMap(Map<String, dynamic> map) {
    FilmmakerBean directorsListBean = new FilmmakerBean();
    directorsListBean.alt = map['alt'];
    directorsListBean.name = map['name'];
    directorsListBean.id = map['id'];
    directorsListBean.avatars = ImagesBean.fromMap(map['avatars']);
    return directorsListBean;
  }

  static List<FilmmakerBean> fromMapList(dynamic mapList) {
    List<FilmmakerBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}