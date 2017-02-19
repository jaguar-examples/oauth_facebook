// Copyright (c) 2017, Ravi Teja Gudapati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:jaguar_reflect/jaguar_reflect.dart';
import 'package:jaguar/jaguar.dart';
import 'package:oauth_facebook/server/api/api.dart';
import 'package:logging/logging.dart';

main(List<String> args) async {
  Settings.parse(args, settingsMap: {'mongo.url': 'mongodb://localhost:27018/oauth_facebook'});
  Jaguar server = new Jaguar();
  server.addApi(reflectJaguar(new MyApi()));

  server.log.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  await server.serve();
}
