import 'constants.dart';

class Validator {
  static Pattern emailPattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,403}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,403}[a-zA-Z0-9])?)*$";
  static RegExp regexEmail = new RegExp(emailPattern.toString());
  static RegExp name = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
  static Pattern phonePattern =
      "\\d{9}|(?:\\d{3}-){2}\\d{4}|\\(\\d{3}\\)\\d{3}-?\\d{4}";
  static RegExp regexPhone = new RegExp(phonePattern.toString());
  static String? validatePANNO(String value) {
    Pattern pattern =
        r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Enter Valid PAN Number';
    } else {
      return null;
    }
  }

  static validateEmail(String value, String errorTextForEmptyField,
      String errorTextForInvalidField) {
    if (value.isNotEmpty) {
      if (regexEmail.hasMatch(value)) {
        return null;
      } else {
        return errorTextForInvalidField;
      }
    } else {
      return errorTextForEmptyField;
    }
  }
  static String? validateLinkdln(String value) {
    Pattern pattern =
        r'((https?:\/\/)?((www|\w\w)\.)?linkedin\.com\/)((([\w]{2,3})?)|([^\/]+\/(([\w|\d-&#?=])+\/?){1,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Enter Valid linkedIn url.';
    } else {
      return null;
    }
  }
  static String? validateFacebook(String value) {
    Pattern pattern =
        r'(?:(?:http|https):\/\/)?(?:www.)?facebook.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[?\w\-]*\/)?(?:profile.php\?id=(?=\d.*))?([\w\-]*)?';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Facebook url.';
    } else {
      return null;
    }
  }
  static String? validatetTwitter(String value) {
    Pattern pattern =
        r'(?:http:\/\/)?(?:www\.)?twitter\.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[\w\-]*\/)*([\w\-]*)';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Enter Valid twitter url.';
    } else {
      return null;
    }
  }

  static validateName(String value, String errorTextForEmptyField,
      String errorTextForInvalidField) {
    if (value.isNotEmpty) {
      if (name.hasMatch(value)) {
        return null;
      } else {
        return errorTextForInvalidField;
      }
    } else {
      return errorTextForEmptyField;
    }
  }

  static validateEmailAndPhone(String value, String errorTextForEmptyField,
      String errorTextForInvalidField) {
    if (value.isNotEmpty) {
      if (regexEmail.hasMatch(value) || regexPhone.hasMatch(value)) {
        return null;
      } else {
        return errorTextForInvalidField;
      }
    }
  }

  static validateFormField(String value, String errorTextForEmptyField,
      String errorTextInvalidField, int type) {
    switch (type) {
      case Constants.MIN_CHAR_VALIDATION:
        if (value.isEmpty) {
          return errorTextForEmptyField;
        }else if(value.length < 2){
          return errorTextInvalidField;
        }
        break;
      case Constants.NORMAL_VALIDATION:
        if (value.isEmpty) {
          return errorTextForEmptyField;
        }
        break;

      case Constants.EMAIL_VALIDATION:
        return validateEmail(
            value, errorTextForEmptyField, errorTextInvalidField);
        break;

      case Constants.PHONE_VALIDATION:
        if (value.isNotEmpty) {
          if (isNumeric(value) && value.length <= 13) {
            return null;
          } else {
            return errorTextInvalidField;
          }
        } else {
          return errorTextForEmptyField;
        }
        break;

      case Constants.PHONE_OR_EMAIL_VALIDATION:
        return validateEmailAndPhone(
            value, errorTextForEmptyField, errorTextInvalidField);
        break;

      case Constants.PASSWORD_VALIDATION:
        if (value.isNotEmpty) {
          if (value.length >= 8) {
            return null;
          } else {
            return errorTextInvalidField;
          }
        } else {
          return errorTextForEmptyField;
        }
        break;

      case Constants.ZIP_VALIDATION:
        if (value.isNotEmpty) {
          if (value.length == 6) {
            return null;
          } else {
            return errorTextInvalidField;
          }
        } else {
          return errorTextForEmptyField;
        }
        break;
      case Constants.Name_CHAR_VALIDATION:
        return validateName(
            value, errorTextForEmptyField, errorTextInvalidField);
        break;
    }
  }

  static bool isNumeric(String str) {
    try {
      var value = double.parse(str);
    } on FormatException {
      return false;
    } finally {
      return true;
    }
  }
}
