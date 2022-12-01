import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:manga_app/constant/api_url.dart';
import 'package:manga_app/models/banner/model_banner.dart';
import 'package:manga_app/models/chapter_model.dart';
import 'package:manga_app/models/grid_novel/grid_novel_model.dart';
import 'package:manga_app/models/home/new_model/categories_novel_model.dart';
import 'package:manga_app/models/meta_model.dart';
import 'package:manga_app/models/notification_model.dart';
import 'package:manga_app/models/user_infomation.dart';
import 'package:manga_app/utils/global_controller.dart';

import '../../models/chapter_model.dart';
import '../../models/comment_model.dart';
import '../../models/grid_novel/grid_novel_model.dart';
import '../../models/home/new_model/novel_response_model.dart';
import '../../models/list_chap_model.dart';
import '../../models/reading_state_model.dart';
import '../../models/response_temp_model.dart';
import '../utils/user_pref.dart';
import 'custom_log.dart';

const int kDefaultTimeOut = 60 * 1000;

class ApiDioController {
  // static const _baseUrl = 'https://api.truyen3k.com';
  static const _baseUrl = 'https://dev-api.arbedev.com';

  static BaseOptions options = BaseOptions(
    baseUrl: _baseUrl,
    headers: {
      'apiKey':
          '\$2b\$10\$A1rUeYglkeiUywujh8wWJu0W3eoI3esyZ27ze62LHkzJpdZxhXdei',
    },
    connectTimeout: kDefaultTimeOut,
    receiveTimeout: kDefaultTimeOut,
  );

  // Construction to use multiple project
  static Future<T?> getData<T>({
    Function(MetaModel?)? metaCallback,
    required String url,
    required Dio dio,
    Map<String, dynamic>? query,
    required Function(dynamic) asModel,
  }) async {
    try {
      // dio.options.headers['x-access-token'] =
      //     Get.find<GlobalController>().accessToken.value;
      // print(accessToken);
      dio.options.headers['Authorization'] =
          "Bearer ${Get.find<GlobalController>().accessToken.value}";
      Response<Map<String, dynamic>> response = await dio.get(
        url,
        queryParameters: query,
      );
      if (response.statusCode == 200) {
        if (response.data!['message'] == "success") {
          if (response.data?['meta'] != null) {
            var meta = MetaModel.fromJson(response.data?['meta']);
            if (meta.hasNextPage != null) {
              // nextPage!(meta.hasNextPage ?? false);
              if (metaCallback != null) {
                metaCallback(meta);
              }
            }
          }
          if (response.data!['data'] != null) {
            return asModel(response.data!['data']);
          } else {
            return asModel(response.data!);
          }
        }
      }

      return null;
    } on DioError catch (e) {
      CustomLog.log(e);
      return null;
    } catch (e) {
      CustomLog.log(e);
      return null;
    }
  }

  static Future<T?> postMethods<T>({
    required String url,
    required Dio dio,
    dynamic body,
    required Function(Map<String, dynamic>) asModel,
  }) async {
    try {
      print(body);
      print(url);
      dio.options.headers['Authorization'] =
          "Bearer ${Get.find<GlobalController>().accessToken.value}";

      Response<Map<String, dynamic>> response = await dio.post(
        url,
        data: body,
      );
      CustomLog.log(response);
      if (response.statusCode == 200) {
        if (response.data!['message'] == "success") {
          return asModel(response.data!);
        }
      }

      return null;
    } on DioError catch (e) {
      CustomLog.log(e);
      return null;
    } catch (e) {
      CustomLog.log(e);
      return null;
    }
  }

  static Future<T?> putMethods<T>({
    required String url,
    required Dio dio,
    dynamic body,
    required Function(Map<String, dynamic>) asModel,
  }) async {
    try {
      dio.options.headers['x-access-token'] =
          Get.find<GlobalController>().accessToken.value;

      Response<Map<String, dynamic>> response = await dio.put(url, data: body);

      CustomLog.log(response.data);

      if (response.statusCode == 200) {
        if (response.data!['message']) {
          return asModel(response.data!);
        }
      }

      return null;
    } on DioError catch (e) {
      CustomLog.log(e);
      return null;
    } catch (e) {
      CustomLog.log(e);
      return null;
    }
  }

  static Future<T?> pathMethods<T>({
    required String url,
    required Dio dio,
    dynamic body,
    required Function(Map<String, dynamic>) asModel,
  }) async {
    try {
      dio.options.headers['x-access-token'] =
          Get.find<GlobalController>().accessToken.value;

      Response<Map<String, dynamic>> response =
          await dio.patch(url, data: body);

      CustomLog.log(response);

      if (response.statusCode == 200) {
        if (response.data!['message'] == "success") {
          return asModel(response.data!);
        }
      }

      return null;
    } on DioError catch (e) {
      CustomLog.log(e);
      return null;
    } catch (e) {
      CustomLog.log(e);
      return null;
    }
  }

