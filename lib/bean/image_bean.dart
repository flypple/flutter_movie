class ImagesBean{
  /**
   * small : "https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1378050540.89.jpg"
   * large : "https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1378050540.89.jpg"
   * medium : "https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1378050540.89.jpg"
   */

  String small;
  String large;
  String medium;

  static ImagesBean fromMap(Map<String, dynamic> map) {
    if(map == null){
      return null;
    }
    ImagesBean avatarsBean = new ImagesBean();
    avatarsBean.small = map['small'];
    avatarsBean.large = map['large'];
    avatarsBean.medium = map['medium'];
    return avatarsBean;
  }

  static List<ImagesBean> fromMapList(dynamic mapList) {
    List<ImagesBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}