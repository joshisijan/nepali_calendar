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

  int nepaliToEnglishDate(String x) {
    String temp = '';
    for (int i = 0; i < x.length; i++) {
      temp += neapliToEnglishNumberConverter(x[i]).toString();
    }
    return int.parse(temp);
  }

  String englishToNepaliDate(int y) {
    String temp = '';
    String x = y.toString();
    for (int i = 0; i < x.length; i++) {
      temp += englishToNepaliNumberConverter(int.parse(x[i])).toString();
    }
    return temp;
  }

  String englishToNepaliDay(String x) {
    if (x == 'sunday') {
      return 'आइतबार';
    } else if (x == 'monday') {
      return 'सोमबार';
    } else if (x == 'tuesday') {
      return 'मंगलबार';
    } else if (x == 'wednesday') {
      return 'बुधबार';
    } else if (x == 'thursday') {
      return 'बिहिबार';
    } else if (x == 'saturday') {
      return 'शनिबार';
    }
    return 'शुक्रबार';
  }

  int neapliToEnglishNumberConverter(String x) {
    if (x == '१')
      return 1;
    else if (x == '२')
      return 2;
    else if (x == '३')
      return 3;
    else if (x == '४')
      return 4;
    else if (x == '५')
      return 5;
    else if (x == '६')
      return 6;
    else if (x == '७')
      return 7;
    else if (x == '८')
      return 8;
    else if (x == '९')
      return 9;
    else if (x == '०')
      return 0;
    else
      return int.parse(x);
  }

  String englishToNepaliNumberConverter(int x) {
    if (x == 1)
      return '१';
    else if (x == 2)
      return '२';
    else if (x == 3)
      return '३';
    else if (x == 4)
      return '४';
    else if (x == 5)
      return '५';
    else if (x == 6)
      return '६';
    else if (x == 7)
      return '७';
    else if (x == 8)
      return '८';
    else if (x == 9)
      return '९';
    else
      return '०';
  }
}
