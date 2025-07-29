import 'dart:convert';
import 'package:http/http.dart' as http;

class BackendConnector {
  final String nodeUrl;
  final String pythonUrl;
  final String firebaseUrl;

  BackendConnector({
    this.nodeUrl = "http://localhost:3000/status",
    this.pythonUrl = "http://localhost:5000/ping",
    this.firebaseUrl = "https://your-firebase-function-url.com/api/status"
  });

  Future<String> fetchNodeStatus() async {
    try {
      final response = await http.get(Uri.parse(nodeUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body)['status'];
      } else {
        return "Node error: ${response.statusCode}";
      }
    } catch (e) {
      return "Node unreachable: $e";
    }
  }

  Future<String> fetchPythonStatus() async {
    try {
      final response = await http.get(Uri.parse(pythonUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body)['status'];
      } else {
        return "Python error: ${response.statusCode}";
      }
    } catch (e) {
      return "Python unreachable: $e";
    }
  }

  Future<String> fetchFirebaseStatus() async {
    try {
      final response = await http.get(Uri.parse(firebaseUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body)['status'];
      } else {
        return "Firebase error: ${response.statusCode}";
      }
    } catch (e) {
      return "Firebase unreachable: $e";
    }
  }
}