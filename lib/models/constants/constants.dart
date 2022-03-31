import 'package:flutter/material.dart';
import 'package:igea_app/models/enums/status_type.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:igea_app/models/status.dart';
import 'package:igea_app/models/test.dart';
import '../breast_familiarity_risk.dart';
import '../enums/breast_familiarity_type.dart';
import '../colon_familiarity_risk.dart';
import '../enums/colon_familiarity_type.dart';

///## Igea S.R.L.S
///This class contains static constants used in any context.
///It contains keys used inside the Map objects for input and output data
class Constants {
  //USER
  static const USER_ID_KEY = 'user_ID';
  static const USER_FIRST_ACCESS_KEY = 'first_access';

  //REGISTRY
  static const REGISTRY_USERNAME_KEY = 'username';
  static const REGISTRY_NAME_KEY = 'name';
  static const REGISTRY_SURNAME_KEY = 'surname';
  static const REGISTRY_DATE_OF_BIRTH_KEY = 'date_of_birth';
  static const REGISTRY_DOMICILE_KEY = 'domicile';
  static const REGISTRY_FISCAL_CODE_KEY = 'fiscal_code';
  static const REGISTRY_GENDER_KEY = 'gender';

  //TEST
  static const TEST_ID_KEY = 'test_key';
  static const TEST_DATE_KEY = 'test_date';
  static const TEST_PLACE_KEY = 'test_place';
  static const TEST_HAS_OUTCOME_KEY = 'has_outcome';
  static const TEST_TYPE_KEY = 'type';
  static const TEST_ORGAN_KEY_KEY = 'organ_key';

  static const TEST_NAME_KEY = 'test_name';
  static const TEST_MAMMOGRAPHY_NAME = 'Mammografia';
  static const TEST_PAPTEST_NAME = 'Pap-Test';
  static const TEST_HPVDNA_NAME = 'HPV-DNA Test';
  static const TEST_SOF_NAME = 'Sof';
  static const TEST_BLOOD_NAME = 'Esame del sangue';

  static const TEST_DESCRIPTION_KEY = 'description';
  static const TEST_MAMMOGRAPHY_DESCRIPTION = 'description';
  static const TEST_PAPTEST_DESCRIPTION_KEY = 'description';
  static const TEST_HPVDNA_DESCRIPTION_KEY = 'description';
  static const TEST_SOF_DESCRIPTION_KEY = 'description';
  static const TEST_BLOOD_DESCRIPTION_KEY = 'description';
  static const LAST_TEST_DATE_KEY = 'last_test_date';

  //CAMERA CONSTANTS
  static const CAMERA_FILE_KEY = 'camera_file_key';
  static const CAMERA_IMAGE_PATH = 'camera_image_path';

  //RESERVATION
  static const RESERVATION_KEY = 'reservation';
  static const RESERVATION_DATE_KEY = 'date';
  static const RESERVATION_NAME_KEY = 'name';
  static const RESERVATION_LOCATION_NAME_KEY = 'location_name';
  static const RESERVATION_DESCRIPTION_KEY = 'description';
  static const RESERVATION_LOCATION_KEY = 'location';

  //OUTCOME
  static const OUTCOME_KEY = 'outcome_key';
  static const OUTCOME_VALUE_KEY = 'outcome_value';
  static const OUTCOME_DESCRIPTION_KEY = 'description';
  static const OUTCOME_TRYGLIC_KEY = 'tryglicerides';
  static const OUTCOME_CHOL_TOT_KEY = 'cholesterolTot';
  static const OUTCOME_CHOL_HDL_KEY = 'cholesterolHDL';
  static const OUTCOME_CHOL_LDL_KEY = 'cholesterolLDL';
  static const OUTCOME_SYST_PRESS_KEY = 'systolicPressure';

  //ORGAN
  static const NO_ORGAN_KEY = '000';
  static const BREAST_KEY = '001';
  static const COLON_KEY = '002';
  static const UTERUS_KEY = '003';
  static const HEART_KEY = '004';
  static const ORGAN_KEY = 'organ_key';
  static const ORGAN_TYPE_KEY = 'type';
  static const ORGAN_NAME_KEY = 'name';
  static const ORGAN_DESCRIPTION_KEY = 'description';
  static const ORGAN_STATUS_KEY = 'status';
  static const ORGAN_ACTIVE_KEY = 'active';
  static const ORGAN_FAMILIARITY_KEY = 'familiarity';
  static const ORGAN_HPV_VACCINE_KEY = 'hpv_vaccine';
  static const ORGAN_POSITIVE_KEY = 'positive';
  static const ORGAN_RESERVABLE_TEST_LIST_KEY = 'reservable_test_list';

