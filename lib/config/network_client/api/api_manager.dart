part of 'api.dart';

/// enum of apiTypes available to use.
enum APIType {
  /// post
  tPost,

  /// get
  tGet,

  /// put
  tPut,
}

/// Base Class of the application to handle all APIS.
class API {
  // static final client =
  //   InterceptedClient.build(interceptors: [LoggerInterceptor()]);
  /// base function of APIs.
  static Future<Either<Exception, dynamic>> callAPI1(
    BuildContext context, {
    required String url,
    required APIType type,
    Map<String, dynamic>? body,
    bool isFileUpload = false,
    List<File>? fileList,
    List<String>? fileKey,
    Map<String, String>? header,
    bool showSuccessMessage = false,
    bool showErrorMessage = false,
  }) async {
    EncryptionModel encryptionModel = EncryptionModel();
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        http.Client client = InterceptedClient.build(
          interceptors: [LoggerInterceptor()],
          // client: IOClient(
          //   HttpClient()
          //     ..badCertificateCallback = badCertificateCallback
          //     ..findProxy = findProxy,
          // )
        );
        http.Response apiResponse;
        // String apiBody = jsonEncode(body);
        dynamic apiBody = body;

        Map<String, String> appHeader = {};
        // appHeader.addAll({"Accept": "application/json","Content-Type": "application/json"});

        /// if there are any other header for different kind of apis then attach
        /// dynamically passed parameters.
        if (header != null) {
          appHeader.addAll(header);
        }
        String token = await SharedPref.getUserToken() ?? '';
        appHeader.addIf(token.isNotEmpty, 'Authorization', token);

        /// [POST CALL]
        if (type == APIType.tPost) {
          // assert(body != null);
          // appHeader.addAll({
          //   'Content-type': 'application/json',
          //   'Accept': 'application/json',
          // });

          /// call the api with the specified url using post method.
          if (isFileUpload) {
            var request = http.MultipartRequest("POST", Uri.parse(url));
            request.headers['Authorization'] = token;
            if (apiBody != null) {
              String encryptedData = encryptionModel.encryptData(apiBody);
              request.fields["encrypted_data"] = encryptedData;
            }

            body?.forEach((key, value) {
              request.fields[key.toString()] = value.toString();
            });

            if (fileList != null && fileList.isNotEmpty) {
              for (int i = 0; i < fileList.length; i++) {
                var fileStream = http.ByteStream(fileList[i].openRead());
                var fileLength = await fileList[i].length();
                var multipartFile = http.MultipartFile(
                  fileKey![i], // This is the field name on the server side
                  fileStream,
                  fileLength,
                  filename: fileList[i].path.split('/').last,
                );
                request.files.add(multipartFile);
              }
            }
            http.StreamedResponse res = await request.send().timeout(
              const Duration(seconds: timeoutDuration),
            );
            apiResponse = await http.Response.fromStream(res);
          } else {
            print("API Body :: ${apiBody}");

            if (apiBody != null)
              print(
                "API Body :: encrypted_data ${encryptionModel.encryptData(apiBody)}",
              );
            apiResponse = await client
                .post(
                  Uri.parse(url),
                  body:
                      apiBody != null
                          ? {
                            "encrypted_data": encryptionModel.encryptData(
                              apiBody,
                            ),
                          }
                          : null,
                  headers: appHeader,
                )
                .timeout(const Duration(seconds: timeoutDuration));

            print(apiResponse.body);
          }
        }
        /// [GET CALL]
        else if (type == APIType.tGet) {
          /// call the api with the specified url using get method.
          apiResponse = await client
              .get(Uri.parse(url), headers: appHeader)
              .timeout(const Duration(seconds: timeoutDuration));
        } else {
          /// call the api with hte specified url using put method.
          apiResponse = await client
              .put(Uri.parse(url), body: apiBody, headers: appHeader)
              .timeout(const Duration(seconds: timeoutDuration));
        }

        late Map<String, dynamic> response;
        if (apiResponse.headers['content-type'] == 'application/pdf') {
          response = {'success': 200};
        } else {
          response = jsonDecode(apiResponse.body);
        }
        print("Response ::: ${response}");
        print("Response ::: ${apiResponse.statusCode}");

        ///============================================================================================================

        switch (apiResponse.statusCode) {
          case 200:
            if (response.containsKey("error")) {
              print("Error validsation :: ${response['error']}");
              AuthorizationException().showToast(context, response['error']);
              return Left(AuthorizationException());
            }

            //// if the api is returning the pdf then direct send the file data..
            // if (apiResponse.headers["content-type"] == "application/pdf") {
            //   return Right(apiResponse.bodyBytes);
            // }
            if (response['success']) {
              if (response.containsKey("response")) {
                String decryptedResponse = encryptionModel.decryptData(
                  response['response'],
                );
                if (showSuccessMessage) {
                  Get.dialog(
                    barrierDismissible: false,
                    ResultDialog(
                      title: "Success",
                      positiveButtonText: "Dismiss",
                      showCloseButton: false,
                      onPositveTap: () async {
                        Get.back(); // close dialog
                      },
                      descriptionWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          GestureDetector(
                            child: Text(
                              response['message'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      description: '',
                    ),
                  );
                }
                print("Response message:: ${decryptedResponse}");
                return Right(response);
              } else {
                if (showSuccessMessage) {
                  Get.dialog(
                    barrierDismissible: false,
                    ResultDialog(
                      title: "Success",
                      positiveButtonText: "Dismiss",
                      showCloseButton: false,
                      onPositveTap: () async {
                        Get.back(); // close dialog
                      },
                      descriptionWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          GestureDetector(
                            child: Text(
                              response['message'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      description: '',
                    ),
                  );
                }
              }
              return Right(response);
            } else {
              return Left(GeneralAPIException());
            }

          case 500:
            // server error !
            /// when the error is from server side then it manage the response
            /// and show the snack accordingly.
            print("response:111: $response");
            if (!response['success']) {
              if (response.containsKey('message')) {
                if (showErrorMessage) {
                  ServerException().showToast(context, response['message']);
                }
              } else if (response.containsKey('errors')) {
                response['errors'].forEach((key, value) {
                  print("Error Message : ${value}");
                  if (showErrorMessage) {
                    ServerException().showToast(context, value[0]);
                  }
                });
              }
            }
            return Right(response);

          case 404: // page not found !

            /// when the page called from the application is not found
            /// then it show the message.
            if (!response['success']) {
              PageNotFoundException().showToast(context, response['message']);
            }
            return Left(PageNotFoundException());
          case 400: // bad request !

            /// when the request is made with some mistakes or bad or
            /// improper parameters this part will execute.
            if (!response['success']) {
              BadRequestException().showToast(context, response['message']);
            }
            return Left(BadRequestException());

          case 401:

            /// when there are some authorization error.

            /// token will expire after some time..
            /// so, when user call api with the old token then user again need
            /// to take new token using the login api.
            /// so, to get new token user will redirected to the login screen
            /// when get bellow error message from api.
            if (!response['success']) {
              AuthorizationException().showToast(context, response['message']);
            }
            return Left(AuthorizationException());
          default:

            /// when there is some other errors like server, page-not-found,
            /// bad connection then it will return null.
            GeneralAPIException().showToast(context, 'Something went wrong..');
            return Left(GeneralAPIException());
        }
      } on Exception catch (e) {
        print("Exception:: $e");
        if (e is TimeoutException) {
          GeneralAPIException().showToast(
            context,
            "Request timed out. Please try again later.",
          );
          return Left(GeneralAPIException());
        } else if (e is SocketException) {
          print("Error: ${e}");
          GeneralAPIException().showToast(
            context,
            "No Internet connection. Please check your connection and try again.",
          );
          return Left(GeneralAPIException());
        } else if (e is HttpException) {
          GeneralAPIException().showToast(
            context,
            "Failed to connect to the server. Please try again.",
          );
          return Left(GeneralAPIException());
        } else if (e is FormatException) {
          if (showErrorMessage) {
            GeneralAPIException().showToast(
              context,
              "Bad response format. Please try again later.",
            );
          }
          return Left(GeneralAPIException());
        }
        if (showErrorMessage) {
          APIException(message: e.toString()).showToast(context);
        }
        return Left(APIException(message: e.toString()));
      } catch (e) {
        debugPrint("Error123:::: ${e.toString()}");

        if (showErrorMessage) {
          APIException(message: e.toString()).showToast(context);
        }
        return Left(APIException(message: e.toString()));
      }
    } else {
      debugPrint('No Internet!');
      NoInternetException();
      return Left(NoInternetException());
    }
  }

  static Future<Either<Exception, dynamic>> callAPI(
    BuildContext context, {
    required String url,
    required APIType type,
    Map<String, dynamic>? body,
    bool isFileUpload = false,
    List<File>? fileList,
    List<String>? fileKey,
    Map<String, String>? header,
    bool showSuccessMessage = false,
    bool showErrorMessage = false,
  }) async {
    EncryptionModel encryptionModel = EncryptionModel();
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        http.Client client = InterceptedClient.build(
          interceptors: [LoggerInterceptor()],
          // client: IOClient(
          //   HttpClient()
          //     ..badCertificateCallback = badCertificateCallback
          //     ..findProxy = findProxy,
          // )
        );
        http.Response apiResponse;
        // String apiBody = jsonEncode(body);
        dynamic apiBody = body;

        Map<String, String> appHeader = {};
        // appHeader.addAll({"Accept": "application/json","Content-Type": "application/json"});

        /// if there are any other header for different kind of apis then attach
        /// dynamically passed parameters.
        if (header != null) {
          appHeader.addAll(header);
        }
        String token = await SharedPref.getUserToken() ?? '';
        appHeader.addIf(token.isNotEmpty, 'Authorization', token);

        /// [POST CALL]
        if (type == APIType.tPost) {
          // assert(body != null);
          // appHeader.addAll({
          //   'Content-type': 'application/json',
          //   'Accept': 'application/json',
          // });

          /// call the api with the specified url using post method.
          if (isFileUpload) {
            var request = http.MultipartRequest("POST", Uri.parse(url));
            request.headers['Authorization'] = token;
            if (apiBody != null) {
              String encryptedData = encryptionModel.encryptData(apiBody);
              request.fields["encrypted_data"] = encryptedData;
            }

            body?.forEach((key, value) {
              request.fields[key.toString()] = value.toString();
            });

            if (fileList != null && fileList.isNotEmpty) {
              for (int i = 0; i < fileList.length; i++) {
                var fileStream = http.ByteStream(fileList[i].openRead());
                var fileLength = await fileList[i].length();
                var multipartFile = http.MultipartFile(
                  fileKey![i], // This is the field name on the server side
                  fileStream,
                  fileLength,
                  filename: fileList[i].path.split('/').last,
                );
                request.files.add(multipartFile);
              }
            }
            http.StreamedResponse res = await request.send().timeout(
              const Duration(seconds: timeoutDuration),
            );
            apiResponse = await http.Response.fromStream(res);
          } else {
            print("API Body :: ${apiBody}");

            if (apiBody != null)
              print(
                "API Body :: encrypted_data ${encryptionModel.encryptData(apiBody)}",
              );
            apiResponse = await client
                .post(
                  Uri.parse(url),
                  body:
                      apiBody != null
                          ? {
                            "encrypted_data": encryptionModel.encryptData(
                              apiBody,
                            ),
                          }
                          : null,
                  headers: appHeader,
                )
                .timeout(const Duration(seconds: timeoutDuration));

            print(apiResponse.body);
          }
        }
        /// [GET CALL]
        else if (type == APIType.tGet) {
          /// call the api with the specified url using get method.
          apiResponse = await client
              .get(Uri.parse(url), headers: appHeader)
              .timeout(const Duration(seconds: timeoutDuration));
        } else {
          /// call the api with hte specified url using put method.
          apiResponse = await client
              .put(Uri.parse(url), body: apiBody, headers: appHeader)
              .timeout(const Duration(seconds: timeoutDuration));
        }

        late Map<String, dynamic> response;
        if (apiResponse.headers['content-type'] == 'application/pdf') {
          response = {'success': 200};
        } else {
          response = jsonDecode(apiResponse.body);
        }
        print("Response ::: ${response}");
        print("Response ::: ${apiResponse.statusCode}");

        ///============================================================================================================

        switch (apiResponse.statusCode) {
          case 200:
            if (response.containsKey("error")) {
              print("Error validsation :: ${response['error']}");
              AuthorizationException().showToast(context, response['error']);
              return Left(AuthorizationException());
            }

            //// if the api is returning the pdf then direct send the file data..
            // if (apiResponse.headers["content-type"] == "application/pdf") {
            //   return Right(apiResponse.bodyBytes);
            // }
            if (response['success']) {
              if (response.containsKey("response")) {
                String decryptedResponse = encryptionModel.decryptData(
                  response['response'],
                );
                if (showSuccessMessage) {
                  Get.dialog(
                    barrierDismissible: false,
                    ResultDialog(
                      title: "Success",
                      positiveButtonText: "Dismiss",
                      showCloseButton: false,
                      onPositveTap: () async {
                        Get.back(); // close dialog
                      },
                      descriptionWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          GestureDetector(
                            child: Text(
                              response['message'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      description: '',
                    ),
                  );
                }
                print("Response message:: ${decryptedResponse}");
                return Right(decryptedResponse);
              } else {
                if (showSuccessMessage) {
                  Get.dialog(
                    barrierDismissible: false,
                    ResultDialog(
                      title: "Success",
                      positiveButtonText: "Dismiss",
                      showCloseButton: false,
                      onPositveTap: () async {
                        Get.back(); // close dialog
                      },
                      descriptionWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          GestureDetector(
                            child: Text(
                              response['message'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      description: '',
                    ),
                  );
                }
              }
              return Right(response);
            } else {
              return Left(GeneralAPIException());
            }

          case 500:
            // server error !
            /// when the error is from server side then it manage the response
            /// and show the snack accordingly.
            print("response:111: $response");
            if (!response['success']) {
              if (response.containsKey('message')) {
                if (showErrorMessage) {
                  ServerException().showToast(context, response['message']);
                }
              } else if (response.containsKey('errors')) {
                response['errors'].forEach((key, value) {
                  print("Error Message : ${value}");
                  if (showErrorMessage) {
                    ServerException().showToast(context, value[0]);
                  }
                });
              }
            }
            return Right(response);

          case 404: // page not found !

            /// when the page called from the application is not found
            /// then it show the message.
            if (!response['success']) {
              PageNotFoundException().showToast(context, response['message']);
            }
            return Left(PageNotFoundException());
          case 400: // bad request !

            /// when the request is made with some mistakes or bad or
            /// improper parameters this part will execute.
            if (!response['success']) {
              BadRequestException().showToast(context, response['message']);
            }
            return Left(BadRequestException());

          case 401:

            /// when there are some authorization error.

            /// token will expire after some time..
            /// so, when user call api with the old token then user again need
            /// to take new token using the login api.
            /// so, to get new token user will redirected to the login screen
            /// when get bellow error message from api.
            if (!response['success']) {
              AuthorizationException().showToast(context, response['message']);
            }
            return Left(AuthorizationException());
          default:

            /// when there is some other errors like server, page-not-found,
            /// bad connection then it will return null.
            GeneralAPIException().showToast(context, 'Something went wrong..');
            return Left(GeneralAPIException());
        }
      } on Exception catch (e) {
        print("Exception:: $e");
        if (e is TimeoutException) {
          GeneralAPIException().showToast(
            context,
            "Request timed out. Please try again later.",
          );
          return Left(GeneralAPIException());
        } else if (e is SocketException) {
          print("Error: ${e}");
          GeneralAPIException().showToast(
            context,
            "No Internet connection. Please check your connection and try again.",
          );
          return Left(GeneralAPIException());
        } else if (e is HttpException) {
          GeneralAPIException().showToast(
            context,
            "Failed to connect to the server. Please try again.",
          );
          return Left(GeneralAPIException());
        } else if (e is FormatException) {
          if (showErrorMessage) {
            GeneralAPIException().showToast(
              context,
              "Bad response format. Please try again later.",
            );
          }
          return Left(GeneralAPIException());
        }
        if (showErrorMessage) {
          APIException(message: e.toString()).showToast(context);
        }
        return Left(APIException(message: e.toString()));
      } catch (e) {
        debugPrint("Error123:::: ${e.toString()}");

        if (showErrorMessage) {
          APIException(message: e.toString()).showToast(context);
        }
        return Left(APIException(message: e.toString()));
      }
    } else {
      debugPrint('No Internet!');
      NoInternetException();
      return Left(NoInternetException());
    }
  }

  static Future<Either<Exception, dynamic>> callAPI3(
    BuildContext context, {
    required String url,
    required APIType type,
    Map<String, dynamic>? body,
    bool isFileUpload = false,
    List<File>? fileList,
    List<String>? fileKey,
    Map<String, String>? header,
    bool showSuccessMessage = false,
    bool showErrorMessage = false,
  }) async {
    EncryptionModel encryptionModel = EncryptionModel();
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        http.Client client = InterceptedClient.build(
          interceptors: [LoggerInterceptor()],
          // client: IOClient(
          //   HttpClient()
          //     ..badCertificateCallback = badCertificateCallback
          //     ..findProxy = findProxy,
          // )
        );
        http.Response apiResponse;
        // String apiBody = jsonEncode(body);
        dynamic apiBody = body;

        Map<String, String> appHeader = {};
        // appHeader.addAll({"Accept": "application/json","Content-Type": "application/json"});

        /// if there are any other header for different kind of apis then attach
        /// dynamically passed parameters.
        if (header != null) {
          appHeader.addAll(header);
        }
        String token = await SharedPref.getUserToken() ?? '';
        appHeader.addIf(token.isNotEmpty, 'Authorization', token);

        /// [POST CALL]
        if (type == APIType.tPost) {
          // assert(body != null);
          // appHeader.addAll({
          //   'Content-type': 'application/json',
          //   'Accept': 'application/json',
          // });

          /// call the api with the specified url using post method.
          if (isFileUpload) {
            var request = http.MultipartRequest("POST", Uri.parse(url));
            request.headers['Authorization'] = token;
            if (apiBody != null) {
              String encryptedData = encryptionModel.encryptData(apiBody);
              request.fields["encrypted_data"] = encryptedData;
            }

            body?.forEach((key, value) {
              request.fields[key.toString()] = value.toString();
            });

            if (fileList != null && fileList.isNotEmpty) {
              for (int i = 0; i < fileList.length; i++) {
                var fileStream = http.ByteStream(fileList[i].openRead());
                var fileLength = await fileList[i].length();
                var multipartFile = http.MultipartFile(
                  fileKey![i], // This is the field name on the server side
                  fileStream,
                  fileLength,
                  filename: fileList[i].path.split('/').last,
                );
                request.files.add(multipartFile);
              }
            }
            http.StreamedResponse res = await request.send().timeout(
              const Duration(seconds: timeoutDuration),
            );
            apiResponse = await http.Response.fromStream(res);
          } else {
            print("API Body :: ${apiBody}");

            if (apiBody != null) print("API Body :: encrypted_data ${apiBody}");
            apiResponse = await client
                .post(Uri.parse(url), body: apiBody, headers: appHeader)
                .timeout(const Duration(seconds: timeoutDuration));

            print(apiResponse.body);
          }
        }
        /// [GET CALL]
        else if (type == APIType.tGet) {
          /// call the api with the specified url using get method.
          apiResponse = await client
              .get(Uri.parse(url), headers: appHeader)
              .timeout(const Duration(seconds: timeoutDuration));
        } else {
          /// call the api with hte specified url using put method.
          apiResponse = await client
              .put(Uri.parse(url), body: apiBody, headers: appHeader)
              .timeout(const Duration(seconds: timeoutDuration));
        }

        late Map<String, dynamic> response;
        if (apiResponse.headers['content-type'] == 'application/pdf') {
          response = {'success': 200};
        } else {
          response = jsonDecode(apiResponse.body);
        }
        print("Response ::: ${response}");
        print("Response ::: ${apiResponse.statusCode}");

        ///============================================================================================================

        switch (apiResponse.statusCode) {
          case 200:
            if (response.containsKey("error")) {
              print("Error validsation :: ${response['error']}");
              AuthorizationException().showToast(context, response['error']);
              return Left(AuthorizationException());
            }

            //// if the api is returning the pdf then direct send the file data..
            // if (apiResponse.headers["content-type"] == "application/pdf") {
            //   return Right(apiResponse.bodyBytes);
            // }
            if (response['success']) {
              if (response.containsKey("response")) {
                String decryptedResponse = encryptionModel.decryptData(
                  response['response'],
                );
                if (showSuccessMessage) {
                  Get.dialog(
                    barrierDismissible: false,
                    ResultDialog(
                      title: "Success",
                      positiveButtonText: "Dismiss",
                      showCloseButton: false,
                      onPositveTap: () async {
                        Get.back(); // close dialog
                      },
                      descriptionWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          GestureDetector(
                            child: Text(
                              response['message'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      description: '',
                    ),
                  );
                }
                print("Response message:: ${decryptedResponse}");
                return Right(decryptedResponse);
              } else {
                if (showSuccessMessage) {
                  Get.dialog(
                    barrierDismissible: false,
                    ResultDialog(
                      title: "Success",
                      positiveButtonText: "Dismiss",
                      showCloseButton: false,
                      onPositveTap: () async {
                        Get.back(); // close dialog
                      },
                      descriptionWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          GestureDetector(
                            child: Text(
                              response['message'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      description: '',
                    ),
                  );
                }
              }
              return Right(response);
            } else {
              return Left(GeneralAPIException());
            }

          case 500:
            // server error !
            /// when the error is from server side then it manage the response
            /// and show the snack accordingly.
            print("response:111: $response");
            if (!response['success']) {
              if (response.containsKey('message')) {
                if (showErrorMessage) {
                  ServerException().showToast(context, response['message']);
                }
              } else if (response.containsKey('errors')) {
                response['errors'].forEach((key, value) {
                  print("Error Message : ${value}");
                  if (showErrorMessage) {
                    ServerException().showToast(context, value[0]);
                  }
                });
              }
            }
            return Right(response);

          case 404: // page not found !

            /// when the page called from the application is not found
            /// then it show the message.
            if (!response['success']) {
              PageNotFoundException().showToast(context, response['message']);
            }
            return Left(PageNotFoundException());
          case 400: // bad request !

            /// when the request is made with some mistakes or bad or
            /// improper parameters this part will execute.
            if (!response['success']) {
              BadRequestException().showToast(context, response['message']);
            }
            return Left(BadRequestException());

          case 401:

            /// when there are some authorization error.

            /// token will expire after some time..
            /// so, when user call api with the old token then user again need
            /// to take new token using the login api.
            /// so, to get new token user will redirected to the login screen
            /// when get bellow error message from api.
            if (!response['success']) {
              AuthorizationException().showToast(context, response['message']);
            }
            return Left(AuthorizationException());
          default:

            /// when there is some other errors like server, page-not-found,
            /// bad connection then it will return null.
            GeneralAPIException().showToast(context, 'Something went wrong..');
            return Left(GeneralAPIException());
        }
      } on Exception catch (e) {
        print("Exception:: $e");
        if (e is TimeoutException) {
          GeneralAPIException().showToast(
            context,
            "Request timed out. Please try again later.",
          );
          return Left(GeneralAPIException());
        } else if (e is SocketException) {
          print("Error: ${e}");
          GeneralAPIException().showToast(
            context,
            "No Internet connection. Please check your connection and try again.",
          );
          return Left(GeneralAPIException());
        } else if (e is HttpException) {
          GeneralAPIException().showToast(
            context,
            "Failed to connect to the server. Please try again.",
          );
          return Left(GeneralAPIException());
        } else if (e is FormatException) {
          if (showErrorMessage) {
            GeneralAPIException().showToast(
              context,
              "Bad response format. Please try again later.",
            );
          }
          return Left(GeneralAPIException());
        }
        if (showErrorMessage) {
          APIException(message: e.toString()).showToast(context);
        }
        return Left(APIException(message: e.toString()));
      } catch (e) {
        debugPrint("Error123:::: ${e.toString()}");

        if (showErrorMessage) {
          APIException(message: e.toString()).showToast(context);
        }
        return Left(APIException(message: e.toString()));
      }
    } else {
      debugPrint('No Internet!');
      NoInternetException();
      return Left(NoInternetException());
    }
  }

  static Future<Either<Exception, dynamic>> callAPI2(
    BuildContext context, {
    required String url,
    required APIType type,
    Map<String, dynamic>? body,
    bool isFileUpload = false,
    List<File>? fileList,
    List<String>? fileKey,
    Map<String, String>? header,
    bool showSuccessMessage = false,
    bool showErrorMessage = false,
  }) async {
    EncryptionModel encryptionModel = EncryptionModel();
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        http.Client client = InterceptedClient.build(
          interceptors: [LoggerInterceptor()],
          // client: IOClient(
          //   HttpClient()
          //     ..badCertificateCallback = badCertificateCallback
          //     ..findProxy = findProxy,
          // )
        );
        http.Response apiResponse;
        // String apiBody = jsonEncode(body);
        dynamic apiBody = body;

        Map<String, String> appHeader = {};
        // appHeader.addAll({"Accept": "application/json","Content-Type": "application/json"});

        /// if there are any other header for different kind of apis then attach
        /// dynamically passed parameters.
        if (header != null) {
          appHeader.addAll(header);
        }
        String token = await SharedPref.getUserToken() ?? '';
        appHeader.addIf(token.isNotEmpty, 'Authorization', token);

        /// [POST CALL]
        if (type == APIType.tPost) {
          // assert(body != null);
          // appHeader.addAll({
          //   'Content-type': 'application/json',
          //   'Accept': 'application/json',
          // });

          /// call the api with the specified url using post method.
          if (isFileUpload) {
            var request = http.MultipartRequest("POST", Uri.parse(url));
            request.headers['Authorization'] = token;
            if (apiBody != null) {
              String encryptedData = encryptionModel.encryptData(apiBody);
              request.fields["encrypted_data"] = encryptedData;
            }

            body?.forEach((key, value) {
              request.fields[key.toString()] = value.toString();
            });

            if (fileList != null && fileList.isNotEmpty) {
              for (int i = 0; i < fileList.length; i++) {
                var fileStream = http.ByteStream(fileList[i].openRead());
                var fileLength = await fileList[i].length();
                var multipartFile = http.MultipartFile(
                  fileKey![i], // This is the field name on the server side
                  fileStream,
                  fileLength,
                  filename: fileList[i].path.split('/').last,
                );
                request.files.add(multipartFile);
              }
            }
            http.StreamedResponse res = await request.send().timeout(
              const Duration(seconds: timeoutDuration),
            );
            apiResponse = await http.Response.fromStream(res);
          } else {
            print("API Body :: ${apiBody}");

            if (apiBody != null)
              print(
                "API Body :: encrypted_data ${encryptionModel.encryptData(apiBody)}",
              );
            apiResponse = await client
                .post(
                  Uri.parse(url),
                  body:
                      apiBody != null
                          ? {
                            "encrypted_data": encryptionModel.encryptData(
                              apiBody,
                            ),
                          }
                          : null,
                  headers: appHeader,
                )
                .timeout(const Duration(seconds: timeoutDuration));

            print(apiResponse.body);
          }
        }
        /// [GET CALL]
        else if (type == APIType.tGet) {
          /// call the api with the specified url using get method.
          apiResponse = await client
              .get(Uri.parse(url), headers: appHeader)
              .timeout(const Duration(seconds: timeoutDuration));
        } else {
          /// call the api with hte specified url using put method.
          apiResponse = await client
              .put(Uri.parse(url), body: apiBody, headers: appHeader)
              .timeout(const Duration(seconds: timeoutDuration));
        }

        late Map<String, dynamic> response;
        if (apiResponse.headers['content-type'] == 'application/pdf') {
          response = {'success': 200};
        } else {
          response = jsonDecode(apiResponse.body);
        }
        print("Response ::: ${response}");

        ///============================================================================================================

        switch (apiResponse.statusCode) {
          case 200:
            if (response.containsKey("error")) {
              print("Error validsation :: ${response['error']}");
              AuthorizationException().showToast(context, response['error']);
              return Left(AuthorizationException());
            }

            if (response['success']) {
              if (response.containsKey("response")) {
                String decryptedResponse = encryptionModel.decryptData(
                  response['response'],
                );
                if (showSuccessMessage) {
                  Get.dialog(
                    barrierDismissible: false,
                    ResultDialog(
                      title: "Success",
                      positiveButtonText: "Dismiss",
                      showCloseButton: false,
                      onPositveTap: () async {
                        Get.back(); // close dialog
                      },
                      descriptionWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          GestureDetector(
                            child: Text(
                              response['message'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      description: '',
                    ),
                  );
                }
                print(
                  "Response message::${response['message']},${response['success']}, ${decryptedResponse}",
                );

                String a =
                    "{\"success\": ${response['success']},\"message\": \"${response['message']}\", \"response\": ${decryptedResponse}}";

                return Right(json.decode(a));
              } else {
                if (showSuccessMessage) {
                  Get.dialog(
                    barrierDismissible: false,
                    ResultDialog(
                      title: "Success",
                      positiveButtonText: "Dismiss",
                      showCloseButton: false,
                      onPositveTap: () async {
                        Get.back(); // close dialog
                      },
                      descriptionWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          GestureDetector(
                            child: Text(
                              response['message'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      description: '',
                    ),
                  );
                }
                String a =
                    "{\"success\": ${response['success']},\"message\": \"${response['message']}\"}";
                print(a);

                return Right(json.decode(a));
              }
            } else {
              return Left(GeneralAPIException());
            }

          case 500:
            // server error !
            /// when the error is from server side then it manage the response
            /// and show the snack accordingly.
            print("response:111: $response");
            if (!response['success']) {
              if (response.containsKey('message')) {
                if (showErrorMessage) {
                  ServerException().showToast(context, response['message']);
                }
              } else if (response.containsKey('errors')) {
                response['errors'].forEach((key, value) {
                  print("Error Message : ${value}");
                  if (showErrorMessage) {
                    ServerException().showToast(context, value[0]);
                  }
                });
              }
            }
            return Right(response);

          case 404: // page not found !

            /// when the page called from the application is not found
            /// then it show the message.
            if (!response['success']) {
              PageNotFoundException().showToast(context, response['message']);
            }
            return Left(PageNotFoundException());
          case 400: // bad request !

            /// when the request is made with some mistakes or bad or
            /// improper parameters this part will execute.
            if (!response['success']) {
              BadRequestException().showToast(context, response['message']);
            }
            return Left(BadRequestException());

          case 401:

            /// when there are some authorization error.

            /// token will expire after some time..
            /// so, when user call api with the old token then user again need
            /// to take new token using the login api.
            /// so, to get new token user will redirected to the login screen
            /// when get bellow error message from api.
            if (!response['success']) {
              AuthorizationException().showToast(context, response['message']);
            }
            return Left(AuthorizationException());
          default:

            /// when there is some other errors like server, page-not-found,
            /// bad connection then it will return null.
            GeneralAPIException().showToast(context, 'Something went wrong..');
            return Left(GeneralAPIException());
        }
      } on Exception catch (e) {
        print("Exception:: $e");
        if (e is TimeoutException) {
          GeneralAPIException().showToast(
            context,
            "Request timed out. Please try again later.",
          );
          return Left(GeneralAPIException());
        } else if (e is SocketException) {
          print("Error: ${e}");
          GeneralAPIException().showToast(
            context,
            "No Internet connection. Please check your connection and try again.",
          );
          return Left(GeneralAPIException());
        } else if (e is HttpException) {
          GeneralAPIException().showToast(
            context,
            "Failed to connect to the server. Please try again.",
          );
          return Left(GeneralAPIException());
        } else if (e is FormatException) {
          if (showErrorMessage) {
            GeneralAPIException().showToast(
              context,
              "Bad response format. Please try again later.",
            );
          }
          return Left(GeneralAPIException());
        }
        if (showErrorMessage) {
          APIException(message: e.toString()).showToast(context);
        }
        return Left(APIException(message: e.toString()));
      } catch (e) {
        debugPrint("Error123:::: ${e.toString()}");

        if (showErrorMessage) {
          APIException(message: e.toString()).showToast(context);
        }
        return Left(APIException(message: e.toString()));
      }
    } else {
      debugPrint('No Internet!');
      NoInternetException();
      return Left(NoInternetException());
    }
  }
}

String extractEmail(String input) {
  // Regular expression for matching emails
  final RegExp emailRegExp = RegExp(
    r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
    caseSensitive: false,
  );

  // Find first match in the input string
  final RegExpMatch? match = emailRegExp.firstMatch(input);

  // If a match is found, return the email
  if (match != null) {
    return match.group(0)!; // Extract the matched email
  }

  // Return an empty string if no match is found
  return "";
}
