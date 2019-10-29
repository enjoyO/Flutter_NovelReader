
import 'dart:convert';
import 'dart:math';

import 'package:flutter_reader/model/home/HomeDataModel.dart';
import 'package:flutter_reader/model/home/HotModel.dart';
import 'package:flutter_reader/model/home/NewModel.dart';
import 'package:flutter_reader/model/home/guess_like_model.dart';
import 'package:flutter_reader/model/home/recommend_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_reader/model/home/home_banner_model.dart';

const BSAuthorization = 'C2B92CBAA2B92328A330DC3D50B73CEE';

class HomeDao{
  static Future<HomePageBannerModel> fetchBanner(String channel) async{
    final response = await http.get('http://appapi.98nice.cn/api/topic/base?channel=${channel}&size=0&type=1&format=full'
    ,headers: {'BSAuthorization':BSAuthorization,'READING':'API'});
    if(response.statusCode == 200){
      //解决中文乱码
      Utf8Decoder utf8decoder = Utf8Decoder();
      final json = jsonDecode(utf8decoder.convert(response.bodyBytes));
      return HomePageBannerModel.fromJson(json);
    }
    else
      {
        throw Exception('加载banner接口失败');
      }
  }

  static Future<GuessModel> fetchGuess(String channel) async{
    final response = await http.get('http://appapi.98nice.cn/api/topic/gene?channel=${channel}&size=6&format=normal',
    headers: {'BSAuthorization':BSAuthorization,'READING':'API'});
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();
      final json = jsonDecode(utf8decoder.convert(response.bodyBytes));
      return GuessModel.fromJson(json);
    }
    else
      {
        throw Exception('加载guess接口失败');
      }
  }

  static Future<HotModel> fetchHot(String channel) async{
    final response = await http.get('http://appapi.98nice.cn/api/config/index?channel=${channel}',
    headers: {'BSAuthorization':BSAuthorization,'READING':'API'});
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();
      final json = jsonDecode(utf8decoder.convert(response.bodyBytes));
      return HotModel.fromJson(json);
    }
    else
    {
      throw Exception('加载hot接口失败');
    }
  }
  
  static Future<NewModel> fetchNew(String channel) async{
    final response = await http.get('http://appapi.98nice.cn/api/topic/base?channel=${channel}&size=3&type=-1&format=full',
    headers: {'BSAuthorization':BSAuthorization,'READING':'API'});
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();
      final json = jsonDecode(utf8decoder.convert(response.bodyBytes));
      return NewModel.fromJson(json);
    }
    else
    {
      throw Exception('加载new接口失败');
    }
  }

  static Future<RecommendModel> fetchRecommend(String channel) async{
    final response = await http.get('http://appapi.98nice.cn/api/topic/base?channel=${channel}&size=3&type=2&format=full',
        headers: {'BSAuthorization':BSAuthorization,'READING':'API'});
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();
      final json = jsonDecode(utf8decoder.convert(response.bodyBytes));
      return RecommendModel.fromJson(json);
    }
    else
    {
      throw Exception('加载recommend接口失败');
    }
  }
}