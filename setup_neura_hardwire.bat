@echo off
REM ========================================================
REM setup_neura_hardwire.bat
REM Scaffolds the sample + hard-wires env, config, and clients
REM ========================================================
SETLOCAL

REM 1) Create base folder & cd into it
mkdir "%~dp0neura-companion-sample" 2>nul
cd /d "%~dp0neura-companion-sample"

REM 2) Scaffold dirs
mkdir flutter_app\lib\services 2>nul
mkdir node_app\src 2>nul
mkdir .github\workflows 2>nul
mkdir docs     2>nul

REM 3) Create .env.example
( 
  echo API_BASE_URL=https://api.neuracompanion.app/v3
  echo JWT_TOKEN=<YOUR_JWT>
  echo TENANT_ID=<YOUR_TENANT_ID>
) > .env.example

REM Copy to apps
copy .env.example flutter_app\.env >nul
copy .env.example node_app\.env >nul

REM 4) Flutter: pubspec.yaml + flutter_dotenv + Config + API client
(
  echo name: neura_companion_sample
  echo description: Sample Flutter app wired to Neura Companion
  echo version: 1.0.0+1
  echo.
  echo environment:
  echo   sdk: ">=2.19.0 <3.0.0"
  echo.
  echo dependencies:
  echo   flutter:
  echo     sdk: flutter
  echo   flutter_dotenv: ^6.0.0
  echo   neuracompanion_sdk: ^3.0.0
  echo   dio: ^5.0.0
  echo   uuid: ^3.0.6
) > flutter_app\pubspec.yaml

REM Config.dart
(
  echo import "package:flutter_dotenv/flutter_dotenv.dart";
  echo.
  echo class Config {
  echo   static String get baseUrl   => dotenv.env['API_BASE_URL'] ?? '';
  echo   static String get jwtToken  => dotenv.env['JWT_TOKEN'] ?? '';
  echo   static String get tenantId  => dotenv.env['TENANT_ID'] ?? '';
  echo }
) > flutter_app\lib\config.dart

REM Api client
(
  echo import 'package:dio/dio.dart';
  echo import 'package:neuracompanion_sdk/neuracompanion_sdk.dart';
  echo import '../config.dart';
  echo import 'package:uuid/uuid.dart';
  echo.
  echo class ApiClient {
  echo   final NeuraCompanionApi api;
  echo.
  echo   ApiClient._(this.api);
  echo.
  echo   factory ApiClient() {
  echo     final dio = Dio(BaseOptions(
  echo       baseUrl: Config.baseUrl,
  echo       headers: {
  echo         'Authorization': 'Bearer ' + Config.jwtToken,
  echo         'Tenant-ID': Config.tenantId,
  echo         'X-Request-ID': Uuid().v4(),
  echo         'Accept-Version': 'application/vnd.neura.v3+json',
  echo       },
  echo     ))..interceptors.add(RateLimitInterceptor());
  echo.
  echo     return ApiClient._(NeuraCompanionApi(dio));
  echo   }
  echo }
  echo.
  echo class RateLimitInterceptor extends Interceptor {
  echo   @override
  echo   void onResponse(Response response, ResponseInterceptorHandler h) {
  echo     super.onResponse(response, h);
  echo   }
  echo }
) > flutter_app\lib\services\api_client.dart

REM 5) Node.js: package.json + dotenv + Config + API client
(
  echo {^
  echo   "name": "neura-node-sample",^
  echo   "version": "1.0.0",^
  echo   "dependencies": {^
  echo     "dotenv": "^16.0.3",^
  echo     "@neuracompanion/sdk": "^3.0.0",^
  echo     "axios": "^1.4.0",^
  echo     "uuid": "^9.0.0"^
  echo   },^
  echo   "scripts": {^
  echo     "start": "node src/index.js",^
  echo     "lint": "eslint src",^
  echo     "test": "jest"^
  echo   }^
  echo }^
) > node_app\package.json

REM config.js
(
  echo require('dotenv').config();
  echo;
  echo module.exports = {
  echo   baseUrl:   process.env.API_BASE_URL,
  echo   jwtToken:  process.env.JWT_TOKEN,
  echo   tenantId:  process.env.TENANT_ID,
  echo };
) > node_app\src\config.js

REM apiClient.js
(
  echo const { NeuraCompanionClient } = require('@neuracompanion/sdk');
  echo const axios = require('axios');
  echo const { v4: uuidv4 } = require('uuid');
  echo const Config = require('./config');
  echo;
  echo function createClient() {
  echo   return new NeuraCompanionClient({
  echo     basePath: Config.baseUrl,
  echo     accessToken: Config.jwtToken,
  echo     axiosInstance: axios.create({
  echo       headers: {
  echo         'X-Request-ID': uuidv4(),
  echo         'Tenant-ID': Config.tenantId,
  echo         'Accept-Version': 'application/vnd.neura.v3+json',
  echo       },
  echo     }),
  echo   });
  echo }
  echo;
  echo module.exports = { createClient };
) > node_app\src\apiClient.js

