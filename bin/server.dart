// Copyright (c) 2017, Ravi Teja Gudapati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:jaguar_reflect/jaguar_reflect.dart';
import 'package:jaguar/jaguar.dart';
import 'package:oauth_facebook/server/api/api.dart';
import 'package:logging/logging.dart';

main(List<String> args) async {
  Settings.parse(args);
  Configuration conf = new Configuration();
  conf.addApi(new JaguarReflected(new MyApi()));

  conf.log.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  await serve(conf);
}
