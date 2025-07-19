@echo off
REM ===========@echo off
REM ========================================================
REM setup_neura_sample.bat
REM Scaffolds Neura Companion sample project + installs deps
REM ========================================================
SETLOCAL

REM 1) Create base directory & enter it
mkdir "%~dp0neura-companion-sample"
cd /d "%~dp0neura-companion-sample"

REM 2) Create directory structure
mkdir .github\workflows
mkdir docs
mkdir flutter_app\lib\services
mkdir node_app\src

REM 3) flutter_app/pubspec.yaml
(
  echo name: neura_companion_sample
  echo description: Sample Flutter app wired to Neura Companion
  echo version: 1.0.0+1
  echo.
  echo environment:
  echo   sdk: ">=2.19.0 ^<3.0.0"
  echo.
  echo dependencies:
  echo   flutter:
  echo     sdk: flutter
  echo   neuracompanion_sdk: ^3.0.0
  echo   dio: ^5.0.0
  echo   uuid: ^3.0.6
) > flutter_app\pubspec.yaml

REM 4) flutter_app/lib/services/api_client.dart
(
  echo import 'package:dio/dio.dart';
  echo import 'package:neuracompanion_sdk/neuracompanion_sdk.dart';
  echo import 'package:uuid/uuid.dart';
  echo.
  echo class ApiClient {
  echo   final NeuraCompanionApi api;
  echo.
  echo   ApiClient._(this.api);
  echo.
  echo   factory ApiClient^({
  echo     required String baseUrl,
  echo     required String jwtToken,
  echo     String? tenantId,
  echo   ^}) {
  echo     final dio = Dio^(BaseOptions^(
  echo       baseUrl: baseUrl,
  echo       headers: ^{
  echo         'Authorization': 'Bearer %%jwtToken%%',
  echo         if ^(tenantId != null^) 'Tenant-ID': tenantId,
  echo         'X-Request-ID': Uuid().v4(),
  echo         'Accept-Version': 'application/vnd.neura.v3+json',
  echo       ^},
  echo     ^))..interceptors.add(RateLimitInterceptor());
  echo.
  echo     return ApiClient._^(NeuraCompanionApi^(dio^));
  echo   }
  echo }
) > flutter_app\lib\services\api_client.dart

REM 5) node_app/package.json
(
  echo {
  echo   "name": "neura-node-sample",
  echo   "version": "1.0.0",
  echo   "dependencies": ^{
  echo     "@neuracompanion/sdk": "^3.0.0",
  echo     "axios": "^1.4.0",
  echo     "uuid": "^9.0.0"
  echo   ^},
  echo   "scripts": ^{
  echo     "start": "node src/index.js",
  echo     "lint": "eslint src",
  echo     "test": "jest"
  echo   ^}
  echo }
) > node_app\package.json

REM 6) node_app/src/apiClient.js
(
  echo import { NeuraCompanionClient } from '@neuracompanion/sdk';
  echo import axios from 'axios';
  echo import { v4 as uuidv4 } from 'uuid';
  echo.
  echo export function createClient(jwt, tenantId) ^{
  echo   return new NeuraCompanionClient^({
  echo     basePath: 'https://api.neuracompanion.app/v3',
  echo     accessToken: jwt,
  echo     axiosInstance: axios.create({
  echo       headers: ^{
  echo         'X-Request-ID': uuidv4(),
  echo         'Tenant-ID': tenantId,
  echo         'Accept-Version': 'application/vnd.neura.v3+json',
  echo       ^},
  echo     }),
  echo   });
  echo }
) > node_app\src\apiClient.js

REM 7) .github/workflows/flutter_ci.yml
(
  echo name: Flutter CI
  echo.
  echo on:
  echo   push:
  echo     branches: [ main ]
  echo   pull_request:
  echo     branches: [ main ]
  echo.
  echo jobs:
  echo   build-test:
  echo     runs-on: ubuntu-latest
  echo.
  echo     steps:
  echo     - uses: actions/checkout@v3
  echo.
  echo     - name: Set up Flutter
  echo       uses: subosito/flutter-action@v2
  echo       with:
  echo         flutter-version: '3.13.0'
  echo.
  echo     - name: Install dependencies
  echo       run: flutter pub get
  echo       working-directory: flutter_app
  echo.
  echo     - name: Analyze code
  echo       run: flutter analyze
  echo       working-directory: flutter_app
  echo.
  echo     - name: Run tests
  echo       run: flutter test --coverage
  echo       working-directory: flutter_app
  echo.
  echo     - name: Upload coverage report
  echo       uses: actions/upload-artifact@v3
  echo       with:
  echo         name: coverage-report
  echo         path: flutter_app/coverage
) > .github\workflows\flutter_ci.yml

