import 'dart:math';

// Digit Roundoff
double roundDouble(double value, int places) {
  double mod = pow(10.0, places).toDouble();
  return ((value * mod).round().toDouble() / mod);
}

final imageList = [
  'assets/images/phones/1.png',
  'assets/images/phones/2.png',
  'assets/images/phones/3.png',
  'assets/images/phones/4.png',
  'assets/images/phones/5.png',
  'assets/images/phones/6.png',
  'assets/images/phones/7.png',
  'assets/images/phones/8.png',
];

final coverList = [
  'assets/images/covers/1.jpg',
  'assets/images/covers/2.jpg',
  'assets/images/covers/3.jpg',
  'assets/images/covers/4.jpg',
  'assets/images/covers/5.jpg',
  'assets/images/covers/6.jpg',
  'assets/images/covers/7.jpg',
  'assets/images/covers/8.jpg',
  'assets/images/covers/9.jpg',
  'assets/images/covers/10.jpg',
  'assets/images/covers/11.jpg',
  'assets/images/covers/12.jpg'
];

final rand = new Random();

String getRandomImage() {
  return imageList[rand.nextInt(imageList.length)];
}
