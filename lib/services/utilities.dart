import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static final String checkQuestionaryBreastKey = 'breast_questionary';
  static final String checkQuestionaryColonKey = 'colon_questionary';
  static final String checkQuestionaryUterusKey = 'uterus_questionary';
  static final String checkQuestionaryHeartKey = 'heart_questionary';
  static final String checkQuestionaryPsychoKey = 'psycho_questionary';

  static final String usernameKey = 'username';
  static final String nameKey = 'name';
  static final String surnameKey = 'surname';
  static final String dateOfBirthKey = 'date_of_birth';
  static final String genderKey = 'gender';
  static final String fiscalCodeKey = 'fiscal_code';

  static Future<SharedPreferences> getSharedPreferencesInstance() async {
    return await SharedPreferences.getInstance();
  }

  static void saveKV(String key, dynamic value) async {
    SharedPreferences sharedPreferences = await getSharedPreferencesInstance();
    if (value is bool) {
      sharedPreferences.setBool(key, value);
    } else if (value is String) {
      sharedPreferences.setString(key, value);
    } else if (value is int) {
      sharedPreferences.setInt(key, value);
    } else if (value is double) {
      sharedPreferences.setDouble(key, value);
    } else if (value is List<String>) {
      sharedPreferences.setStringList(key, value);
    }
  }

  static void resetSharedPreferences(List<String> list) async {
    SharedPreferences sharedPreferences = await getSharedPreferencesInstance();
    for (String key in list) sharedPreferences.remove(key);
  }
}

class CacheManager {
  static final String checkQuestionaryBreastKey = 'breast_questionary';
  static final String checkQuestionaryColonKey = 'colon_questionary';
  static final String checkQuestionaryUterusKey = 'uterus_questionary';
  static final String checkQuestionaryHeartKey = 'heart_questionary';
  static final String checkQuestionaryPsychoKey = 'psycho_questionary';

  //REGISTRY DATA
  static final String usernameKey = 'username';
  static final String nameKey = 'name';
  static final String surnameKey = 'surname';
  static final String dateOfBirthKey = 'date_of_birth';
  static final String genderKey = 'gender';
  static final String fiscalCodeKey = 'fiscal_code';
  static final String colonFamiliarityKey = 'colon_familiarity';
  static final String relativeAgeList = 'relative_age_list';

  //UTERUS DATA
  static final String uterusAntiHpvVaccinationKey =
      'uterus_anti_hpv_vaccination';
  static final String uterusReservableTestKey = 'uterus_reservable_test';
  static final String uterusReservationKey = 'uterus_reservation';
  static final String uterusOutcomeFileKey = 'uterus_outcome_file';
  static final String uterusDontRememberReservationKey =
      'uterus_dont_remember_reservation';

  //BREAST DATA
  static final String breastParentCounterKey = 'breast_parent_counter';
  static final String breastCheckDadKey = 'breast_check_dad';
  static final String breastCheckMomKey = 'breast_check_mom';
  static final String breastCounterBrotherKey = 'breast_counter_brother';
  static final String breastCounterSisterKey = 'breast_counter_sister';
  static final String breastCounterAuntKey = 'breast_counter_aunt';
  static final String breastCounterGrandPAKey = 'breast_counter_grandpa';
  static final String breastCounterGrandMAKey = 'breast_counter_grandma';
  static final String breastReservableTestKey = 'breast_reservable_test';
  static final String breastReservationKey = 'breast_reservation';
  static final String breastOutcomeFileKey = 'breast_outcome_file';
  static final String breastCheckNoFamiliarityKey =
      'breast_check_no_familiarity';
  static final String breastDontRememberReservationKey =
      'breast_dont_remember_reservation';

  //COLON DATA
  static final String colonParentCounterKey = 'colon_parent_counter';
  static final String colonCheckDadKey = 'colon_check_dad';
  static final String colonCheckMomKey = 'colon_check_mom';
  static final String colonReservableTestKey = 'colon_reservable_test';
  static final String colonReservationKey = 'colon_reservation';
  static final String colonOutcomeFileKey = 'colon_outcome_file';
  static final String colonDontRememberReservationKey =
      'colon_dont_remember_reservation';
  static final String colonParentAgeKey = 'colon_parent_age';
  static final String colonCountSyndromsKey = 'colon_count_syndroms';
  static final String colonCheckNoFamiliarityKey = 'colon_check_no_familiarity';

  static final String flagModalRegistry = 'flag_modal_registry';
  static final String flagModalMenuQuestionaries =
      'flag_modal_menu_questionaries';
  static final String flagModalBreastFamiliarity =
      "flag_modal_breast_familiarity";
  static final String flagModalUterus = "flag_modal_uterus";
  static final String flagModalColonFamiliarity =
      "flag_modal_colon_familiarity";

  static Map<String, dynamic> cache = Map();

  static void saveKV(String key, dynamic value) {
    cache.addAll({key: value});
  }

  static void saveMultipleKV(Map<String, dynamic> values) {
    cache.addAll(values);
  }

  static dynamic getValue(String key) {
    return cache[key];
  }
}
