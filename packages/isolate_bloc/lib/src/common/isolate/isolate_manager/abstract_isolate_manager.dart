import 'package:isolate_bloc/src/common/isolate/isolate_manager/isolate_manager.dart';
import 'package:isolate_bloc/src/common/isolate/isolate_manager/isolate_wrapper.dart';

import '../bloc_manager.dart';
import 'isolate_messenger.dart';

/// Signature for function which will run in isolate
typedef IsolateRun = void Function(IsolateMessenger messager, Initializer initializer);

/// Abstract class for [IsolateManagerImpl] which implement work with real [Isolate],
/// [MockIsolateManager] which doesn't create a real [Isolate] and web implementation
abstract class IsolateManager {
  final IsolateWrapper isolate;
  final IsolateMessenger messenger;

  IsolateManager(this.isolate, this.messenger);
}
