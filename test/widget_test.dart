import 'dart:async';

void main() async {
  // 1. Stream // await for (var number in getNumbers()) {
  //   print(number);
  // }
  // await for (var names in names()) {
  //   print(names);
  // }

  // 2. asyncExpand await for (var name
  //     in getNames().asyncExpand((names) => getCharacters(names))) {
  //   print(name);
  // }

  // 3. reduce // final sum =
  //     await getAllAges().reduce((previous, element) => previous + element);
  // print("Sum of all numbers $sum");

  // 4. weird stream // await for (var value in numbers(end: 10, f: evenNumbersOnly)) {
  //   print(value);
  // }

  // 5. await for (var element in allNames()) {
  //   print(element);
  // }

  // 6. StreamController //final controller = StreamController<String>();
  // controller.sink.add("hello");
  // controller.sink.add("world");
  // await for (var element in controller.stream) {
  //   print(element);
  // }
  // controller.close();

  // 7. await for (var element in names.capitalized) {
  //   print(element);
  // }
  // print('--------');
  // await for (var element in names.capitalizedUsingMap) {
  //   print(element);
  // }

  // 8. Stream.toList // final allNames = await getNames().toList();
  // await for (var element in getNames()) {
  //   print(element);
  // }
  // print(allNames);

  // 9. await for (var element in getNames().absorbErrorUsingHandleError()) {
  //   print(element);
  // }
  // await for (var element in getNames().absorbErrorsUsingHandlers()) {
  //   print(element);
  // }
  // await for (var element in getNames().absorbErrorUsingTransformer()) {
  //   print(element);
  // }
  // 10. asyncMap // final result = await getNames()
  //     .asyncMap((name) => extractCharacters(name))
  //     .fold('', (previous, element) {
  //   final elements = element.join(' ');
  //   return "$previous $element";
  // });
  // print(result);

  // 11. another example of asyncExpand // final names3Times = getNames().asyncExpand((name) => timers3(name));

  // await for (var element in names3Times) {
  //   print(element);
  // }

  //  12. broadcast or listen to 2 stream. await nonBroadCastExample();
  // await broadCastExample();
}

// List<int> oddOnesOut(List<int> nums) {
//   List<int> numbers = <int>[];
//   // nums.where((element) => element.toString() ).toList();

//   for (var i = 0; i < nums.length; i++) {
//     final numsToString = nums[i].toString();

//   }

//   return [];
// }

// int expressionMatter(a, b, c) {
//   // your code here
// }

// 1.  Stream<String> names() async* {
//   Future.delayed(const Duration(seconds: 1));
//   yield 'wait 1 sec';
//   await Future.delayed(const Duration(seconds: 1));
//   yield 'Adit';
//   throw Exception("Theres Something Wrong");
// }

// Stream<int> getNumbers() async* {
//   for (var i = 0; i < 10; i++) {
//     await Future.delayed(const Duration(seconds: 1));
//     yield i;
//   }
// }

// 2. Stream<String> getCharacters(String fromString) async* {
//   for (var i = 0; i < fromString.length; i++) {
//     await Future.delayed(const Duration(seconds: 2));
//     yield fromString[i];
//   }
// }

// Stream<String> getNames() async* {
//   await Future.delayed(const Duration(seconds: 1));
//   yield 'adit';
//   await Future.delayed(const Duration(seconds: 1));
//   yield 'prasetia';
// }

// 3. Stream<int> getAllAges() async* {
//   yield 10;
//   yield 20;
//   yield 30;
//   yield 40;
//   yield 50;
// }

// 4. typedef IsIncluded = bool Function(int value);
// bool evenNumbersOnly(int value) => value % 2 == 0;
// bool oddNumbersOnly(int value) => value % 2 != 0;

// Stream<int> numbers({int start = 0, int end = 4, IsIncluded? f}) async* {
//   for (var i = start; i < end; i++) {
//     if (f == null || f(i)) {
//       await Future.delayed(const Duration(seconds: 1));
//       yield i;
//     }
//   }
// }

//  5. called the maleName and femaleName into one function in all names
// Stream<String> maleNames() async* {
//   yield 'Adit';
//   yield 'Prasetia';
//   yield 'Putra';
// }

// Stream<String> femaleNames() async* {
//   yield 'Testi';
//   yield 'Moni';
// }

// Stream<String> allNames() async* {
//   yield* maleNames();
//   yield* femaleNames();
// }

// 7. Stream<String> names = Stream.fromIterable(['Adit', "Prasetia", "Putra"]);

