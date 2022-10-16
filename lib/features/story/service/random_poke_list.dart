List randomPicker = List<int>.generate(900, (i) => i + 1)..shuffle();
int getRandomVal() {
  int newVal = randomPicker[0];
  randomPicker.removeAt(0);
  randomPicker.shuffle();
  return newVal;
}