  static const ORGAN_BREAST_NAME = 'Mammella';
  static const ORGAN_COLON_NAME = 'Colon';
  static const ORGAN_UTERUS_NAME = 'Utero';
  static const ORGAN_HEART_NAME = 'Cuore';

  static const ORGAN_BREAST_FAMILIARITY_KEY = 'breast_familiarity';
  static const ORGAN_COLON_FAMILIARITY_KEY = 'colon_familiarity';

  static const ORGAN_BREAST_IMAGE_PATH = 'assets/icons/tits.svg';
  static const ORGAN_COLON_IMAGE_PATH = 'assets/icons/colon.svg';
  static const ORGAN_UTERUS_IMAGE_PATH = 'assets/icons/utero.svg';
  static const ORGAN_HEART_IMAGE_PATH = 'assets/icons/heart.svg';
  //static const ORGAN_ICON_PATH = 'path//';

  static const ORGAN_HEART_SMOKE_KEY = 'smoke';
  static const ORGAN_HEART_DIABETES_KEY = 'diabetes';
  static const ORGAN_HEART_HYPERTENSION_KEY = 'hypertension';
  static const ORGAN_HEART_TRYGLIC_KEY = 'tryglicerides';
  static const ORGAN_HEART_CHOL_TOT_KEY = 'cholesterolTot';
  static const ORGAN_HEART_CHOL_HDL_KEY = 'cholesterolHDL';
  static const ORGAN_HEART_CHOL_LDL_KEY = 'cholesterolLDL';
  static const ORGAN_HEART_SYST_PRESS_KEY = 'systolicPressure';
  static const ORGAN_HEART_DIAST_PRESS_KEY = 'diastolicPressure';
  static const ORGAN_HEART_TREATMENT_BLOOD_PRESS_KEY =
      'treatment_blood_pressure';
  static const ORGAN_HEART_ETHNICITY_KEY = 'ethnicity';
  static const ORGAN_HEART_YEAR_LAST_CARDIO_VISIT = 'year_last_cardio_visit';
  static const ORGAN_HEART_YEAR_LAST_ECO_TSA_VISIT = 'year_last_eco_tsa';

  //BREAST FAMILIARITY RISK
  static const BreastFamiliarityRisk BREAST_FAMILIARITY_HIGH =
      BreastFamiliarityRisk(
    'Rischio familiarità alto',
    'assets/avatars/arold_in_circle.svg',
    'Ti consiglio di parlarne con il tuo medico di base ed eventualmente fare una visita ad un ambulatorio del rischio eredo familiare',
    BreastFamiliarityType.HIGH,
  );
  static const BreastFamiliarityRisk BREAST_FAMILIARITY_MODERATE =
      BreastFamiliarityRisk(
    'Rishio familiarità moderato',
    'assets/avatars/arold_in_circle.svg',
    'Ti consiglio di parlarne con il tuo medico di base',
    BreastFamiliarityType.MODERATE,
  );
  static const BreastFamiliarityRisk BREAST_FAMILIARITY_LOW =
      BreastFamiliarityRisk(
    'Rishio familiarità basso',
    'assets/avatars/arold_in_circle.svg',
    'Ti consiglio di parlarne con il tuo medico di base nel caso in cui il tumore fosse stato diagnosticato entro i 50 anni del tuo parente',
    BreastFamiliarityType.LOW,
  );
  static const BreastFamiliarityRisk BREAST_FAMILIARITY_NULL =
      BreastFamiliarityRisk(
    'Bene!',
    'assets/avatars/arold_in_circle.svg',
    'Non è stato riscontrato alcun rischio di familiarità',
    BreastFamiliarityType.NULL,
  );