  static Future<T?> deleteMethod<T>({
    required String url,
    required Dio dio,
    Map<String, dynamic>? body,
    required Function(Map<String, dynamic>) asModel,
  }) async {
    try {
      dio.options.headers['x-access-token'] =
          Get.find<GlobalController>().accessToken.value;

      Response<Map<String, dynamic>> response = await dio.delete(
        url,
        data: body,
      );

      // CustomLog.log(response.data);

      if (response.statusCode == 200) {
        if (response.data!['message']) {
          return asModel(response.data!);
        }
      }

      return null;
    } on DioError catch (e) {
      CustomLog.log(e);
      return null;
    } catch (e) {
      CustomLog.log(e);
      return null;
    }
  }

  static Future<bool> getAndSaveToken(String tokenFireBase) async {
    try {
      Dio dio = Dio(options);

      Response response = await dio.post('$_baseUrl/api/auth/verify',
          options:
              Options(headers: {'Authorization': 'Bearer $tokenFireBase'}));
      if (response.statusCode == 200) {
        UserInformation info = UserInformation.fromJson(response.data['data']);
        info.firebaseToken = tokenFireBase;
        UserPref().setUser(info);
        Get.find<GlobalController>().setToken(tokenFireBase);
      }
      return true;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        CustomLog.log('Dio error!');
        CustomLog.log('STATUS: ${e.response?.statusCode}');
        CustomLog.log('DATA: ${e.response?.data}');
        CustomLog.log('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        CustomLog.log('Error sending request!');
        CustomLog.log(e.message);
      }
      return false;
    }
  }

  static Future loginAsAnonymous({required Function(bool) callback}) async {
    Dio dio = Dio(options);

    await getData(
      url: ApiURL.getAnonymousToken,
      dio: dio,
      asModel: (map) async {
        if (map['success']) {
          await getAndSaveToken("");
          callback(true);
        }
      },
    );

    return callback(true);
  }

  static Future<List<BannerModel>> getBanners() async {
    Dio dio = Dio(options);

    List<BannerModel> listBanner = [];
    await getData<List<BannerModel>>(
      url: ApiURL.bannerUrl,
      dio: dio,
      asModel: (map) {
        final responseList = map as List;
        listBanner = responseList.map((e) => BannerModel.fromJson(e)).toList();
      },
    );

    return listBanner;
  }

  static Future<List<ComicResponseModel>> getArrivals() async {
    Dio dio = Dio(options);

    List<ComicResponseModel> listArrivals = [];
    await getData<List<ComicResponseModel>>(
      url: ApiURL.arrivalUrl,
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        final responseList = map as List;
        listArrivals =
            responseList.map((e) => ComicResponseModel.fromJson(e)).toList();
      },
    );

