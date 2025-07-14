String formatCodeStringForComparison(String input) {
  List<String> lines = input.split('\n');

  // Remove empty lines and trim each line
  List<String> processedLines = lines
      .where((line) => line.trim().isNotEmpty)
      .map((line) => line.trim())
      .toList();

  // Join the processed lines into a single string
  String result = processedLines.join('\n').trim();

  return result;
}
