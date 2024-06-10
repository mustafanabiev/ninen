class OnboardingModel {
  const OnboardingModel({
    required this.page,
    required this.title,
    required this.description,
  });

  final int page;
  final String title;
  final String description;
}

List<OnboardingModel> onboardingList = [
  const OnboardingModel(
    page: 1,
    title: 'Training diary',
    description:
        'Keep a training diary: record exercises\nand upload photos to track your progress',
  ),
  const OnboardingModel(
    page: 2,
    title: 'Progress tracking',
    description:
        'Monitor your results regularly and view\nyour progress on graphs',
  ),
  const OnboardingModel(
    page: 3,
    title: 'Set goals',
    description: 'Set goals for yourself\nand go for it',
  ),
];
