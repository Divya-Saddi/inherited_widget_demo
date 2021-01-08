import 'package:flutter_test/flutter_test.dart';
import 'package:inherited_example/register_screen.dart';

void main() {
  test('Empty Feild Test', () {
    var result = LogInValidator.valueIsEmpty('',"email");
    expect(result, 'Please fill email field');
  });

  test('Invalid Email Test', () {
    var result = LogInValidator.isValidEmail('');
    expect(result, 'Please fill email field');
  });

  test('Invaild Email Format', () {
    var result = LogInValidator.isValidEmail('s.divyareddy94gmail.com');
    expect(result, "Not a valid email address. value should contain @gmail.com format");
  });

  test('Valid Email Test', () {
    var result = LogInValidator.isValidEmail('s.divyareddy94@gmail.com');
    expect(result, null);
  });

  test('Invalid Phone Number Test', () {
    var result = LogInValidator.isValidPhone('123');
    expect(result, "Please Enter a valid Phone Number");
  });

  test('Valid Phone Number Test', () {
    var result = LogInValidator.isValidPhone('9515739557');
    expect(result, null);
  });


}