    return listArrivals;
  }

  static Future<List<ComicResponseModel>> getNewComics() async {
    Dio dio = Dio(options);

    List<ComicResponseModel> listArrivals = [];
    await getData<List<ComicResponseModel>>(
      url: ApiURL.newComicUrl,
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        final responseList = map as List;
        listArrivals =
            responseList.map((e) => ComicResponseModel.fromJson(e)).toList();
      },
    );

    return listArrivals;
  }

  static Future<List<ComicResponseModel>> getHotNovels() async {
    Dio dio = Dio(options);

    List<ComicResponseModel> listArrivals = [];
    await getData<List<ComicResponseModel>>(
      url: ApiURL.hotNovelUrl,
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        final responseList = map as List;
        listArrivals =
            responseList.map((e) => ComicResponseModel.fromJson(e)).toList();
      },
    );

    return listArrivals;
  }

  static Future<ComicResponseModel> getTopNovel() async {
    Dio dio = Dio(options);
    ComicResponseModel top = ComicResponseModel();
    List<ComicResponseModel> listTop = [];

    await getData<ComicResponseModel>(
      url: ApiURL.topNovelUrl,
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        final responseList = map as List;
        listTop =
            responseList.map((e) => ComicResponseModel.fromJson(e)).toList();
        return top = listTop[0];
      },
    );
    return top;
  }

  static Future<List<ComicResponseModel>> getTopCommentNovel(int page,
      {required Function(bool) isNextPage}) async {
    Dio dio = Dio(options);
    List<ComicResponseModel> listTopComment = [];
    await getData<List<ComicResponseModel>>(
      url: ApiURL.topNovelUrl,
      dio: dio,
      query: {'page': page},
      metaCallback: (meta) {
        if (meta == null) return;
        isNextPage(meta.hasNextPage ?? false);
      },
      asModel: (map) {
        final responseList = map as List;
        listTopComment =
            responseList.map((e) => ComicResponseModel.fromJson(e)).toList();
      },
    );
    return listTopComment;
  }

  static Future<List<CategoriesNovelModel>> getCategories() async {
    Dio dio = Dio(options);

    List<CategoriesNovelModel> categories = [];

    await getData<CategoriesNovelModel>(
      url: '${ApiURL.categoriesUrl}?page=1&limit=100',
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        final responseList = map as List;
        categories =
            responseList.map((e) => CategoriesNovelModel.fromJson(e)).toList();
      },
    );
    return categories;
  }

  static Future<List<ComicResponseModel>> getNovelInCate(String idCate) async {
    Dio dio = Dio(options);

    List<ComicResponseModel> categories = [];

    await getData<ComicResponseModel>(
      url: '${ApiURL.novelInCateUrl}$idCate/book?page=1&limit=1000',
      dio: dio,
      metaCallback: (meta) {},
      asModel: (map) {
        final responseList = map as List;
        categories =
            responseList.map((e) => ComicResponseModel.fromJson(e)).toList();
      },
    );
    return categories;
  }

  //TODO: BookMark
  static Future<List<ComicResponseModel>> getListBookMark() async {
    Dio dio = Dio(options);
    List<ComicResponseModel> listBookMark = [];

    await getData<List<ComicResponseModel>>(
      url: ApiURL.boookMarkUrl,
      dio: dio,
      metaCallback: (meta) {},
      asModel: (map) {
        final responseList = map as List;
        listBookMark =
            responseList.map((e) => ComicResponseModel.fromJson(e)).toList();
      },
    );
    return listBookMark;
  }

  //TODO: Book Details
  static Future<ReadingStateModel?> getReadingState(String bookId) async {
    Dio dio = Dio(options);
    dio.options.headers['Authorization'] =
        "Bearer ${Get.find<GlobalController>().accessToken.value}";
    ReadingStateModel? top = ReadingStateModel();
    await getData<ReadingStateModel?>(
      url: '${ApiURL.readingStateUrl}$bookId',
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        CustomLog.log(map);
        if (map == null) return;
        top = ReadingStateModel.fromJson(map);
      },
    );
    return top;
  }

  static Future<ComicResponseModel?> getNovelDetails(String id) async {
    Dio dio = Dio(options);
    ComicResponseModel? top;
    print('${ApiURL.novelDetailsUrl}$id');
    await getData<ComicResponseModel>(
      url: '${ApiURL.novelDetailsUrl}$id',
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        if (map == null) return;
        top = ComicResponseModel.fromJson(map);
      },
    );
    return top;
  }

  static Future<List<CommentModel>> getNovelComments(
    String id,
    int page,
    int limit,
  ) async {
    Dio dio = Dio(options);
    List<CommentModel> listComment = [];
    await getData<List<CommentModel>>(
      url:
          '${ApiURL.novelDetailsUrl}$id${ApiURL.commentsNovelUrl}?page=$page&limit=$limit',
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        final responseList = map as List;
        listComment =
            responseList.map((e) => CommentModel.fromJson(e)).toList();
      },
    );
    return listComment;
  }

  static Future<bool> postComment({
    String? bookId,
    required String content,
    String? chapterId,
  }) async {
    Dio dio = Dio(options);
    Map<String, String> body =
        bookId == null ? {'chapterId': chapterId!} : {'bookId': bookId};
    body.addAll({'content': content});
    bool? success = await postMethods<bool?>(
      url: ApiURL.postCommentUrl,
      dio: dio,
      body: body,
      // nextPage: nextPage,
      asModel: (map) {
        return ResponseTempModel.fromJson(map).message == "success";
      },
    );
    return success ?? false;
  }

  //Up viewed chapter
  static Future<bool> upViewed({
    required String bookId,
    required String chapterId,
  }) async {
    Dio dio = Dio(options);
    Map<String, String> body = {'chapterId': chapterId, 'bookId': bookId};
    bool? success = await postMethods<bool?>(
      url: ApiURL.logViewUrls,
      dio: dio,
      body: body,
      // nextPage: nextPage,
      asModel: (map) {
        return ResponseTempModel.fromJson(map).message == "success";
      },
    );
    return success ?? false;
  }

  static Future<List<CommentModel>> getChapterComment(
      String chapterId, int page, int limit) async {
    Dio dio = Dio(options);
    List<CommentModel> listComments = [];
    await getData<List<CommentModel>>(
      url:
          "${ApiURL.chapterDetailsUrl}$chapterId${ApiURL.commentsNovelUrl}?page=$page&limit=$limit",
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        final responseList = map as List;
        listComments =
            responseList.map((e) => CommentModel.fromJson(e)).toList();
      },
    );
    return listComments;
  }

  static Future<ChapterModel?> getChapterDetails(String id) async {
    Dio dio = Dio(options);
    ChapterModel? top;
    await getData<ChapterModel>(
      url: '${ApiURL.chapterDetailsUrl}$id',
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        if (map == null) return;
        top = ChapterModel.fromJson(map);
      },
    );
    return top;
  }

  static Future<ChapterModel?> getContentChapterByNumber(
      int number, String bookId) async {
    Dio dio = Dio(options);
    ChapterModel? chapter;
    await getData<ChapterModel>(
      url: '/api/book/id/$bookId/chapter/$number',
      dio: dio,
      // nextPage: nextPage,
      asModel: (map) {
        if (map == null) return;
        chapter = ChapterModel.fromJson(map);
      },
    );
    return chapter;
  }

  static Future<List<ListChapModel>> getListChapter(String id, int page,
      {required Function(bool) nextPage}) async {
    Dio dio = Dio(options);
    List<ListChapModel> chapters = [];
    await getData<List<ListChapModel>>(
      url: ApiURL.listChapterUrl,
      dio: dio,
      query: {'page': page, 'limit': '10', 'bookId': id},
      metaCallback: (meta) {
        if (meta == null) return;
        nextPage(meta.hasNextPage ?? false);
      },
      asModel: (map) {
        final responseList = map as List;
        chapters = responseList.map((e) => ListChapModel.fromJson(e)).toList();
      },
    );
    return chapters;
  }

  static Future<UserInformation?> getUserInformation() async {
    Dio dio = Dio(options);
    dio.options.headers['Authorization'] =
        "Bearer ${Get.find<GlobalController>().accessToken.value}";
    UserInformation? info;
    await getData<UserInformation>(
      url: ApiURL.userInfoUrl,
      dio: dio,
      asModel: (map) {
        info = UserInformation.fromJson(map);
      },
    );
    print('${info?.displayName}');
    return info;
  }

  static Future<List<GridNovelModel>> getGridNovel(String url, int page,
      {required Function(bool) nextPage}) async {
    Dio dio = Dio(options);

    List<GridNovelModel> books = [];
    await getData<List<GridNovelModel>>(
      url: url,
      dio: dio,
      query: {
        'page': page,
        'limit': '10',
      },
      metaCallback: (meta) {
        if (meta == null) return;
        nextPage(meta.hasNextPage ?? false);
      },
      asModel: (map) {
        print(map);
        final responseList = map as List;
        books = responseList.map((e) => GridNovelModel.fromJson(e)).toList();
      },
    );
    return books;
  }

  static Future updateAvatar(File file) async {
    Dio dio = Dio(options);
    var dataForm = FormData.fromMap({});

    dataForm.files.addAll([
      MapEntry(
          "images",
          await MultipartFile.fromFile(file.path,
              filename: file.path.split('/').last))
    ]);
    await pathMethods(
        url: ApiURL.updateAvatarUrl,
        dio: dio,
        body: dataForm,
        asModel: (map) {});
  }

  static Future updateUserName(String name) async {
    Dio dio = Dio(options);
    await pathMethods(
        url: ApiURL.updateInfoUrl,
        dio: dio,
        body: {'displayName': name},
        asModel: (map) {
          return map;
        });
  }

  static Future<List<ComicResponseModel>> getNovelInSearch(
      {required Function(bool) hasNextPage,
      required String text,
      required int page}) async {
    Dio dio = Dio(options);
    List<ComicResponseModel> list = [];
    await getData(
        url: "/api/book/search/$text?limit=10",
        dio: dio,
        query: {'page': page},
        metaCallback: (meta) {
          if (meta == null) return;
          hasNextPage(meta.hasNextPage ?? false);
        },
        asModel: (map) {
          final responseList = map as List;
          list =
              responseList.map((e) => ComicResponseModel.fromJson(e)).toList();
        });
    return list;
  }

  static Future<List<NotificationModel>> getAllNoti(
      {required Function(bool) hasNextPage, required int page}) async {
    Dio dio = Dio(options);
    List<NotificationModel> list = [];
    await getData(
        url: "/api/notification",
        dio: dio,
        query: {'page': page},
        metaCallback: (meta) {
          if (meta == null) return;
          hasNextPage(meta.hasNextPage ?? false);
        },
        asModel: (map) {
          final responseList = map as List;
          list =
              responseList.map((e) => NotificationModel.fromJson(e)).toList();
        });
    return list;
  }

  static Future<Map<String, dynamic>?> setReadingState(
      ReadingStateModel body) async {
    Dio dio = Dio(options);
    Map<String, dynamic>? readingStateModel;
    print(body);
    await postMethods<Map<String, dynamic>?>(
      url: ApiURL.postReadingStateUrl,
      dio: dio,
      body: body.toJson(),
      asModel: (map) {
        readingStateModel = map;
        return;
      },
    );
    return readingStateModel;
  }
