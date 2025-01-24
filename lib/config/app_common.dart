String getUserNameInitials(String name) {
  List<String> nameParts = name.split(' ');
  if (nameParts.isEmpty) return '';

  // Get the first character of the first and second parts of the name
  String initials =
      nameParts[0][0].toUpperCase(); // First letter of the first name
  if (nameParts.length > 1) {
    initials += nameParts[1][0]
        .toUpperCase(); // First letter of the second part (middle or last name)
  }

  return initials;
}


