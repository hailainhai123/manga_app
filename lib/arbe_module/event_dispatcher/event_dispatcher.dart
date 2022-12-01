import 'package:manga_app/arbe_module/event_dispatcher/event_id.dart';

class EventDispatcher {
  static final EventDispatcher _instance = EventDispatcher._internal();

  /// Returns the singleton instance
  factory EventDispatcher() => _instance;

  EventDispatcher._internal();

  final Map<EventId, List<Function(dynamic)>> callbacks =
      <EventId, List<Function(dynamic)>>{};

  void registerEvent(
      {required EventId eventId, required Function(dynamic) callback}) {
    if (!callbacks.containsKey(eventId)) {
      callbacks[eventId] = [];
      callbacks[eventId]?.add(callback);
    }

    callbacks[eventId]?.add(callback);
  }

  void postEvent({required EventId eventId, dynamic params}) {
    if (callbacks.containsKey(eventId)) {
      final actions = callbacks[eventId];
      actions?.forEach((element) => element(params));
    }
  }

  void removeListeners(
      {required EventId eventId, required Function(dynamic) callback}) {
    if (callbacks.containsKey(eventId)) {
      final actions = callbacks[eventId];
      actions?.remove(callback);
    }
  }
}
