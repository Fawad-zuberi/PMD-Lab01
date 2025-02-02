import 'dart:io';

void findHighestFrequencyWords(String filePath) {
  Map<int, List<String>> lineHighestFreqWords = {};

  int maxFreqOverall = 0;
  List<int> linesWithMaxFreq = [];

  File file = File(filePath);
  List<String> lines = file.readAsLinesSync();

  for (int lineNum = 0; lineNum < lines.length; lineNum++) {
    String line = lines[lineNum];
    List<String> words = line.split(RegExp(r'\s+'));

    Map<String, int> wordCounts = {};
    for (String word in words) {
      String cleanedWord = word.trim();
      if (cleanedWord.isEmpty) continue;
      wordCounts[cleanedWord] = (wordCounts[cleanedWord] ?? 0) + 1;
    }

    if (wordCounts.isEmpty) continue;

    int maxFreqInLine = wordCounts.values.reduce((a, b) => a > b ? a : b);

    List<String> highestFreqWords = wordCounts.entries
        .where((entry) => entry.value == maxFreqInLine)
        .map((entry) => entry.key)
        .toList();

    lineHighestFreqWords[lineNum + 1] = highestFreqWords;

    if (maxFreqInLine > maxFreqOverall) {
      maxFreqOverall = maxFreqInLine;
      linesWithMaxFreq = [lineNum + 1];
    } else if (maxFreqInLine == maxFreqOverall) {
      linesWithMaxFreq.add(lineNum + 1);
    }
  }

  print("The following words have the highest word frequency per line:");
  lineHighestFreqWords.forEach((int lineNum, List<String> words) {
    print('$words (appears in line #$lineNum)');
  });

  print(
      "\nThe following lines have the highest frequency words with the greatest value among all lines:");
  for (int lineNum in linesWithMaxFreq) {
    print(
        'Line #$lineNum: ${lineHighestFreqWords[lineNum]} (appears $maxFreqOverall times)');
  }
}

void main() {
  const String filePath = 'D:\\pmd\\Lab01\\file.txt';
  findHighestFrequencyWords(filePath);
}