// extension on Stream<String> {
//   Stream<String> get capitalized => transform(ToUpperCase());
//   Stream<String> get capitalizedUsingMap => map((event) => event.toUpperCase());
// }
// class ToUpperCase extends StreamTransformerBase<String, String> {
//   @override
//   Stream<String> bind(Stream<String> stream) {
//     return stream.map((event) => event.toUpperCase());
//   }
// }

// 8. Stream<String> getNames() async* {
//   await Future.delayed(const Duration(seconds: 2));
//   yield 'Adit';
//   await Future.delayed(const Duration(seconds: 2));
//   yield 'Prasetia';
//   await Future.delayed(const Duration(seconds: 2));
//   yield 'Putra';
// }

// 9. handle the error throw exeception Stream // Stream<String> getNames() async* {
//   yield 'John';
//   yield 'Doe';
//   throw 'All out of names';
// }
// extension AbsorbErrors<T> on Stream<T> {
//   Stream<T> absorbErrorUsingHandleError() => handleError((_, __) {});

//   Stream<T> absorbErrorsUsingHandlers() =>
//       transform(StreamTransformer.fromHandlers(
//           handleError: (error, stackTrace, sink) => sink.close()));

//   Stream<T> absorbErrorUsingTransformer() => transform(StreamAbsorber());
// }
// class StreamAbsorber<T> extends StreamTransformerBase<T, T> {
//   @override
//   Stream<T> bind(Stream<T> stream) {
//     final controller = StreamController<T>();
//     stream.listen(
//       controller.sink.add,
//       onError: (_) {},
//       onDone: () async {
//         await controller.close();
//       },
//     );
//     return controller.stream;
//   }
// }

// 10. Stream<String> getNames() async* {
//   await Future.delayed(const Duration(seconds: 1));
//   yield "Adit";
//   await Future.delayed(const Duration(seconds: 1));
//   yield "Prasetia";
//   await Future.delayed(const Duration(seconds: 1));
//   yield "Putra";
// }
// Future<List<String>> extractCharacters(String from) async {
//   final characters = <String>[];
//   for (var character in from.split('')) {
//     await Future.delayed(const Duration(seconds: 1));
//     characters.add(character);
//   }
//   return characters;
// }

// 11. Stream<String> getNames() async* {
//   yield "Adit";
//   yield "Prasetia";
//   yield "Putra";
// }
// Stream<String> timers3(String value) =>
//     Stream.fromIterable(Iterable.generate(3, (_) => value));

// 12. Future<void> nonBroadCastExample() async {
//   final controller = StreamController<String>();

//   controller.sink.add("Bob");
//   controller.sink.add("Alice");
//   controller.sink.add("Job");

//   try {
//     await for (final name in controller.stream) {
//       print(name);
//       await for (final name in controller.stream) {
//         print(name);
//       }
//     }
//   } catch (e) {
//     print(e);
//   }
// }
// Future<void> broadCastExample() async {
//   late final StreamController<String> controller;
//   controller = StreamController<String>.broadcast();

//   final sub1 = controller.stream.listen((name) {
//     print("sub1: $name");
//   });
//   final sub2 = controller.stream.listen((name) {
//     print("sub2: $name");
//   });

//   controller.sink.add("Bob");
//   controller.sink.add("Alice");
//   controller.sink.add("Job");

//   controller.close();

//   controller.onCancel = () {
//     print("oncancel");
//     sub1.cancel();
//     sub1.cancel();
//     sub2.cancel();
//     sub2.cancel();
//   };
// }

class TimeOutBetweenEvent<E> extends StreamTransformerBase<E, E> {
  final Duration duration;
  const TimeOutBetweenEvent({required this.duration});
  @override
  Stream<E> bind(Stream<E> stream) {
    StreamController<E>? controller;
    StreamSubscription<E>? subscription;
    Timer? timer;

    controller = StreamController(
      onListen: () {
        subscription = stream.listen((data) {
          timer?.cancel();
          timer = Timer.periodic(duration, (timer) {
            controller?.addError(
                TimeOutBetweenException('Not event Received $duration'));
          });
          controller?.add(data);
        }, onError: controller?.addError);
      },
      onCancel: () {
        timer?.cancel();
        subscription?.cancel();
      },
    );
    return controller.stream;
  }
}

class TimeOutBetweenException implements Exception {
  final String message;
  const TimeOutBetweenException(this.message);
}

extension WithTimeOutBetween<T> on Stream<T> {
  Stream<T> withTimeOutBetweenEvents(Duration duration) =>
      transform(TimeOutBetweenEvent(duration: duration));
}