REM 8) .github/workflows/node_ci.yml
(
  echo name: Node.js CI
  echo.
  echo on:
  echo   push:
  echo     branches: [ main ]
  echo   pull_request:
  echo     branches: [ main ]
  echo.
  echo jobs:
  echo   lint-test:
  echo     runs-on: ubuntu-latest
  echo.
  echo     steps:
  echo     - uses: actions/checkout@v3
  echo.
  echo     - name: Set up Node.js
  echo       uses: actions/setup-node@v4
  echo       with:
  echo         node-version: '18'
  echo.
  echo     - name: Install dependencies
  echo       run: npm ci
  echo       working-directory: node_app
  echo.
  echo     - name: Run linter
  echo       run: npm run lint
  echo       working-directory: node_app
  echo.
  echo     - name: Run tests
  echo       run: npm test
  echo       working-directory: node_app
  echo.
  echo     - name: Build (if applicable)
  echo       run: npm run build
  echo       working-directory: node_app
) > .github\workflows\node_ci.yml

REM 9) docs/partner-tutorial.md
(
  echo # Integrating with Neura Companion
  echo.
  echo Welcome! This tutorial walks you through getting your app wired up, running a quick call, and subscribing to webhooks.
  echo.
  echo ## Prerequisites
  echo.
  echo - You have a JWT token with scopes: health:read, memory:write, webhooks:write.
  echo - Base URL: https://api.neuracompanion.app/v3.
  echo.
  echo ## 1. Install SDK
  echo.
  echo ```bash
  echo # Dart:
  echo dart pub add neuracompanion_sdk
  echo.
  echo # Node:
  echo npm install @neuracompanion/sdk
  echo ```
  echo.
  echo ## 2. Initialize Client
  echo.
  echo Dart:
  echo ```dart
  echo final client = ApiClient(
  echo   baseUrl: 'https://api.neuracompanion.app/v3',
  echo   jwtToken: '<YOUR_JWT>',
  echo   tenantId: '<YOUR_TENANT_ID>',
  echo );
  echo ```
  echo.
  echo Node:
  echo ```js
  echo import { createClient } from './apiClient.js';
  echo const client = createClient('<YOUR_JWT>', '<YOUR_TENANT_ID>');
  echo ```
  echo.
  echo ## 3. Quick Calls
  echo.
  echo - **Health Check**
  echo   ```dart
  echo   final status = await client.healthApi.getHealth();
  echo   ```
  echo.
  echo - **Create a Memory**
  echo   ```js
  echo   const memory = await client.memory.createMemory({
  echo     title: 'Hello world',
  echo     content: 'This is a sample memory.'
  echo   });
  echo   ```
  echo.
  echo ## 4. Subscribe to Webhooks
  echo.
  echo 1. Create a webhook endpoint in your service.
  echo 2. Register it:
  echo    ```js
  echo    await client.webhooks.createWebhook({
  echo      event: 'memory.added',
  echo      callbackUrl: 'https://your.service/webhooks/neura',
  echo      secret: '<HMAC_SECRET>'
  echo    });
  echo    ```
  echo 3. Verify events by checking the X-Callback-Signature header.
  echo.
  echo ## 5. CI Integration
  echo.
  echo - Use the provided GitHub Actions YAML in .github/workflows to automate lint, test, and build on each PR.
  echo.
  echo ---
  echo.
  echo Happy building! Reach out at support@neuracompanion.app for questions.
) > docs\partner-tutorial.md

REM 10) Root README.md
(
  echo # Neura Companion Sample Project
  echo.
  echo This sample project demonstrates how to integrate your app with the Neura Companion API using Flutter and Node.js.
  echo.
  echo ## Structure
  echo.
  echo - .github/workflows: CI pipelines for Flutter and Node.js
  echo - docs: Partner tutorial markdown
  echo - flutter_app: Sample Flutter client
  echo - node_app: Sample Node.js client
  echo.
  echo ## Setup
  echo.
  echo ```bash
  echo cd neura-companion-sample
  echo flutter pub get   # in flutter_app
  echo npm ci             # in node_app
  echo ```
  echo.
  echo ## Run
  echo.
  echo ```bash
  echo flutter run --project flutter_app
  echo node node_app/src/index.js
  echo ```
) > README.md

REM 11) Install dependencies
echo.
echo Installing Flutter dependencies...
cd flutter_app
flutter pub get
cd ..

echo.
echo Installing Node.js dependencies...
cd node_app
npm ci
cd ..

