import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';
import '../widgets/progress.dart';
import 'package:http/http.dart' as http;

abstract class BaseViewModel extends ChangeNotifier {
  late BuildContext context;

  setContext(BuildContext mContext) {
    context = mContext;
  }

  initView() {}

  initAnimation(TickerProvider provider){}
  disposeView() {}
  onResume() {}
  inActive() {}
  paused() {}
  detached() {}
  static ProgressDialog progressDialog = ProgressDialog();
  call({String host = "staging3.sourcecad.com",
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? params,
    // dynamic params,
    Map<String, String>? headers,
    Method method = Method.get,
    bool isShowLoader = true,
    required Function(int statusCode, String data) onSuccess}) {
    if (isShowLoader) {
      progressDialog.showProgressDialog(context);
    }

    var url = Uri.https(host, "api/$path", queryParameters);
    log(url.toString());
    final client = HttpClient();
    client.connectionTimeout = const Duration(seconds: 5);
    ////////
    var request = http.Request(method.value, url);
    log("PARAM::$params");
    // log("PARAM::$param");
    request.bodyFields = params ?? {};
    // request.body = jsonEncode(params);
    // if(params is String){
    //   request.body = params;
    // }else if(params is Map<String,String>){
    //   request.bodyFields = params;
    // }

    if (headers != null) {
      if(params is String) {
        headers.putIfAbsent("content-type", () => "application/x-www-form-urlencoded");
      }else{
        headers.putIfAbsent("content-type", () => "application/x-www-form-urlencoded");
      }
      request.headers.addAll(headers);
    } else {
      Map<String, String> defaultHeader = {};
      if(params is String) {
        defaultHeader.putIfAbsent("content-type", () => "application/x-www-form-urlencoded");
      }else{
        defaultHeader.putIfAbsent("content-type", () => "application/x-www-form-urlencoded");
      }
      request.headers.addAll(defaultHeader);
    }
    if(HiveUtils.getSession<String>(SessionKey.token,defaultValue:"").isNotEmpty){
      log("Bearer ${HiveUtils.getSession<String>(SessionKey.token,defaultValue:"")}");
      request.headers.putIfAbsent("Authorization", () => "Bearer ${HiveUtils.getSession<String>(SessionKey.token,defaultValue:"")}");
    }
    request.send().then((response) {

      if (isShowLoader) {
        progressDialog.dismissProgressDialog(context);
      }
      response.stream.bytesToString().then((data) {
        log("RES:::$data");
        log("RES_CODE:::$response");
        if (response.statusCode==200) {
          Map object = jsonDecode(data);
          if(object['status']=="success")
          {
            onSuccess(response.statusCode, data);
          }
          else{
            Fluttertoast.showToast(
              msg: jsonDecode(data)['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }

        } else if(response.statusCode == 422){
          Map object = jsonDecode(data);
          if (object['errors'] != null) {
            object['errors'].forEach((v) {
              Fluttertoast.showToast(
                msg: v,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
              );
            });
          }else if (object['message'] != null) {
            Fluttertoast.showToast(
              msg: object['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }
        }else {
          Fluttertoast.showToast(
            msg: jsonDecode(data)['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      });
    });
  }

  callMultiPart({String host = "anuda.academy",
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? params,
    Map<String, String>? headers,
    Method method = Method.get,
    File? file,
    String fileKey = "",
    bool isShowLoader = true,
    required Function(int statusCode, String data) onSuccess}) {
    if (isShowLoader) {
      progressDialog.showProgressDialog(context);
    }
    var url = Uri.https(host, "api/$path", queryParameters);
    log(url.toString());
    ////////
    var request = http.MultipartRequest(method.value, url);
    print("PARAM::${params.toString()}");
    request.fields.addAll(params ?? {});
    if(file != null) {
      request.files.add(
        http.MultipartFile(
          fileKey,
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
        ),
      );
    }
    if (headers != null) {
      headers.putIfAbsent("content-type", () => "multipart/form-data");
      request.headers.addAll(headers);
    } else {
      Map<String, String> defaultHeader = {
        'content-type': "multipart/form-data"
      };
      request.headers.addAll(defaultHeader);
    }
    if(HiveUtils.getSession<String>(SessionKey.token,defaultValue:"").isNotEmpty){
      request.headers.putIfAbsent("Authorization", () => "Bearer ${HiveUtils.getSession<String>(SessionKey.token,defaultValue:"")}");
    }
    request.send().then((response) {
      if (isShowLoader) {
        progressDialog.dismissProgressDialog(context);
      }
      response.stream.bytesToString().then((data) {
        log("RES:::$data");
        if (response.statusCode==200) {
          onSuccess(response.statusCode, data);
        }else if(response.statusCode == 422){
          Map object = jsonDecode(data);
          if (object['errors'] != null) {
            object['errors'].forEach((v) {
              Fluttertoast.showToast(
                msg: v,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
              );
            });
          }
        } else {
          Fluttertoast.showToast(
            msg: jsonDecode(data)['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      });
    });
  }
  callMultiPartFiles({String host = "anuda.academy",
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? params,
    Map<String, String>? headers,
    Method method = Method.get,
    File? file,
    File? file1,
    String fileKey = "",
    String fileKey1 = "",
    bool isShowLoader = true,
    required Function(int statusCode, String data) onSuccess}) {
    if (isShowLoader) {
      progressDialog.showProgressDialog(context);
    }
    var url = Uri.https(host, "api/$path", queryParameters);
    log(url.toString());
    ////////
    var request = http.MultipartRequest(method.value, url);
    print("PARAM::${params.toString()}");

    request.fields.addAll(params ?? {});
    if(file != null) {
      request.files.add(
        http.MultipartFile(
          fileKey,
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
        ),
      );
    }
    if(file1 != null) {
      request.files.add(
        http.MultipartFile(
          fileKey1,
          file1.readAsBytes().asStream(),
          file1.lengthSync(),
          filename: file1.path.split('/').last,
        ),
      );
    }
    if (headers != null) {
      headers.putIfAbsent("content-type", () => "multipart/form-data");
      request.headers.addAll(headers);
    } else {
      Map<String, String> defaultHeader = {
        'content-type': "multipart/form-data"
      };
      request.headers.addAll(defaultHeader);
    }
    if(HiveUtils.getSession<String>(SessionKey.token,defaultValue:"").isNotEmpty){
      request.headers.putIfAbsent("Authorization", () => "Bearer ${HiveUtils.getSession<String>(SessionKey.token,defaultValue:"")}");
    }
    request.send().then((response) {
      if (isShowLoader) {
        progressDialog.dismissProgressDialog(context);
      }
      response.stream.bytesToString().then((data) {
        log("RES:::$data");
        if (response.statusCode==200) {
          Map object = jsonDecode(data);
          if(object['status']==1)
          {
            onSuccess(response.statusCode, data);
          }
          else{
            Fluttertoast.showToast(
              msg: jsonDecode(data)['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }

        }
        else if(response.statusCode == 422){
          Map object = jsonDecode(data);
          if (object['errors'] != null) {
            object['errors'].forEach((v) {
              Fluttertoast.showToast(
                msg: v,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
              );
            });
          }
        } else {
          Fluttertoast.showToast(
            msg: jsonDecode(data)['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      });
    });
  }
  callMultiPartFile({String host = "anuda.academy",
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? params,
    Map<String, String>? headers,
    Method method = Method.get,
    List<http.MultipartFile>? files,
    bool isShowLoader = true,
    required Function(int statusCode, String data) onSuccess}) {
    if (isShowLoader) {
      progressDialog.showProgressDialog(context);
    }
    var url = Uri.https(host, "api/$path", queryParameters);
    log(url.toString());
    ////////
    var request = http.MultipartRequest(method.value, url);
    print("PARAM::${params.toString()}");
    request.fields.addAll(params ?? {});
    if(files != null) {
      request.files.addAll(files);
    }
    if (headers != null) {
      headers.putIfAbsent("content-type", () => "multipart/form-data");
      request.headers.addAll(headers);
    } else {
      Map<String, String> defaultHeader = {
        'content-type': "multipart/form-data"
      };
      request.headers.addAll(defaultHeader);
    }
    if(HiveUtils.getSession<String>(SessionKey.token,defaultValue:"").isNotEmpty){
      request.headers.putIfAbsent("Authorization", () => "Bearer ${HiveUtils.getSession<String>(SessionKey.token,defaultValue:"")}");
    }
    request.send().then((response) {
      if (isShowLoader) {
        progressDialog.dismissProgressDialog(context);
      }
      response.stream.bytesToString().then((data) {
        log("RES:::$data");
        if (response.statusCode < 400) {
          onSuccess(response.statusCode, data);
        }else if(response.statusCode == 422){
          Map object = jsonDecode(data);
          if (object['errors'] != null) {
            object['errors'].forEach((v) {
              Fluttertoast.showToast(
                msg: v,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
              );
            });
          }
        } else {
          Fluttertoast.showToast(
            msg: jsonDecode(data)['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      });
    });
  }


}
enum Method { post, get, delete, patch }

extension MethodValue on Method {
  String get value {
    switch (this) {
      case Method.post:
        return 'POST';
      case Method.get:
        return 'GET';
      case Method.delete:
        return 'DELETE';
      case Method.patch:
        return 'PATCH';
      default:
        return "";
    }
  }
}