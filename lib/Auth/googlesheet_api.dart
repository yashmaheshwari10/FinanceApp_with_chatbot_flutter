import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  static const _credentials = r'''
{
"type": "service_account",
  "project_id": "edi-fin-tracker",
  "private_key_id": "1f58e3050b55428a3c5701f08d0f10645e5eb9f3",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCrgoUHJPYMbNba\nNMN3KJPUe1JLPeeGvP2CyFvNK3YlaeqN0iFxIAtaU/6fOpQbgSzHkcuM1lGjL+KK\npC7Xz3zyyRR87bllFIw6w9T0NGVjqFGy4ARo/R3bJdV9kbFeaxi6fZuAtIh3y8Ql\n8nTjt9p/sOPa7RfsnZ8V/aeZw7pDlWjN5/WBhWgO3LI3BP6+vrVvHd40E01suBkF\neLPFF9S2BJCnDUi6SxB0yVphVymtIBvoiUHAy4FwocMgW+dPMxsegLDsTURH4LEr\nkyWWUGClBlhIIAwv0uOuPA71QCQpMcQXrXL1J86/BSnfw7BP4yIk0QUQobIZl+hb\nroL6pSqVAgMBAAECggEACbhAIJHw6sPZSkJOvd2cFnY1s/i/uq79C/tzA8CIiyFt\nREPKFuPlbiVP9bH8wPFJZSGnVZAzeLTRmSCpsfElkt8f7N45EULV7qJOBYKZqLPv\ni1xZi6H6nkKO49/3m2hPiAlvIF8QKSqFr3kwiX46y7KYkH3ldZ36LSVz/oltMIAQ\nH6jxMUvTRKHkm4GxrrKMjyCwRXSviFeNpZymzInE/atZH7MtwoAEKgkw1TDNUNpr\nBPUa8GbCZ5BkGJV63abmcLWeYSHuQUUCpX3VVvFnXtHGodlSatWH+rGErJekG3yF\nvwEN5n1SIcuH+4JQZp7J+vBV1FDDXmnDCeDfV7QBOQKBgQDuJBUt8MJLxLJyKyE9\noVUuLRBBh8CGSmUUC4Ko+xyuua4kN6lGdXtlPTTxZacXl4nFbyD/t4v2VGLjcOSb\n4ql8bzPrDP3MyVY34db2E9L7c64Ad93utLmlSH2+EOJRNJddB0u3knUE5xuZ+iyY\nTE98d88072jSnqYMEEm2rAVeHQKBgQC4Xzp+8jTLjmuTh41mI5Iqf8EcNOBJE5Rb\nap/Ze1M3tzEtWLXJnyBkz3y7NaVdEl8tJ8uH/Zvfbndn3RQuafaUwerlfg5m3/fK\nsjw9hG0MrOFvouhWOzlmRIJmIwoauPYDZ8t0gLTe8ELQkI3kfW0iFCs2u/TepBdA\nPAd5H9y02QKBgQCtzJvAeZPz5Ewv0pZh+lrGZpEUolS6LZVzeasUVKBsTItxV0Yt\nbBRwoKkA/KVkLG6aLy6wMm7tikzZnUzbECON80K66zJXwSExi5ts4K78YUK+iLzq\nN++9VxieHIhvp6hIdsil4zeQKnMUf2cIh7kDKBWLlqa0AKFC8Kg7r3QDaQKBgHm8\n3zn9IWEay+tgwLulVxjavB6sxz9ZP0dRUvTeGmeafU0s2vOjL1eBLSHL3UFkJRYC\nxcAoc6iHHy6kanPvIZK9rCUWI9pHniznnSEddIe/CyeUUIbHmjHtoJBiKITWhhJf\nkZZ+eW8PA38FQ7uQGeQ7nwEIADqV7IhMWr7ei/OZAoGADD741exX01KUnbjOsB7X\nxF0MpxogKl1q7hLhxuQ2L2971blZ7Om2IJVNFViVsGHQQ5QUVdlsVyjE4hPbmaYQ\nLE+Z++bwLf5czeuAZ0nFSZ6gdH81OT8HJPzqCpLMULRwZP7DJTCj1NJ8fMcMPmwU\nKUeTERrCSt4tqeh0DNdzHYQ=\n-----END PRIVATE KEY-----\n",
  "client_email": "edi-gsheets@edi-fin-tracker.iam.gserviceaccount.com",
  "client_id": "112690176808375544783",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/edi-gsheets%40edi-fin-tracker.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

  static const spreadsheetid = '1ByNKMtSmRaQ3XtijBLP4hFwmyVhIbwhqx-4e1NdZkZ4';
  static final gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  static int transactnum = 0;
  static List<List<dynamic>> currentTransact = [];
  static bool loading = true;

  Future init() async {
    final ss = await gsheets.spreadsheet(spreadsheetid);
    _worksheet = ss.worksheetByTitle('Sheet1');
    countrows();
  }

  static Future countrows() async {
    while (
        await _worksheet!.values.value(column: 1, row: transactnum + 1) != '') {
      transactnum++;
    }
    loadTransactions();
  }

  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < transactnum; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);
      final String transactionDate =
          await _worksheet!.values.value(column: 4, row: i + 1);
      final String transactionMonth =
          await _worksheet!.values.value(column: 5, row: i + 1);

      if (currentTransact.length < transactnum) {
        currentTransact.add([
          transactionName,
          transactionAmount,
          transactionType,
          transactionDate,
          transactionMonth,
        ]);
      }
    }
    print(currentTransact);
    // this will stop the circular loading indicator
    loading = false;
  }

  static Future insert(String name, String amount, bool _isIncome, String date,
      String month) async {
    if (_worksheet == null) return;
    transactnum++;
    currentTransact.add(
        [name, amount, _isIncome == true ? 'income' : 'expense', date, month]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
      date,
      month,
    ]);
  }

  static double calculateincome() {
    double income = 0;
    for (int i = 0; i < currentTransact.length; i++) {
      if (currentTransact[i][2] == 'income') {
        income += double.parse(currentTransact[i][1]);
      }
    }
    return income;
  }

  static double calculateexpence() {
    double expense = 0;
    for (int i = 0; i < currentTransact.length; i++) {
      if (currentTransact[i][2] == 'expense') {
        expense += double.parse(currentTransact[i][1]);
      }
    }
    return expense;
  }

  static double calculatebalance() {
    double income = calculateincome();
    double expense = calculateexpence();
    double Balance = income - expense;
    return Balance;
  }

  static double calculateMonthlyTransact(String i) {
    double spend = 0;

    for (int j = 0; j < currentTransact.length; j++) {
      if (currentTransact[j][3] == i) {
        print(currentTransact[j][3]);
        spend += double.parse(currentTransact[j][1]);
      }
    }
    return spend;
  }
}
