class HealthEducationObject {
  int index;
  String title, details;

  HealthEducationObject({
    required this.index,
    required this.title,
    required this.details,
  });

  static getList() => _listOfPoints;

  static List<HealthEducationObject> _listOfPoints = [
    HealthEducationObject(
      index: 1,
      title: 'Healthy Diet',
      details: 'This is the content for .\n'
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    HealthEducationObject(
      index: 2,
      title: 'Exercise and Fitness',
      details: 'This is the content for .\n'
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    HealthEducationObject(
      index: 3,
      title: 'Sleep Hygiene',
      details: 'This is the content for .\n'
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    HealthEducationObject(
      index: 4,
      title: 'Hydration and Water Intake',
      details: 'This is the content for .\n'
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
  ];
}
