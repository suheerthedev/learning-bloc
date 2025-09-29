part of 'counter_cubit.dart';

class CounterState extends Equatable {
  final int counterValue;
  final bool wasIncremented;

  const CounterState({required this.counterValue, this.wasIncremented = false});

  @override
  List<Object?> get props => [counterValue, wasIncremented];

  @override
  String toString() {
    return 'counterValue: $counterValue, wasIncremented: $wasIncremented';
  }

  factory CounterState.fromJson(Map<String, dynamic> json) {
    return CounterState(
      counterValue: json['counterValue'],
      wasIncremented: json['wasIncremented'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'counterValue': counterValue, 'wasIncremented': wasIncremented};
  }
}
