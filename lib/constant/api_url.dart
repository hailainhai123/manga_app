class ApiURL {
  static const String baseUrl = "https://api.truyen3k.com";

  // static const String baseUrl = "";
  static const String getAnonymousToken = "api/auth/anonymous";
  static const String bannerUrl = "/api/banner";
  static const String arrivalUrl = "/api/book/latest";
  static const String newComicUrl = '/api/book/new';
  static const String hotNovelUrl = "/api/book/top-view/all?page=1&limit=5";
  static const String topNovelUrl = "/api/book/top-rate?limit=5";
  static const String topCommentNovelUrl = "/api/book/top-comments";
  static const String novelInTagUrl = "/api/book";
  static const String latestUrl = "/api/comic/latest";
  static const String lastUpdateChapter = "/api/comic/last-update-chapter";
  static const String detailsComicUrl = "/api/comic";
  static const String categoriesUrl = "/api/category";
  static const String novelInCateUrl = "/api/category/";
  static const String boookMarkUrl = "/api/user/me/bookmark";

  //Book Details URL
  static const String postReadingStateUrl = "/api/reading-state";
  static const String readingStateUrl = "/api/reading-state/book/";
  static const String novelDetailsUrl = "/api/book/id/";
  static const String chapterDetailsUrl = "/api/chapter/";
  static const String listChapterUrl = "/api/chapter";
  static const String commentsNovelUrl = "/comment";
  static const String postCommentUrl = "/api/comment";
  static const String logViewUrls = "/api/log/views";

  //User Url
  static const String userInfoUrl = "/api/user/me";

  //category
  static const String gridNovelUrl = "/api/category/";

  //User API
  static const String updateAvatarUrl = "/api/user/me/avatar";
  static const String updateInfoUrl = "/api/user/me";

  static String emptyImage =
      "https://clinicforspecialchildren.org/wp-content/uploads/2016/08/avatar-placeholder.gif";
}
