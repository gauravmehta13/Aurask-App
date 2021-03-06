import 'package:dio/dio.dart';

import '../../meta/Utility/Constants.dart';
import '../model/category.dart';
import '../model/question.dart';

const String baseUrl = "https://opentdb.com/api.php";
var dio = Dio();

Future<Map> getSeminarDetails(id) async {
  var dio = Dio();
  final response = await dio.post(
      "https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=AURASK01&usecase=liveSession&tenantUsecase=getLiveSession",
      data: {
        "id": id,
      });
  return response.data["resp"];
}

Future<Map> getCourseDetails(id) async {
  var dio = Dio();
  final response = await dio.post(
      "https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=AURASK01&usecase=course&tenantUsecase=getCourse",
      data: {
        "id": id,
      });
  return response.data["resp"];
}

Future<Map> getMyCourses() async {
  print("getting My Courses....");
  var dio = Dio();
  final response = await dio.post(
      "https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=AURASK01&usecase=aurask&tenantUsecase=getMyCourses",
      data: {
        "id": auth.currentUser?.uid,
      });

  sharedPrefs.save("myCourses", response.data["resp"]);
  print("My Courses Updated Successfully");
  return response.data["resp"];
}

Future<Map> getCourses() async {
  print("getting Courses....");
  var dio = Dio();
  var resp = await dio.get(
    'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/dynamic-ui?tenantSet_id=AURASK01&usecase=getAllCourses',
  );
  var map = resp.data["resp"];
  sharedPrefs.save("courses", map);
  print("Courses Updated Successfully");
  return map;
}

Future postUserDetails(id, experience) async {
  try {
    var dio = Dio();
    final response = await dio.post(
        "https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=SIGNUP&tenantUsecase=xyz&usecase=aurask",
        data: {
          "user": {
            "Phone": "0",
            "id": id,
            "experience": experience,
          }
        });
    print(response.data);
  } catch (e) {
    print(e);
  }
}

Future login(id, email, name, refer, img) async {
  try {
    var dio = Dio();
    final response = await dio.post(
        "https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=SIGNUP&tenantUsecase=xyz&usecase=aurask",
        data: {
          "user": {
            "id": id,
            "Phone": "0",
            "img": img,
            "email": email,
            "name": name ?? "",
            "refferedBy": refer
          }
        });
    print(response.data);
  } catch (e) {
    print(e);
  }
}

Future<List<Question>> getQuestions(
    Category category, int total, String difficulty) async {
  String url = "$baseUrl?amount=$total&category=${category.id}";
  if (difficulty.isNotEmpty) {
    url = "$url&difficulty=$difficulty";
  }
  var res = await dio.get(url);
  List<Map<String, dynamic>> questions =
      List<Map<String, dynamic>>.from(res.data["results"]);
  print(res.data["results"]);
  return Question.fromData(questions);
}
