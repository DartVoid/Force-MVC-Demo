library example_forcedart;

import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:forcemvc/force_mvc.dart';
import 'package:wired/wired.dart';

part 'controllers/post_controller.dart';
part 'controllers/login_controller.dart';
part 'controllers/redirect_controller.dart';
part 'controllers/path_controller.dart';
part 'controllers/count_controller.dart';
part 'controllers/secure_controller.dart';
part 'controllers/about_controller.dart';

part 'interceptors/random_interceptor.dart';

part 'controllers/security/session_strategy.dart';

part 'advice/text_advice.dart';

void main() {
  // Setup what port to listen to
  var portEnv = Platform.environment['PORT'];
  var port = portEnv == null ? 9090 : int.parse(portEnv);
  var serveClient = portEnv == null ? true : false;

  // Create a force server
  WebApplication server = new WebApplication(host: "127.0.0.1",
                                             port: port,
                                             staticFiles: '../web/static/',
                                             clientFiles: '../web/',
                                             clientServe: serveClient,
                                             views: "views/");
  // Register yaml files
  server.loadValues("../dv.yaml");
  server.loadValues("../pubspec.yaml");

  // Set up logger.
  server.setupConsoleLog();

  // Setup session strategy
  server.strategy = new SessionStrategy();

  // Serve the view called index as default
  server.use("/", (req, model) => "index");

  // Start serving force
  server.start();
}

