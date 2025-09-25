import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import '../../core/constants/app_string.dart';
import '../../flavor_config.dart';
import '../repository/remote/crashlytics_repo.dart';
import '../services/local/connectivity_service.dart';
import '../services/service_locator.dart';

import 'api_exception.dart';
import 'auth_interceptor.dart';

part 'api_client.dart';
