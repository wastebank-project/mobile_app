class Models {
  final String label;
  final String youtubeLink;

  Models({required this.label, required this.youtubeLink});

  static Map<String, String> recommendationMap = {
    "Galon": "https://www.youtube.com/watch?v=example_galon",
    "Botol Plastik": "https://www.youtube.com/watch?v=example_botol_plastik",
    // Add more mappings here
  };

  static List<Models> fromLabels(List<String> labels) {
    return labels.toSet().map((label) {
      return Models(
        label: label,
        youtubeLink: recommendationMap[label] ?? "https://www.youtube.com",
      );
    }).toList();
  }
}
