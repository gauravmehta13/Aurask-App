import 'dart:convert';
import 'package:aurask/models/category.dart';
import 'package:aurask/models/question.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "https://opentdb.com/api.php";
var dio = Dio();

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
