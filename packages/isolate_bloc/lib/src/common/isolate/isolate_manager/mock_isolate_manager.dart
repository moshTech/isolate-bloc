import 'dart:isolate';

import 'package:isolate_bloc/src/common/isolate/bloc_manager.dart';
import 'package:isolate_bloc/src/common/isolate/isolate_manager/mock_isolate_wrapper.dart';
import 'package:isolate_bloc/src/common/isolate/isolate_manager/isolate_wrapper.dart';

import 'abstract_isolate_manager.dart';
import 'isolate_messenger.dart';

/// [IsolateManager] implementation for tests.
/// Have all [IsolateManagerImpl]'s restrictions.
class MockIsolateManager extends IsolateManager {
  MockIsolateManager(IsolateWrapper isolate, IsolateMessenger messenger)
      : super(isolate, messenger);

  /// Create [MockIsolateManager] object.
  static Future<MockIsolateManager> createIsolate(
      IsolateRun run, Initializer initializer) async {
    var fromIsolate = ReceivePort();
    var toIsolate = ReceivePort();
    var sendFromIsolate = fromIsolate.sendPort.send;
    var sendToIsolate = toIsolate.sendPort.send;
    var toIsolateStream = toIsolate.asBroadcastStream();
    var fromIsolateStream = fromIsolate.asBroadcastStream();

    // this function run isolated function (IsolateRun)
    run(IsolateMessenger(toIsolateStream, sendFromIsolate), initializer);

    return MockIsolateManager(
      MockIsolateWrapper(),
      IsolateMessenger(
        fromIsolateStream,
        sendToIsolate,
      ),
    );
  }
}