echo.
echo Sample project setup complete!
pause
=============================================
REM setup_neura_sample.bat
REM Scaffolds Neura Companion sample project + installs deps
REM ========================================================
SETLOCAL

REM 1) Create base directory & enter it
mkdir "%~dp0neura-companion-sample"
cd /d "%~dp0neura-companion-sample"

REM 2) Create directory structure
mkdir .github\workflows
mkdir docs
mkdir flutter_app\lib\services
mkdir node_app\src

REM 3) flutter_app/pubspec.yaml
(
  echo name: neura_companion_sample
  echo description: Sample Flutter app wired to Neura Companion
  echo version: 1.0.0+1
  echo.
  echo environment:
  echo   sdk: ">=2.19.0 ^<3.0.0"
  echo.
  echo dependencies:
  echo   flutter:
  echo     sdk: flutter
  echo   neuracompanion_sdk: ^3.0.0
  echo   dio: ^5.0.0
  echo   uuid: ^3.0.6
) > flutter_app\pubspec.yaml

REM 4) flutter_app/lib/services/api_client.dart
(
  echo import 'package:dio/dio.dart';
  echo import 'package:neuracompanion_sdk/neuracompanion_sdk.dart';
  echo import 'package:uuid/uuid.dart';
  echo.
  echo class ApiClient {
  echo   final NeuraCompanionApi api;
  echo.
  echo   ApiClient._(this.api);
  echo.
  echo   factory ApiClient^({
  echo     required String baseUrl,
  echo     required String jwtToken,
  echo     String? tenantId,
  echo   ^}) {
  echo     final dio = Dio^(BaseOptions^(
  echo       baseUrl: baseUrl,
  echo       headers: ^{
  echo         'Authorization': 'Bearer %%jwtToken%%',
  echo         if ^(tenantId != null^) 'Tenant-ID': tenantId,
  echo         'X-Request-ID': Uuid().v4(),
  echo         'Accept-Version': 'application/vnd.neura.v3+json',
  echo       ^},
  echo     ^))..interceptors.add(RateLimitInterceptor());
  echo.
  echo     return ApiClient._^(NeuraCompanionApi^(dio^));
  echo   }
  echo }
) > flutter_app\lib\services\api_client.dart

REM 5) node_app/package.json
(
  echo {
  echo   "name": "neura-node-sample",
  echo   "version": "1.0.0",
  echo   "dependencies": ^{
  echo     "@neuracompanion/sdk": "^3.0.0",
  echo     "axios": "^1.4.0",
  echo     "uuid": "^9.0.0"
  echo   ^},
  echo   "scripts": ^{
  echo     "start": "node src/index.js",
  echo     "lint": "eslint src",
  echo     "test": "jest"
  echo   ^}
  echo }
) > node_app\package.json

REM 6) node_app/src/apiClient.js
(
  echo import { NeuraCompanionClient } from '@neuracompanion/sdk';
  echo import axios from 'axios';
  echo import { v4 as uuidv4 } from 'uuid';
  echo.
  echo export function createClient(jwt, tenantId) ^{
  echo   return new NeuraCompanionClient^({
  echo     basePath: 'https://api.neuracompanion.app/v3',
  echo     accessToken: jwt,
  echo     axiosInstance: axios.create({
  echo       headers: ^{
  echo         'X-Request-ID': uuidv4(),
  echo         'Tenant-ID': tenantId,
  echo         'Accept-Version': 'application/vnd.neura.v3+json',
  echo       ^},
  echo     }),
  echo   });
  echo }
) > node_app\src\apiClient.js

REM 7) .github/workflows/flutter_ci.yml
(
  echo name: Flutter CI
  echo.
  echo on:
  echo   push:
  echo     branches: [ main ]
  echo   pull_request:
  echo     branches: [ main ]
  echo.
  echo jobs:
  echo   build-test:
  echo     runs-on: ubuntu-latest
  echo.
  echo     steps:
  echo     - uses: actions/checkout@v3
  echo.
  echo     - name: Set up Flutter
  echo       uses: subosito/flutter-action@v2
  echo       with:
  echo         flutter-version: '3.13.0'
  echo.
  echo     - name: Install dependencies
  echo       run: flutter pub get
  echo       working-directory: flutter_app
  echo.
  echo     - name: Analyze code
  echo       run: flutter analyze
  echo       working-directory: flutter_app
  echo.
  echo     - name: Run tests
  echo       run: flutter test --coverage
  echo       working-directory: flutter_app
  echo.
  echo     - name: Upload coverage report
  echo       uses: actions/upload-artifact@v3
  echo       with:
  echo         name: coverage-report
  echo         path: flutter_app/coverage
) > .github\workflows\flutter_ci.yml