  //COLON FAMILIARITY RISK
  static const ColonFamiliarityRisk COLON_FAMILIARITY_SYNDROM =
      ColonFamiliarityRisk(
    'Rischio familiarità',
    'assets/avatars/arold_in_circle.svg',
    'Ti consiglio di parlare con il tuo medico di base ed eventualmente prenotare una visita presso una clinica del rischio eredo-familiare',
    ColonFamiliarityType.SYNDROM,
  );
  static const ColonFamiliarityRisk COLON_FAMILIARITY_HIGH_UNDER_40 =
      ColonFamiliarityRisk(
    'Rishio familiarità alto',
    'assets/avatars/arold_in_circle.svg',
    'Ti consiglio di fare un esame SOF ogni 3 anni a partire da 10 anni prima della data di diagnosi del carcinoma al tuo parente. Inoltre consiglio una colonscopia ogni 5-10 anni',
    ColonFamiliarityType.HIGH_UNDER_40,
  );
  static const ColonFamiliarityRisk COLON_FAMILIARITY_HIGH_OVER_40 =
      ColonFamiliarityRisk(
    'Rishio familiarità alto',
    'assets/avatars/arold_in_circle.svg',
    'Ti consiglio di fare un esame SOF ogni 3 anni. Inoltre consiglio una colonscopia ogni 5-10 anni',
    ColonFamiliarityType.HIGH_OVER_40,
  );
  static const ColonFamiliarityRisk COLON_FAMILIARITY_MEDIUM =
      ColonFamiliarityRisk(
    'Rishio familiarità medio',
    'assets/avatars/arold_in_circle.svg',
    'Ti consiglio di fare un esame SOF ogni 3 anni e una sigmoidoscopia ogni 5 anni',
    ColonFamiliarityType.MEDIUM,
  );
  static const ColonFamiliarityRisk COLON_FAMILIARITY_NULL =
      ColonFamiliarityRisk(
    'Bene!',
    'assets/avatars/arold_in_circle.svg',
    'Non è stato riscontrato alcun rischio di familiarità',
    ColonFamiliarityType.NULL,
  );

  //ORGAN STATUS
  static const ORGAN_STATUS_GOOD_NAME = 'Good';
  static const ORGAN_STATUS_RESERVED_NAME = 'Reserved';
  static const ORGAN_STATUS_ISTIMETORESERVE_NAME = 'Is time to reserve';
  static const ORGAN_STATUS_LATETORESERVE_NAME = 'Late to reserve';
  static const ORGAN_STATUS_INACTIVE_NAME = 'Inactive';
  static const ORGAN_STATUS_LAST_EXAM_DATE_MISSING_NAME =
      'Last exam date missing';

  static const STATUS_COLOR_KEY = 'color';
  static const STATUS_ICON_KEY = 'icon';
  static const STATUS_MESSAGE_KEY = 'message';
  static const STATUS_NAME_KEY = 'name';
  static const STATUS_TYPE_KEY = 'status_type';

  static const ORGAN_STATUS_GOOD_COLOR = '0xff9BD9F5'; //GREEN
  static const ORGAN_STATUS_RESERVED_COLOR = '0xff9BD9F5'; //BLUE
  static const ORGAN_STATUS_ISTIMETORESERVE_COLOR = '0xff9BD9F5'; //YELLOW
  static const ORGAN_STATUS_LATETORESERVE_COLOR = '0xFFEB6D7B'; //RED
  static const ORGAN_STATUS_INACTIVE_COLOR = '0xFFADB5BD'; //GREY
  static const ORGAN_STATUS_LAST_EXAM_DATE_MISSING_COLOR = '0xFFADB5BD'; //GREY
  static const ORGAN_STATUS_OUT_OF_AGE_COLOR = '0xFFADB5BD'; //GREY

  static const ORGAN_STATUS_GOOD_ICON = 'path//';
  static const ORGAN_STATUS_RESERVED_ICON = 'path//';
  static const ORGAN_STATUS_ISTIMETORESERVE_ICON = 'path//';
  static const ORGAN_STATUS_LATETORESERVE_ICON = 'path//';
  static const ORGAN_STATUS_INACTIVE_ICON = 'assets/icons/danger_sign.svg';
  static const ORGAN_STATUS_LAST_EXAM_DATE_MISSING_ICON =
      'assets/icons/danger_sign.svg';
  static const ORGAN_STATUS_OUT_OF_AGE_ICON = 'assets/icons/danger_sign.svg';

