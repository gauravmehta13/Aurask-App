import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../meta/Utility/Constants.dart';
import '../model/category.dart';
import '../model/question.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
const String baseUrl = "https://opentdb.com/api.php";
var dio = Dio();

Future<List> getMyCourses() async {
  var dio = Dio();
  final response = await dio.post(
      "https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=ORDER01&usecase=aurask&tenantUsecase=get",
      data: {
        "id": _auth.currentUser?.uid,
      });
  sharedPrefs.save("myCourses", response.data["resp"]);
  return response.data["resp"];
}

Future<List> getCourses() async {
  var dio = Dio();
  var resp = await dio.get(
    'https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/dynamic-ui?tenantSet_id=AURASK01&usecase=training',
  );

  var map = resp.data["resp"];
  sharedPrefs.save("courses", map);
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

Future login(id, email, name, refer) async {
  try {
    var dio = Dio();
    final response = await dio.post(
        "https://t2v0d33au7.execute-api.ap-south-1.amazonaws.com/Staging01/customerorder?tenantSet_id=SIGNUP&tenantUsecase=xyz&usecase=aurask",
        data: {
          "user": {
            "id": id,
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