REM 6) Reminder: add secrets & env to your CI workflows manually:
echo(
echo -- Now add these to your GitHub secrets: API_BASE_URL, JWT_TOKEN, TENANT_ID
echo -- In each .github/workflows/*.yml, under "jobs: *: env:", include:
echo    API_BASE_URL: ${{ secrets.API_BASE_URL }}
echo    JWT_TOKEN:    ${{ secrets.JWT_TOKEN }}
echo    TENANT_ID:    ${{ secrets.TENANT_ID }}
)

REM 7) Install dependencies
echo Installing Flutter & Node dependencies...
cd flutter_app && flutter pub get && cd ..
cd node_app    && npm install      && cd ..

echo.
echo == Hard-wiring complete! ==
pause
@echo off
REM ========================================================
REM setup_neura_hardwire.bat
REM Scaffolds the sample + hard-wires env, config, and clients
REM ========================================================
SETLOCAL

REM 1) Create base folder & cd into it
mkdir "%~dp0neura-companion-sample" 2>nul
cd /d "%~dp0neura-companion-sample"

REM 2) Scaffold dirs
mkdir flutter_app\lib\services 2>nul
mkdir node_app\src 2>nul
mkdir .github\workflows 2>nul
mkdir docs     2>nul

REM 3) Create .env.example
( 
  echo API_BASE_URL=https://api.neuracompanion.app/v3
  echo JWT_TOKEN=<YOUR_JWT>
  echo TENANT_ID=<YOUR_TENANT_ID>
) > .env.example

REM Copy to apps
copy .env.example flutter_app\.env >nul
copy .env.example node_app\.env >nul

REM 4) Flutter: pubspec.yaml + flutter_dotenv + Config + API client
(
  echo name: neura_companion_sample
  echo description: Sample Flutter app wired to Neura Companion
  echo version: 1.0.0+1
  echo.
  echo environment:
  echo   sdk: ">=2.19.0 <3.0.0"
  echo.
  echo dependencies:
  echo   flutter:
  echo     sdk: flutter
  echo   flutter_dotenv: ^6.0.0
  echo   neuracompanion_sdk: ^3.0.0
  echo   dio: ^5.0.0
  echo   uuid: ^3.0.6
) > flutter_app\pubspec.yaml

REM Config.dart
(
  echo import "package:flutter_dotenv/flutter_dotenv.dart";
  echo.
  echo class Config {
  echo   static String get baseUrl   => dotenv.env['API_BASE_URL'] ?? '';
  echo   static String get jwtToken  => dotenv.env['JWT_TOKEN'] ?? '';
  echo   static String get tenantId  => dotenv.env['TENANT_ID'] ?? '';
  echo }
) > flutter_app\lib\config.dart

REM Api client
(
  echo import 'package:dio/dio.dart';
  echo import 'package:neuracompanion_sdk/neuracompanion_sdk.dart';
  echo import '../config.dart';
  echo import 'package:uuid/uuid.dart';
  echo.
  echo class ApiClient {
  echo   final NeuraCompanionApi api;
  echo.
  echo   ApiClient._(this.api);
  echo.
  echo   factory ApiClient() {
  echo     final dio = Dio(BaseOptions(
  echo       baseUrl: Config.baseUrl,
  echo       headers: {
  echo         'Authorization': 'Bearer ' + Config.jwtToken,
  echo         'Tenant-ID': Config.tenantId,
  echo         'X-Request-ID': Uuid().v4(),
  echo         'Accept-Version': 'application/vnd.neura.v3+json',
  echo       },
  echo     ))..interceptors.add(RateLimitInterceptor());
  echo.
  echo     return ApiClient._(NeuraCompanionApi(dio));
  echo   }
  echo }
  echo.
  echo class RateLimitInterceptor extends Interceptor {
  echo   @override
  echo   void onResponse(Response response, ResponseInterceptorHandler h) {
  echo     super.onResponse(response, h);
  echo   }
  echo }
) > flutter_app\lib\services\api_client.dart

REM 5) Node.js: package.json + dotenv + Config + API client
(
  echo {^
  echo   "name": "neura-node-sample",^
  echo   "version": "1.0.0",^
  echo   "dependencies": {^
  echo     "dotenv": "^16.0.3",^
  echo     "@neuracompanion/sdk": "^3.0.0",^
  echo     "axios": "^1.4.0",^
  echo     "uuid": "^9.0.0"^
  echo   },^
  echo   "scripts": {^
  echo     "start": "node src/index.js",^
  echo     "lint": "eslint src",^
  echo     "test": "jest"^
  echo   }^
  echo }^
) > node_app\package.json

REM config.js
(
  echo require('dotenv').config();
  echo;
  echo module.exports = {
  echo   baseUrl:   process.env.API_BASE_URL,
  echo   jwtToken:  process.env.JWT_TOKEN,
  echo   tenantId:  process.env.TENANT_ID,
  echo };
) > node_app\src\config.js

REM apiClient.js
(
  echo const { NeuraCompanionClient } = require('@neuracompanion/sdk');
  echo const axios = require('axios');
  echo const { v4: uuidv4 } = require('uuid');
  echo const Config = require('./config');
  echo;
  echo function createClient() {
  echo   return new NeuraCompanionClient({
  echo     basePath: Config.baseUrl,
  echo     accessToken: Config.jwtToken,
  echo     axiosInstance: axios.create({
  echo       headers: {
  echo         'X-Request-ID': uuidv4(),
  echo         'Tenant-ID': Config.tenantId,
  echo         'Accept-Version': 'application/vnd.neura.v3+json',
  echo       },
  echo     }),
  echo   });
  echo }
  echo;
  echo module.exports = { createClient };
) > node_app\src\apiClient.js

REM 6) Reminder: add secrets & env to your CI workflows manually:
echo(
echo -- Now add these to your GitHub secrets: API_BASE_URL, JWT_TOKEN, TENANT_ID
echo -- In each .github/workflows/*.yml, under "jobs: *: env:", include:
echo    API_BASE_URL: ${{ secrets.API_BASE_URL }}
echo    JWT_TOKEN:    ${{ secrets.JWT_TOKEN }}
echo    TENANT_ID:    ${{ secrets.TENANT_ID }}
)

REM 7) Install dependencies
echo Installing Flutter & Node dependencies...
cd flutter_app && flutter pub get && cd ..
cd node_app    && npm install      && cd ..

echo.
echo == Hard-wiring complete! ==
pause