  static const ORGAN_STATUS_GOOD_MESSAGE = 'Tutto ok';
  static const ORGAN_STATUS_RESERVED_MESSAGE = 'Esame\nprenotato';
  static const ORGAN_STATUS_ISTIMETORESERVE_MESSAGE = 'E\' ora di prenotare';
  static const ORGAN_STATUS_LATETORESERVE_MESSAGE = 'Sei in ritardo';
  static const ORGAN_STATUS_INACTIVE_MESSAGE = 'Non attivo';
  static const ORGAN_STATUS_LAST_EXAM_DATE_MISSING_MESSAGE =
      'Data ultimo esame mancante';
  static const ORGAN_STATUS_OUT_OF_AGE_MESSAGE = 'Screening terminato';

  static const ORGAN_STATUS_GOOD_TYPE = StatusType.GOOD;
  static const ORGAN_STATUS_RESERVED_TYPE = StatusType.RESERVED;
  static const ORGAN_STATUS_ISTIMETORESERVE_TYPE =
      StatusType.IS_TIME_TO_RESERVE;
  static const ORGAN_STATUS_LATETORESERVE_TYPE = StatusType.IS_IN_LATE;
  static const ORGAN_STATUS_INACTIVE_TYPE = StatusType.INACTIVE;
  static const ORGAN_STATUS_LAST_EXAM_DATE_MISSING_TYPE =
      StatusType.LAST_EXAM_DATE_MISSING;

  static const Status ORGAN_STATUS_GOOD = Status(
    'Good',
    '0xFF8AC165',
    'assets/icons/checked_circle.svg',
    'Tutto ok!',
    StatusType.GOOD,
  );

  static const Status ORGAN_STATUS_RESERVED = Status(
    'Reserved',
    '0xff9BD9F5',
    'assets/icons/check.svg',
    'Esame\nprenotato',
    StatusType.RESERVED,
  );

  static const Status ORGAN_STATUS_DEEPENING = Status(
    'Deepening',
    '0xFF8AC165',
    'assets/icons/danger_sign.svg',
    'Approfondimento',
    StatusType.DEEPENING,
  );

  static const Status ORGAN_STATUS_LATETORESERVE = Status(
    'Late to reserve',
    '0xFFEB6D7B',
    'assets/icons/red_q_mark.svg',
    'Sei in ritardo',
    StatusType.IS_IN_LATE,
  );

  static const Status ORGAN_STATUS_OUTOFAGE = Status(
    'Out of age',
    '0xFFADB5BD',
    'assets/checke_circle.svg',
    'Screening terminato',
    StatusType.OUT_OF_AGE,
  );

  static const Status ORGAN_STATUS_INACTIVE = Status(
    'Inattivo',
    '0xFFADB5BD',
    'assets/icons/danger_sign.svg',
    'Non attivo',
    StatusType.OUT_OF_AGE,
  );

  static const Map<TestType, String> DICT_TEST_TYPE_TO_ORGAN_KEY = {
    TestType.MAMMOGRAPHY: '001',
    TestType.SOF: '002',
    TestType.HPV_DNA: '003',
    TestType.PAP_TEST: '003',
    TestType.BLOOD_TEST: '004',
    TestType.ECO_TSA: '004',
    TestType.CARDIO_TEST: '004',
    TestType.GENERIC_TEST: null,
  };

  static const Map<TestType, String> DICT_TEST_TYPE_TO_TEST_NAME = {
    TestType.MAMMOGRAPHY: 'Mammografia',
    TestType.SOF: 'SOF',
    TestType.HPV_DNA: 'HPV DNA Test',
    TestType.PAP_TEST: 'Pap Test',
    TestType.BLOOD_TEST: 'Esame del sangue',
    TestType.ECO_TSA: 'Eco color doppler dei tronchi sovraortici',
    TestType.CARDIO_TEST: 'Visita cardiologica'
  };

  static Map<String, dynamic> RESTEST_MAMMOGRAPHY = {
    'description': 'description',
    'name': 'Mammografia',
    'type': TestType.MAMMOGRAPHY.index,
    'video_path': 'videopath//'
  };

  static Map<String, dynamic> RESTEST_SOF = {
    'description': 'description',
    'name': 'Sof',
    'type': TestType.SOF.index,
    'video_path': 'videopath//'
  };