//
// static Future<bool> claimNotificationRewards({required String id}) async {
//   Dio dio = Dio(options);
//
//   bool? isSuccess = await postMethods<bool?>(
//     url: '/api/notification/claim/$id',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => map['success'],
//   );
//
//   return isSuccess == null ? false : isSuccess;
// }
//
// static Future<bool> changeUserAvatar({required File file}) async {
//   Dio dio = Dio(options);
//
//   FormData formData = FormData.fromMap({
//     'avatar': MultipartFile.fromFileSync(
//       file.path,
//       filename: file.path.split('/').last,
//     ),
//   });
//
//   bool? isSuccess = await postMethods<bool?>(
//     url: '/api/user/avatar',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => map['success'],
//     body: formData,
//   );
//
//   return isSuccess == null ? false : isSuccess;
// }
//
// static Future<bool> updateUserInfo({
//   String? username,
//   String? email,
// }) async {
//   Dio dio = Dio(options);
//
//   Map<String, dynamic> data = {};
//
//   if (username != null && username.isNotEmpty) {
//     data.addAll({'username': username});
//   }
//
//   if (email != null && email.isNotEmpty) {
//     data.addAll({'email': email});
//   }
//
//   bool? isSuccess = await postMethods<bool?>(
//     url: '/api/user',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => map['success'],
//     body: data,
//   );
//
//   return isSuccess == null ? false : isSuccess;
// }
//
// static Future<bool> validateUsername({required String username}) async {
//   Dio dio = Dio(options);
//
//   Map<String, dynamic>? res = await postMethods<Map<String, dynamic>?>(
//     url: '/api/writer-registration/validate-username/$username',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => map,
//   );
//
//   if (res == null) return false;
//
//   return res['success'] == true && res['msg'] == '' ? true : false;
// }
//
// static Future<bool> validateEmail({required String email}) async {
//   Dio dio = Dio(options);
//
//   Map<String, dynamic>? res = await postMethods<Map<String, dynamic>?>(
//     url: '/api/writer-registration/validate-email/$email',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => map,
//   );
//
//   if (res == null) return false;
//
//   return res['success'] == true && res['msg'] == '' ? true : false;
// }
//
// static Future<bool> postRegisterApplication({
//   required String penname,
//   required String username,
//   required String email,
//   required String fullName,
//   required String novelUrl,
//   required DateTime birthDay,
// }) async {
//   Dio dio = Dio(options);
//   dio.options.contentType = Headers.formUrlEncodedContentType;
//
//   Map<String, dynamic> data = {
//     'username': username,
//     'email': email,
//     'fullName': penname,
//     'name': fullName,
//     'novelUrl': novelUrl,
//     'birthDay': birthDay,
//   };
//
//   bool? isSuccess = await postMethods<bool?>(
//     url: '/api/writer-registration',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => map['success'],
//     body: data,
//   );
//
//   return isSuccess == null ? false : isSuccess;
// }
//
// static Future<bool> checkExistWriterApplication() async {
//   Dio dio = Dio(options);
//
//   Map<String, dynamic>? res = await postMethods<Map<String, dynamic>?>(
//     url: '/api/writer-registration/checkExist',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => map,
//   );
//
//   if (res == null) return false;
//
//   return res['success'] == true && res['data'] == true;
// }
//
// static Future<ModelWriterAccountResponse?> getWriterAccount() async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelWriterAccountResponse?>(
//     url: '/api/writer-account',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => ModelWriterAccountResponse.fromJson(map),
//   );
// }
//
// // My Unlocked
// static Future<ModelMyUnlockedDoc?> getMyUnlocked({
//   int page = 1,
//   int size = 5,
// }) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelMyUnlockedDoc?>(
//     url: '/api/user/myUnlockedAll',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => ModelMyUnlockedDoc.fromJson(map['data']),
//     query: {'page': page, 'size': size},
//   );
// }
//
// static Future<ModelMyUnlockedDetailDoc?> getMyUnlockedDetail(
//     {required String novelId}) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelMyUnlockedDetailDoc?>(
//     url: '/api/user/myUnlockedChaptersAll/$novelId',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => ModelMyUnlockedDetailDoc.fromJson(map),
//   );
// }
//
// // Cate Detail
// static Future<ModelNewNovelDoc?> getCategoryDoc({
//   int page = 1,
//   int size = 10,
//   required String collectionId,
// }) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelNewNovelDoc?>(
//     url: '/api/novels',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => ModelNewNovelDoc.fromJson(map['data']),
//     query: {
//       'collectionId': collectionId,
//       'page': page,
//       'size': size,
//     },
//   );
// }
//
// static Future<ModelNewNovelDoc?> getDailyTrending({
//   int page = 1,
//   int size = 10,
// }) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelNewNovelDoc?>(
//     url: '/api/novels/dailyTrending',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => ModelNewNovelDoc.fromJson(map['data']),
//     query: {
//       'page': page,
//       'size': size,
//     },
//   );
// }
//
// static Future<List<String>?> getTopTag() async {
//   Dio dio = Dio(options);
//
//   return await getData<List<String>?>(
//     url: '/api/tags/top',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) {
//       List list = map['data'] as List;
//       return list.map((e) => e.toString()).toList();
//     },
//   );
// }
//
// static Future<ModelNewNovelDoc?> getSuggestion({
//   int page = 1,
//   int size = 10,
// }) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelNewNovelDoc?>(
//     url: '/api/novels/suggestion',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => ModelNewNovelDoc.fromJson(map['data']),
//     query: {
//       'page': page,
//       'size': size,
//     },
//   );
// }
//
// static Future<ModelNewNovelDoc?> getNovelByTag({
//   required String tag,
//   int page = 1,
//   int size = 10,
// }) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelNewNovelDoc?>(
//     url: '/api/novels',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => ModelNewNovelDoc.fromJson(map['data']),
//     query: {
//       'tags': tag,
//       'page': page,
//       'size': size,
//     },
//   );
// }
//
// static Future<ModelDailyEarnReward?> getDailyEarnRewarData() async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelDailyEarnReward?>(
//     url: '/api/user/daily-earn-reward',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) {
//       if (map['data'] == null) {
//         return ModelDailyEarnReward.newDaily();
//       }
//
//       return ModelDailyEarnReward.fromJson(map['data']);
//     },
//   );
// }
//
// static Future<bool?> updateDailyEarnRewardData(
//     ModelDailyEarnReward data) async {
//   Dio dio = Dio(options);
//   Map<String, dynamic> body = {'data': data.toJson()};
//
//   return await postMethods<bool?>(
//     url: '/api/user/daily-earn-reward',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) {
//       final isSuccess = map['success'] as bool;
//
//       return isSuccess;
//     },
//     body: body,
//   );
// }
//
// static Future<bool?> updateResources(List<ModelItem> items,
//     {String? source}) async {
//   Dio dio = Dio(options);
//
//   dynamic _items = items.map((e) => e.toJson()).toList();
//
//   Map<String, dynamic> body = {'data': _items, 'voucherSource': source};
//
//   return await postMethods<bool?>(
//     url: '/api/user/update-resources',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) {
//       final isSuccess = map['success'] as bool;
//
//       return isSuccess;
//     },
//     body: body,
//   );
// }
//
// static Future<List<ModelGift>> getAllGifts() async {
//   Dio dio = Dio(options);
//
//   List<ModelGift>? list = await getData<List<ModelGift>?>(
//     url: '/api/define-gift',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) {
//       final responseList = map['data'] as List;
//       return responseList.map((e) => ModelGift.fromJson(e)).toList();
//     },
//   );
//
//   return list == null ? [] : list;
// }
//
// static Future<ModelTopFanPreview?> getPreviewTopFans(String novelId) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelTopFanPreview?>(
//     url: '/api/novel-gift/preview/$novelId',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) {
//       return ModelTopFanPreview.fromJson(map['data']);
//     },
//   );
// }
//
// static Future<ModelSentGiftsDoc?> getGiftWall(
//   String novelId, {
//   int page = 1,
//   int size = 10,
// }) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelSentGiftsDoc?>(
//     url: '/api/novel-gift/wall',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     query: {'novelId': novelId, 'page': page, 'size': size},
//     asModel: (map) {
//       return ModelSentGiftsDoc.fromJson(map['data']);
//     },
//   );
// }
//
// static Future<ModelGiftTopDoc?> getGiftTop(
//   String novelId, {
//   int page = 1,
//   int size = 10,
// }) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelGiftTopDoc?>(
//     url: '/api/novel-gift/top',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     query: {'novelId': novelId, 'page': page, 'size': size},
//     asModel: (map) {
//       return ModelGiftTopDoc.fromJson(map['data']);
//     },
//   );
// }
//
// static Future<bool> sendGift({
//   required String novelId,
//   required String giftId,
//   required String quote,
// }) async {
//   Dio dio = Dio(options);
//   dio.options.contentType = Headers.formUrlEncodedContentType;
//
//   Map<String, dynamic> body = {
//     'novelId': novelId,
//     'giftId': giftId,
//     'quote': quote,
//   };
//
//   bool? isSuccess = await postMethods<bool?>(
//     url: '/api/novel-gift',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) {
//       final isSuccess = map['success'] as bool;
//       return isSuccess;
//     },
//     body: body,
//   );
//
//   return isSuccess ?? false;
// }
//
// static Future<UserInformation?> getUserInfo() async {
//   Dio dio = Dio(options);
//
//   return await getData<UserInformation?>(
//     url: '/api/user',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) {
//       return UserInformation.fromJson(map['data']);
//     },
//   );
// }
//
// static Future<ModelAuthorDetail?> getAuthorInfo(String id) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelAuthorDetail?>(
//     url: '/api/author/$id',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) {
//       return ModelAuthorDetail.fromJson(map['data']);
//     },
//   );
// }
//
// static Future<ModelNewNovelDoc?> getAuthorNovels({
//   required String authorId,
//   int page = 1,
//   int size = 10,
// }) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelNewNovelDoc?>(
//     url: '/api/novels',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => ModelNewNovelDoc.fromJson(map['data']),
//     query: {
//       'authorId': authorId,
//       'page': page,
//       'size': size,
//     },
//   );
// }
//
// static Future<bool> followAuthor({
//   required String authorUsername,
// }) async {
//   Dio dio = Dio(options);
//
//   bool? isSuccess = await postMethods<bool?>(
//     url: '/api/author/follow/$authorUsername',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) {
//       final isSuccess = map['success'] as bool;
//       return isSuccess;
//     },
//   );
//
//   return isSuccess ?? false;
// }
//
// static Future<bool> unfollowAuthor({
//   required String authorUsername,
// }) async {
//   Dio dio = Dio(options);
//
//   bool? isSuccess = await postMethods<bool?>(
//     url: '/api/author/unfollow/$authorUsername',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) {
//       final isSuccess = map['success'] as bool;
//       return isSuccess;
//     },
//   );
//
//   return isSuccess ?? false;
// }
//
// static Future<ModelAuthorCompassDoc?> getFollowingAuthor(
//     {int page = 1, int size = 10}) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelAuthorCompassDoc?>(
//       url: '/api/author/following/me',
//       accessToken: GetX.Get.find<Controller>().token.value,
//       dio: dio,
//       asModel: (map) => ModelAuthorCompassDoc.fromJson(map['data']),
//       query: {
//         'page': page,
//         'size': size,
//       });
// }
//
// static Future<bool> sendMail({
//   required String title,
//   required String content,
//   List<PickedFile>? files,
// }) async {
//   Dio dio = Dio(options);
//
//   FormData formData = FormData.fromMap({
//     'title': title,
//     'content': content,
//   });
//
//   if (files != null && files.length > 0) {
//     for (PickedFile file in files) {
//       formData.files.add(
//         MapEntry(
//           'files',
//           await MultipartFile.fromFile(file.path,
//               filename: file.path.split('/').last),
//         ),
//       );
//     }
//   }
//
//   bool? isSuccess = await postMethods<bool?>(
//     url: '/api/mail/create',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) {
//       final isSuccess = map['success'] as bool;
//       return isSuccess;
//     },
//     body: formData,
//   );
//
//   return isSuccess ?? false;
// }
//
// static Future<ModelMailSupportDoc?> getMails(
//     {int page = 1, int size = 10}) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelMailSupportDoc?>(
//     url: '/api/mail/me',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => ModelMailSupportDoc.fromJson(map['data']),
//     query: {
//       'page': page,
//       'size': size,
//     },
//   );
// }
//
// static Future<ModelMailReplyDoc?> getMailReply(String id,
//     {int page = 1, int size = 10}) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelMailReplyDoc?>(
//     url: '/api/mail/replies/$id',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => ModelMailReplyDoc.fromJson(map['data']),
//     query: {
//       'page': page,
//       'size': size,
//     },
//   );
// }
//
// static Future<int> getTotalChapters(String novelId) async {
//   Dio dio = Dio(options);
//
//   int? total = await getData<int?>(
//     url: '/api/chapters/total/$novelId',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => map['data'] as int,
//   );
//
//   return total ?? 0;
// }
//
// static Future<String> getContent(String contentId) async {
//   BaseOptions options = BaseOptions(
//     baseUrl: "https://" + "lolynovel.com",
//     connectTimeout: kDefaultTimeOut,
//     receiveTimeout: kDefaultTimeOut,
//   );
//
//   Dio dio = Dio(options);
//
//   try {
//     Response<String> res = await dio.get(
//       '/chapters/c-public/$contentId',
//     );
//
//     // CustomLog.log(res.data);
//
//     return res.data ?? "";
//   } on DioError catch (e) {
//     CustomLog.log(e);
//     return "";
//   } catch (e) {
//     CustomLog.log(e);
//     return "";
//   }
// }
//
// static Future<bool> unlockMultiple({
//   required String novelId,
//   required String authorUsername,
//   required List<int> indexes,
// }) async {
//   Dio dio = Dio(options);
//
//   CustomLog.log(novelId);
//
//   bool? isSuccess = await postMethods<bool?>(
//     url: '/api/user/unlock-chapter-all/multiple',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) {
//       final isSuccess = map['success'] as bool;
//       return isSuccess;
//     },
//     body: {
//       'novelId': novelId,
//       'indexes': indexes,
//       'authorUsername': authorUsername,
//     },
//   );
//
//   return isSuccess ?? false;
// }
//
// static Future<ModelRechargeHistoryDoc?> getRechargeHistory(
//     {int page = 1, int size = 10}) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelRechargeHistoryDoc?>(
//     url: '/api/recharge-history/me',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => ModelRechargeHistoryDoc.fromJson(map['data']),
//     query: {
//       'page': page,
//       'size': size,
//     },
//   );
// }
//
// static Future<bool> addNewRechargeHistory({
//   required String packageId,
//   required double price,
// }) async {
//   Dio dio = Dio(options);
//
//   bool? isSuccess = await postMethods<bool?>(
//     url: '/api/recharge-history/new',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) {
//       final isSuccess = map['success'] as bool;
//       return isSuccess;
//     },
//     body: {
//       'packageId': packageId,
//       'price': price,
//     },
//   );
//
//   return isSuccess ?? false;
// }
//
// static Future<ModelVoucherHistoryDoc?> getVoucherHistory({
//   int page = 1,
//   int size = 10,
// }) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelVoucherHistoryDoc?>(
//     url: '/api/user/vouchers/history',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => ModelVoucherHistoryDoc.fromJson(map['data']),
//     query: {
//       'page': page,
//       'size': size,
//     },
//   );
// }
//
// static Future<ModelUserDailyMission?> getUserDailyMission({
//   int page = 1,
//   int size = 10,
// }) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelUserDailyMission?>(
//     url: '/api/user/daily-missions',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => ModelUserDailyMission.fromJson(map['data']),
//   );
// }
//
// static Future<bool> claimMissionRewards({
//   required int missionId,
//   required int voucherQuantity,
// }) async {
//   Dio dio = Dio(options);
//
//   bool? isSuccess = await postMethods<bool?>(
//     url: '/api/user/daily-missions/claim',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) {
//       final isSuccess = map['success'] as bool;
//       return isSuccess;
//     },
//     body: {
//       'missionId': missionId,
//       'voucherQuantity': voucherQuantity,
//     },
//   );
//
//   return isSuccess ?? false;
// }
//
// static Future<bool> updateDailyMission({
//   int? purchasedCount,
//   int? readingTime,
// }) async {
//   Dio dio = Dio(options);
//
//   bool? isSuccess = await putMethods<bool?>(
//     url: '/api/user/daily-missions',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) {
//       final isSuccess = map['success'] as bool;
//       return isSuccess;
//     },
//     body: {
//       'purchasedCoinCount': purchasedCount,
//       'readingTime': readingTime,
//     },
//   );
//
//   return isSuccess ?? false;
// }
//
// static Future<bool> updateNovelStats({
//   required String id,
//   required String type,
// }) async {
//   Dio dio = Dio(options);
//
//   bool? isSuccess = await putMethods<bool?>(
//     url: '/api/novels/$id/$type',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) {
//       final isSuccess = map['success'] as bool;
//       return isSuccess;
//     },
//   );
//
//   return isSuccess ?? false;
// }
//
// static Future<ModelNewNovelDoc?> queryNovels({
//   int page = 1,
//   int size = 10,
//   required Map<String, dynamic> query,
// }) async {
//   Dio dio = Dio(options);
//
//   return await getData<ModelNewNovelDoc?>(
//     url: '/api/novels',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => ModelNewNovelDoc.fromJson(map['data']),
//     query: query,
//   );
// }
//
// static Future<SettingsModel?> getSettings() async {
//   Dio dio = Dio(options);
//
//   return await getData<SettingsModel?>(
//     url: '/api/settings',
//     accessToken: GetX.Get.find<Controller>().token.value,
//     dio: dio,
//     asModel: (map) => SettingsModel.fromJson(map['data']),
//   );
// }
}
