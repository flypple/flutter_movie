class RatingBean{
  /**
   * stars : "40"
   * average : 7.6
   * max : 10
   * min : 0
   */

  String stars;
  num average;
  int max;
  int min;

  static RatingBean fromMap(Map<String, dynamic> map) {
    RatingBean ratingBean = new RatingBean();
    ratingBean.stars = map['stars'];
    ratingBean.average = map['average'];
    ratingBean.max = map['max'];
    ratingBean.min = map['min'];
    return ratingBean;
  }

  static List<RatingBean> fromMapList(dynamic mapList) {
    List<RatingBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}