  static Map<String, dynamic> RESTEST_HPV_DNA = {
    'description': 'description',
    'name': 'HPV DNA test',
    'type': TestType.HPV_DNA.index,
    'video_path': 'videopath//'
  };

  static Map<String, dynamic> RESTEST_PAP_TEST = {
    'description': 'description',
    'name': 'Pap test',
    'type': TestType.PAP_TEST.index,
    'video_path': 'videopath//'
  };

  static Map<String, dynamic> RESTEST_BLOOD_TEST = {
    'description': 'description',
    'name': 'Esame del sangue',
    'type': TestType.BLOOD_TEST.index,
    'video_path': 'videopath//'
  };

  static Map<String, dynamic> RESTEST_GENERIC_TEST = {
    'description': 'description',
    'name': 'Esame generico',
    'type': TestType.GENERIC_TEST.index,
    'video_path': 'videopath//'
  };
  static Map<String, dynamic> RESTEST_ECO_TSA = {
    'description': 'description',
    'name': 'Eco color doppler\ndei tronchi sovraortici',
    'type': TestType.ECO_TSA.index,
    'video_path': 'videopath//'
  };
  static Map<String, dynamic> RESTEST_CARDIO_TEST = {
    'description': 'description',
    'name': 'Visita cardiologica',
    'type': TestType.CARDIO_TEST.index,
    'video_path': 'videopath//'
  };

  static const String RESERVABLE_TEST_KEY = 'reservable_test';

  static List<ReservableTest> allReservableTestList = [
    ReservableTest(
      'description',
      'Mammografia',
      TestType.MAMMOGRAPHY,
      Constants.BREAST_KEY,
      'videoPath',
      [
        'Visita senologica',
        'Ecografia mammaria',
        'Agobiopsia per esame citologico',
        'Mammografia particolareggiata di approfondimento',
      ],
    ),
    ReservableTest(
      'description',
      'Visita senologica',
      TestType.IN_DEPTH_TEST,
      Constants.BREAST_KEY,
      'videoPath',
      [],
    ),
    ReservableTest(
      'description',
      'Ecografia mammaria',
      TestType.IN_DEPTH_TEST,
      Constants.BREAST_KEY,
      'videoPath',
      [],
    ),
    ReservableTest(
      'description',
      'Agobiopsia per esame citologico',
      TestType.IN_DEPTH_TEST,
      Constants.BREAST_KEY,
      'videoPath',
      [],
    ),
    ReservableTest(
      'description',
      'Mammografia particolareggiata di approfondimento',
      TestType.IN_DEPTH_TEST,
      Constants.BREAST_KEY,
      'videoPath',
      [],
    ),
    ReservableTest(
      'description',
      'Sangue occulto feci',
      TestType.SOF,
      Constants.COLON_KEY,
      'videoPath',
      [
        'Colonscopia',
        'Sigmoidoscopia',
        'Clisma opaco',
      ],
    ),
    ReservableTest(
      'description',
      'Colonscopia',
      TestType.SOF,
      Constants.COLON_KEY,
      'videoPath',
      [],
    ),
    ReservableTest(
      'description',
      'Sigmoidoscopia',
      TestType.SOF,
      Constants.COLON_KEY,
      'videoPath',
      [],
    ),
    ReservableTest(
      'description',
      'Clisma opaco',
      TestType.SOF,
      Constants.COLON_KEY,
      'videoPath',
      [],
    ),
    ReservableTest(
      'description',
      'Pap Test',
      TestType.PAP_TEST,
      Constants.UTERUS_KEY,
      'videoPath',
      ['Colposcopia'],
    ),
    ReservableTest(
      'description',
      'HPV DNA test',
      TestType.HPV_DNA,
      Constants.UTERUS_KEY,
      'videoPath',
      ['Colposcopia'],
    ),
    ReservableTest(
      'Description',
      'Colposcopia',
      TestType.PAP_TEST,
      Constants.UTERUS_KEY,
      'videoPath',
      [],
    ),
    ReservableTest(
      'description',
      'Altro esame',
      TestType.GENERIC_TEST,
      Constants.NO_ORGAN_KEY,
      'videoPath',
      [],
    ),
  ];

