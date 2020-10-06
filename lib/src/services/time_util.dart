class CustomTimeUtil {
  int dayToIndex(String day) {
    if (day == 'sunday') {
      return 1;
    } else if (day == 'monday') {
      return 2;
    } else if (day == 'tuesday') {
      return 3;
    } else if (day == 'wednesday') {
      return 4;
    } else if (day == 'thursday') {
      return 5;
    } else if (day == 'fryday') {
      return 6;
    } else {
      return 7;
    }
  }

  String indexToMonth(int n) {
    if (n == 1)
      return 'Baishakh';
    else if (n == 2)
      return 'Jestha';
    else if (n == 3)
      return 'Ashadha';
    else if (n == 4)
      return 'Shrawan';
    else if (n == 5)
      return 'Bhadra';
    else if (n == 6)
      return 'Ashwin';
    else if (n == 7)
      return 'Kartik';
    else if (n == 8)
      return 'Mangsir';
    else if (n == 9)
      return 'Poush';
    else if (n == 10)
      return 'Magh';
    else if (n == 11)
      return 'Falgun';
    else
      return 'Chaitra';
  }
}
