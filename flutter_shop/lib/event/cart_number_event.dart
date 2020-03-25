import 'package:event_bus/event_bus.dart';

EventBus cartNumberEventBus = EventBus();

class CartNumberEvent {
  int number;

  CartNumberEvent(this.number);
}