  static Map<TestType, ReservableTest> RESERVABLE_TEST_LIST = {
    TestType.MAMMOGRAPHY: ReservableTest('description', 'Mammografia',
        TestType.MAMMOGRAPHY, Constants.BREAST_KEY, 'videoPath', [
      'Visita senologica',
      'Ecografia mammaria',
      'Agobiopsia per esame citologico',
      'Mammografia particolareggiata di approfondimento',
    ]),
    TestType.SOF: ReservableTest('description', 'Sangue occulto feci',
        TestType.SOF, Constants.COLON_KEY, 'videoPath', [
      'Colonscopia',
      'Sigmoidoscopia',
      'Clisma opaco',
    ]),
    TestType.HPV_DNA: ReservableTest(
      'description',
      'HPV DNA test',
      TestType.HPV_DNA,
      Constants.UTERUS_KEY,
      'videoPath',
      ['Colposcopia'],
    ),
    TestType.PAP_TEST: ReservableTest(
      'description',
      'Pap Test',
      TestType.PAP_TEST,
      Constants.UTERUS_KEY,
      'videoPath',
      ['Colposcopia'],
    ),

    // TestType.BLOOD_TEST: ReservableTest(
    //   'description',
    //   'Esame del sangue',
    //   TestType.BLOOD_TEST,
    //   Constants.HEART_KEY,
    //   'videoPath',
    // ),
    // TestType.ECO_TSA: ReservableTest(
    //   'description',
    //   'Eco color doppler\ndei tronchi sovraortici',
    //   TestType.ECO_TSA,
    //   Constants.HEART_KEY,
    //   'videoPath',
    // ),
    // TestType.CARDIO_TEST: ReservableTest(
    //   'description',
    //   'Visita cardiologica',
    //   TestType.CARDIO_TEST,
    //   Constants.HEART_KEY,
    //   'videoPath',
    // ),
    TestType.GENERIC_TEST: ReservableTest(
      'description',
      'Altro esame',
      TestType.GENERIC_TEST,
      Constants.NO_ORGAN_KEY,
      'videoPath',
      [],
    ),
  };

  static const List<TestType> HEART_TESTS = [
    TestType.BLOOD_TEST,
    TestType.CARDIO_TEST,
  ];

  static const List<TestType> VESSELS_TESTS = [
    TestType.BLOOD_TEST,
    TestType.ECO_TSA,
  ];

  static const Map<String, String> PROVINCE_TO_PHONE_NUMBER = {
    'Pavia': '0001234567',
    'Milano': '0011234567',
    'Lodi': '0021234567',
    'Ragusa': '0031234567',
    'Enna': '0041234567',
    'Caltanissetta': '0051234567'
  };

  static const RESERVABLE_TEST_SOF_DESCRIPTION =
      "L\'esame del sangue occulto nelle feci consiste nella ricerca, compiuta attraverso metodologie diverse, di tracce di sangue non visibili a occhio nudo in un piccolo campione di feci";

  static const AROLD_BANNER_TEXT_QUESTIONARY_MENU =
      'Per poterti aiutare ho bisogno di sapere da te alcune informazioni:';

  static const String CHECK_QUESTIONARY_BREAST_KEY = 'breast_questionary';
  static const String CHECK_QUESTIONARY_COLON_KEY = 'colon_questionary';
  static const String CHECK_QUESTIONARY_UTERUS_KEY = 'uterus_questionary';
  static const String CHECK_QUESTIONARY_HEART_KEY = 'heart_questionary';
  static const String CHECK_QUESTIONARY_PSYCHO_KEY = 'psycho_questionary';

  static const Map<String, dynamic> ODD_CHAR_SCORE = {
    '0': 1,
    '1': 0,
    '2': 5,
    '3': 7,
    '4': 9,
    '5': 13,
    '6': 15,
    '7': 17,
    '8': 19,
    '9': 21,
    'A': 1,
    'B': 0,
    'C': 5,
    'D': 7,
    'E': 9,
    'F': 13,
    'G': 15,
    'H': 17,
    'I': 19,
    'J': 21,
    'K': 2,
    'L': 4,
    'M': 18,
    'N': 20,
    'O': 11,
    'P': 3,
    'Q': 6,
    'R': 8,
    'S': 12,
    'T': 14,
    'U': 16,
    'V': 10,
    'W': 22,
    'X': 25,
    'Y': 24,
    'Z': 23,
  };