REM 8) .github/workflows/node_ci.yml
(
  echo name: Node.js CI
  echo.
  echo on:
  echo   push:
  echo     branches: [ main ]
  echo   pull_request:
  echo     branches: [ main ]
  echo.
  echo jobs:
  echo   lint-test:
  echo     runs-on: ubuntu-latest
  echo.
  echo     steps:
  echo     - uses: actions/checkout@v3
  echo.
  echo     - name: Set up Node.js
  echo       uses: actions/setup-node@v4
  echo       with:
  echo         node-version: '18'
  echo.
  echo     - name: Install dependencies
  echo       run: npm ci
  echo       working-directory: node_app
  echo.
  echo     - name: Run linter
  echo       run: npm run lint
  echo       working-directory: node_app
  echo.
  echo     - name: Run tests
  echo       run: npm test
  echo       working-directory: node_app
  echo.
  echo     - name: Build (if applicable)
  echo       run: npm run build
  echo       working-directory: node_app
) > .github\workflows\node_ci.yml

REM 9) docs/partner-tutorial.md
(
  echo # Integrating with Neura Companion
  echo.
  echo Welcome! This tutorial walks you through getting your app wired up, running a quick call, and subscribing to webhooks.
  echo.
  echo ## Prerequisites
  echo.
  echo - You have a JWT token with scopes: health:read, memory:write, webhooks:write.
  echo - Base URL: https://api.neuracompanion.app/v3.
  echo.
  echo ## 1. Install SDK
  echo.
  echo ```bash
  echo # Dart:
  echo dart pub add neuracompanion_sdk
  echo.
  echo # Node:
  echo npm install @neuracompanion/sdk
  echo ```
  echo.
  echo ## 2. Initialize Client
  echo.
  echo Dart:
  echo ```dart
  echo final client = ApiClient(
  echo   baseUrl: 'https://api.neuracompanion.app/v3',
  echo   jwtToken: '<YOUR_JWT>',
  echo   tenantId: '<YOUR_TENANT_ID>',
  echo );
  echo ```
  echo.
  echo Node:
  echo ```js
  echo import { createClient } from './apiClient.js';
  echo const client = createClient('<YOUR_JWT>', '<YOUR_TENANT_ID>');
  echo ```
  echo.
  echo ## 3. Quick Calls
  echo.
  echo - **Health Check**
  echo   ```dart
  echo   final status = await client.healthApi.getHealth();
  echo   ```
  echo.
  echo - **Create a Memory**
  echo   ```js
  echo   const memory = await client.memory.createMemory({
  echo     title: 'Hello world',
  echo     content: 'This is a sample memory.'
  echo   });
  echo   ```
  echo.
  echo ## 4. Subscribe to Webhooks
  echo.
  echo 1. Create a webhook endpoint in your service.
  echo 2. Register it:
  echo    ```js
  echo    await client.webhooks.createWebhook({
  echo      event: 'memory.added',
  echo      callbackUrl: 'https://your.service/webhooks/neura',
  echo      secret: '<HMAC_SECRET>'
  echo    });
  echo    ```
  echo 3. Verify events by checking the X-Callback-Signature header.
  echo.
  echo ## 5. CI Integration
  echo.
  echo - Use the provided GitHub Actions YAML in .github/workflows to automate lint, test, and build on each PR.
  echo.
  echo ---
  echo.
  echo Happy building! Reach out at support@neuracompanion.app for questions.
) > docs\partner-tutorial.md

REM 10) Root README.md
(
  echo # Neura Companion Sample Project
  echo.
  echo This sample project demonstrates how to integrate your app with the Neura Companion API using Flutter and Node.js.
  echo.
  echo ## Structure
  echo.
  echo - .github/workflows: CI pipelines for Flutter and Node.js
  echo - docs: Partner tutorial markdown
  echo - flutter_app: Sample Flutter client
  echo - node_app: Sample Node.js client
  echo.
  echo ## Setup
  echo.
  echo ```bash
  echo cd neura-companion-sample
  echo flutter pub get   # in flutter_app
  echo npm ci             # in node_app
  echo ```
  echo.
  echo ## Run
  echo.
  echo ```bash
  echo flutter run --project flutter_app
  echo node node_app/src/index.js
  echo ```
) > README.md

REM 11) Install dependencies
echo.
echo Installing Flutter dependencies...
cd flutter_app
flutter pub get
cd ..

echo.
echo Installing Node.js dependencies...
cd node_app
npm ci
cd ..

echo.
echo Sample project setup complete!
pause
