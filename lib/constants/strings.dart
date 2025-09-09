//Error messages
class ErrorString {
  static const String internalSeverError = "ⓘ Internal sever error";
  static const String noInternet = "ⓘ No Internet";
  static const String somethingWentWrong = "ⓘ Something Went Wrong";
  static const String fullNameErr = "ⓘ Please enter full name";
  static const String emailAddressErr = "ⓘ Please enter email address";
  static const String emailAddressValidErr = "ⓘ Please enter valid email address";
  static const String phoneErr = "ⓘ Please enter phone number";
  static const String passwordErr = "ⓘ Please enter password";
  static const String passwordErr1 = "ⓘ Password & Confirm Password do not match";
  static const String hospitalErr = "ⓘ Please select hospital";
  static const String occupationErr = "ⓘ Select occupation";
  static const String bloodErr = "ⓘ Select blood";
  static const String genderErr = "ⓘ Select gender";
  static const String doctorTypeErr = "ⓘ Please Select doctor type";
  static const String otpErr = "ⓘ Please enter OTP";
  static const String experienceErr = "ⓘ Enter experience";
  static const String ageErr = "ⓘ Enter age";
}

//Messages
class Message {
  static const String msgDemo = "";
}

//Label Strings
class LabelString {
  static const String labelJoinAs = "Join As a";
  static const String labelDoctor = "Doctor";
  static const String labelPatient = "Patient";
  static const String labelTechnician = "Technician";
  static const String labelWelcomeTo = "Welcome to";
  static const String labelLogin = "Login";
  static const String labelRegister = "Register";
  static const String labelConfirmOtp = "Confirm OTP";
  static const String labelContinue = "Continue";
  static const String labelEmailAddress = "Email Address";
  static const String labelEnterEmailAddress = "Enter Email Address";
  static const String labelPassword = "Password";
  static const String labelEnterPassword = "Enter Password";
  static const String labelForgotPassword = "Forgot Password?";
  static const String labelSendOTP = "Send OTP";
  static const String labelVerification = "Verification";
  static const String labelNotReceiveCode = "Didn’t receive code?";
  static const String labelResendCode = "Resend code";
  static const String labelCreateNewPassword = "Create New Password";
  static const String labelSavePassword = "Save Password";
  static const String labelNewPassword = "New Password";
  static const String labelEnterNewPassword = "Enter New Password";
  static const String labelConfirmNewPassword = "Confirm New Password";
  static const String labelEnterConfirmNewPassword = "Enter Confirm New Password";
  static const String labelFullName = "Full Name";
  static const String labelEnterName = "Enter Name";
  static const String labelPhoneNumber = "Phone Number";
  static const String labelAge = "Age";
  static const String labelExperience = "Experience";
  static const String labelEnterPhoneNumber = "Enter Phone Number";
  static const String labelHome = "Home";
  static const String labelCallDoctor = "Call Doctor";
  static const String labelBookEms = "Book EMS";
  static const String labelBookAmbulance = "Book Ambulance";
  static const String labelSetting = "Setting";
  static const String labelPatients = "Patients";
  static const String labelUploadReport = "Upload Report";
  static const String labelGoodMorning = "Good Morning,";
  static const String labelArrivedAt = "Arrived at";
  static const String labelVehicleNo = "Vehicle No.";
  static const String labelViewDetail = "View Detail";
  static const String labelReports = "Reports";
  static const String labelBloodData = "Blood Data";
  static const String labelUploadedFiles = "Uploaded Files";
  static const String labelLookingDoctor = "Looking for a Doctor?";
  static const String labelSearchHint = "Search Doctor or Service Here...";
  static const String labelCallEms = "Calling an Ambulance";
  static const String labelYourself = "For Yourself";
  static const String labelOthers = "For Others";
  static const String labelNext = "Confirm Location";
  static const String labelSelectAddress = "Select Address";
  static const String labelConfirmLocation = "Confirm Location";
  static const String labelPickupLocation = "Pickup Location";
  static const String labelEnterPickupLocation = "Enter Pickup Location";
  static const String labelDropLocation = "Drop Location";
  static const String labelEnterDropLocation = "Enter Drop Location";
  static const String labelNearbyHospital = "Nearby Hospital";
  static const String labelDeleteAccount = "Delete Account";
  static const String labelPatientsSummary = "Recent Patients";
  static const String labelViewAll = "View All";
  static const String labelSearchPatient = "Search Patient";
  static const String labelActiveRide = "Active Ride";
  static const String labelDistance = "Distance";
  static const String labelHistory = "History";
  static const String labelNewRequest = "New Request";
  static const String labelAccept = "Accept";
  static const String labelReject = "Reject";
  static const String labelProfile = "Profile";
  static const String labelUpdate = "Update";
  static const String labelNotification = "Notification";
}

//Button Strings
class AgoraString {
  static const String agoraAppId = "cde997b7f2a34b32b6876604c28725d9";
}

//Button Strings
class ImageString {
  static const String icPlaceHolder = "";
  static const String imgProfile = "assets/images/profile.png";

}

class PreferenceString {
  static const String prefsToken = "token";
  static const String prefsRole = "role";
  static const String prefsUserId = "userId";
  static const String prefsName = "name";
  static const String userResponse = "userData";
}

class StaticList {
  static const List<String> occupations  = [
    'MBBS',
    'MBChB',
    'BDS',
    'BAMS',
    'BHMS',
    'BUMS',
    'BNYS',
    'BPT',
    'BPharm'
  ];

  static const List<String> doctorType  = [
    'General Physician / Family Doctor',
    'Pediatrician',
    'Gynecologist / Obstetrician',
    'Cardiologist',
    'Dermatologist',
    'Orthopedic Doctor',
    'Neurologist',
    'Psychiatrist',
    'Psychologist / Therapist',
    'ENT Specialist',
    'Ophthalmologist',
    'Dentist',
    'Endocrinologist',
    'Gastroenterologist',
    'Pulmonologist',
    'Nephrologist',
    'Oncologist',
    'Hematologist',
    'Rheumatologist',
    'Surgeon (General Surgery)',
    'Plastic / Cosmetic Surgeon',
    'Radiologist',
    'Pathologist',
    'Emergency Medicine Doctor',
    'Urologist',
    'Geriatrician',
    'Allergist / Immunologist',
    'Anesthesiologist',
  ];

  static const List<String> sexList = [
    "Male",
    "Female",
    "Other",
    "Prefer not to say",
  ];

  static const List<String> bloodGroup = [
    "A+",
    "A−",
    "B+",
    "B−",
    "AB+",
    "AB−",
    "O+",
    "O−",
  ];
}



class GreetingMessage {
  static String getGreetingMessage() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }
}
