//import test
import 'package:test/test.dart';

void main() {
  print('hello');
  test('test', () {
    expect(1, 1);
  });
  test('Future.value() returns the value', () async {
    var value = await Future.delayed(Duration(seconds: 3), () => 1);
    print(value);
    var value2 = await Future.delayed(Duration(seconds: 3));
    print(value2);
  });
  test('stcream', () async {
    var hello = Stream.periodic(
        Duration(seconds: 1), (computationCount) => computationCount);
    hello.listen((event) {
      print(event);
    });
    await Future.delayed(Duration(seconds: 5));
  }); //sau 5 giây mới in ra 0,1,2,3,4
}
