class MyRegister {
  final int userId;
  final int id;
  final String title;
  final String body;

  const MyRegister({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  MyRegister.fromMap(Map<String, Object?> data)
      : userId = data['userId'] as int,
        id = data['id'] as int,
        title = data['title'] as String,
        body = data['body'] as String;
}