  static const Map<String, dynamic> EVEN_CHAR_SCORE = {
    '0': 0,
    '1': 1,
    '2': 2,
    '3': 3,
    '4': 4,
    '5': 5,
    '6': 6,
    '7': 7,
    '8': 8,
    '9': 9,
    'A': 0,
    'B': 1,
    'C': 2,
    'D': 3,
    'E': 4,
    'F': 5,
    'G': 6,
    'H': 7,
    'I': 8,
    'J': 9,
    'K': 10,
    'L': 11,
    'M': 12,
    'N': 13,
    'O': 14,
    'P': 15,
    'Q': 16,
    'R': 17,
    'S': 18,
    'T': 19,
    'U': 20,
    'V': 21,
    'W': 22,
    'X': 23,
    'Y': 24,
    'Z': 25,
  };

  static const Map<String, dynamic> CONTROL_CHAR_DICT = {
    '0': 'A',
    '1': 'B',
    '2': 'C',
    '3': 'D',
    '4': 'E',
    '5': 'F',
    '6': 'G',
    '7': 'H',
    '8': 'I',
    '9': 'J',
    '10': 'K',
    '11': 'L',
    '12': 'M',
    '13': 'N',
    '14': 'O',
    '15': 'P',
    '16': 'Q',
    '17': 'R',
    '18': 'S',
    '19': 'T',
    '20': 'U',
    '21': 'V',
    '22': 'W',
    '23': 'X',
    '24': 'Y',
    '25': 'Z',
  };

  // CLOUD FUNCTIONS CONSTANTS
  static const PARENT_YEAR_DIAGNOSIS_KEY = 'parent_year_diagnosis';

  // MESSAGES
  static const String PREVENGO_MESSAGE_DEEPENING =
      'Hey! Ho notato che hai prenotato un esame di approfondimento. Le informazioni di questa sezione sono temporaneamente sospese.\nTranquillo! Non appena registrerai l\'esito lo riattiverò';
  static const String PREVENGO_MESSAGE_OUTOFAGE =
      'Ehy! Attualmente il programma di screening per la tua fascia di età è terminato. Non ti preoccupare potrai continuare ad inserire i tuoi esiti e promemoria per tener controllati i tuoi esami';
  static const String PREVENGO_MESSAGE_BREAST_FAM_RISK_HIGH =
      'Ti consiglio di rivolgerti al tuo medico di base o ad un ambulatorio del rischio eredo-familiare';
  static const String PREVENGO_MESSAGE_BREAST_FAM_RISK_MODERATE =
      'Ti consiglio di parlarne con il tuo medico di base';
  static const String PREVENGO_MESSAGE_BREAST_FAM_RISK_LOW =
      'Ti consiglio di parlarne con il tuo medico di base nel caso in cui il tumore fosse stato diagnosticato entro i 50 anni del tuo parente';
  static const String PREVENGO_MESSAGE_COLON_FAM_RISK_HIGHOVER40 =
      'Secondo le linee guida ministeriali, le persone della tua età dovrebbero fare un esame SOF ogni 3 anni. Inoltre consiglio una colonscopia ogni 5-10 anni';
  static const String PREVENGO_MESSAGE_COLON_FAM_RISK_HIGHUNDER40 =
      'Secondo le linee guida ministeriali, le persone della tua età dovrebbero fare un esame SOF ogni 3 anni a partire da 10 anni prima della data di diagnosi del carcinoma al tuo parente. Inoltre consiglio una colonscopia ogni 5-10 anni';
  static const String PREVENGO_MESSAGE_COLON_FAM_RISK_MEDIUM =
      'Ti consiglio di fare un esame SOF ogni 3 anni e una sigmoidoscopia ogni 5 anni';
  static const String PREVENGO_MESSAGE_COLON_FAM_RISK_SYNDROM =
      'Ti consiglio di parlare con il tuo medico di base ed eventualmente prenotare una visita presso una clinica del rischio eredo-familiare';
  static const String PREVENGO_MESSAGE_UTERUS_NO_VACCINATION =
      'Il vaccino è rivolto in particolare alla donne tra i 12 e i 26 anni e agli uomini, non solo per prevenire possibili patologie legate al virus, ma anche per ridurne la circolazione';
}
