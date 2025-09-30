import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/either.dart';
import 'package:geopay/config/config.dart';
import 'package:geopay/config/network_client/api/logger_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import '../../../core/core.dart';

part 'api_manager.dart';
part 'api_utilities.dart';
