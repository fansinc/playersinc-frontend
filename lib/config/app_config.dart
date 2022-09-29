class AppConfig {
  static const grantType = "password";
  static const clientId = 2;
  static const clientSecret = "PLAYERSINC";

/*   static const google_grant_type = "social";
  static const google_client_id = 3;
  static const google_client_secret =
      //"SLF4Tzh81sdryRiIAA8Bdek2QnIbw9OfRLsm5QCR"; //dev
      "ZyQJMw6lm6GvDsn2RDkSzTt2wN1hs9d2vR0mXkO9"; //prod
  static const google_provider = "google";

  static const GM_Key = 'AIzaSyAMEwEMuQ-N565aEoiAfwKUfSDrMISheZ0'; */

  static const baseUrl = 'http://rocketapi.fansinc.io'; // dev
  // 'http://fansinc-api.hridham.com'; // dev HT

  static const authToken = '/oauth/token';
  static const registerUserUrl = '/api/guest/playerRegister';
  //'/api/users';
  //static const fanRegistrationUrl = '/api/guest/fanRegister';
  static const forgotPasswordUrl = '/api/forgot_password';

  static const forgotPasswordBodyUrl =
      'http://adminnew.getstaysavvy.co.uk/reset_password'; //prod
  //'http://adminnew.joinstaysavvy.co.uk/reset_password'; //dev

  /* Provider API URL's */
  static const playerRegister = '/api/guest/playerRegister';
  static const experienceUrl = '/api/Experience';
  static const myWeekUrl = '/api/MyWeek';
  static const assetsUrl = '/api/assets';
  static const purchaseUrl = '/api/Purchase';
  static const profileViewUrl = '/api/me/viewprofile';
  static const profileUpdateUrl = '/api/me/updateprofile';
  static const profileCreateUrl = '/api/me/createprofile';
  static const clubUrl = '/api/Club';
  static const injuryUrl = '/api/Injury';

  static const logTimeUrl = '/api/LogTime';
  static const concussionUrl = '/api/Concussion';
  static const topPlayUrl = '/api/TopPlay';
  static const skillUrl = '/api/Skill';
  static const getChallengesByLevelUrl =
      '/api/getChallengesByLevel?include=Challenges';
  static const getMissionsByLevel = '/api/getMissionsByLevel';
  static const playerChallenge = '/api/PlayerChallenge';

  static const playerMission = '/api/PlayerMission';

  // Config
  static const confSymptomUrl = '/api/ConfSymptom';
  static const playerPositionUrl = '/api/ConfPlayingPosition';
  /* Provider API URL's */

  /* Config Colors */

  static const blueColorHex = '#0e0d28';
  static const blackColorHex = '#1A1818';
  static const blueColor = 0xFF0e0d28;
  static const blackColor = 0xFF1A1818;
  static const orangeColorHex = '#F77E23';
  static const orangeColor = 0xFFF77E23;
  static const blueBorderColor = 0xFF88A0B5;
  static const greenColor = 0xFF2CC78F;
  static const lightGrey = 0xFFD8D8D8;
  static const grey = 0xFFc4c4c4;
  static const comingSoonColor = 0XFF1B181F;
  static const loginGradientStartColor = 0XFF23ACCC;
  static const loginGradientEndColor = 0XFF2BEBBC;
  static const buttonBlueColor = 0XFF53728D;
  static const tabGreyColor = 0XFF8E8EA0;
  static const tabMySeasonColor = 0XFFc7ddf1;
  static const tabMySeasonInjuryDataColor = 0XFFff892d;
  static const tabMySeasonSessionDataColor = 0XFF12adcf;
  //0XFF9bb5cc;

  static const skillsPageBGColor = 0XFF52728e;
  static const skillsPageSkillTitleBGColor = 0XFF668fb3;
  static const skillsPageButtonColor = 0XFF405f7d;

  static const logGameTimeColor = 0XFF52728e;
  static const logSeasonJournalColor = 0XFF52728e;
  static const logLastPlayedColor = 0XFF8dabc5;
  static const circularIndicatorGradientStartColor = 0XFFfee7a9;
  //0XFF9E81BB;
  static const circularIndicatorGradientMidColor = 0XFFfde898;
  //0XFF456C8E;
  static const circularIndicatorGradientEndColor = 0XFFd6b463;
  //0XFFD09BD7;
  static const healthCheckPageColor = 0XFF22204b;
  static const healthCheckPageButtonColor = 0XFF4f4c6d;
  static const healthCheckPageICEColor = 0XFFc82828;

  static const concussionAlertDialogColor = 0XFF12adcf;
  static const concussionAlertDialogBtnColor = 0XFFa6a7a6;

  static const concussionPageColor1 = 0XFF22204b;
  static const concussionPageColor2 = 0XFF22204b;
  static const concussionPageCircleColor = 0XFF12acce;
  static const concussionPageCircleColor2 = 0XFFf4f5f4;
  static const concussionPageTextBGColor = 0XFF888a99;
  static const concussionPageCheckBackColor = 0XFF13acce;

  static const concussionRecoveryPageCircleBGColor = 0XFFf9f8f8;
  static const concussionRecoveryPageBGColor = 0XFF141231;

  static const concussionLogPageTopColor = 0XFF646380;
  static const concussionLogPageHealthGradColor = 0XFF5a7c9b;
  static const concussionLogPageTickColor = 0XFF22214a;

  static const notificationPageColor = 0XFF2f4961;
  static const healthyMindPageColor = 0XFF53738e;
  //0XFF2f4961;
  static const logInjuryPageColor = 0XFF7d7c93;
  static const logInjuryButtonColor = 0XFF12accf;

  static const mySkillsAddEditBGColor = 0XFF8d9fae;
  static const mySkillsBGColor = 0XFF4f6e88;

  static const challengeGradientStartColor = 0XFF222858;
  static const challengeGradientEndColor = 0XFF12a5c9;
  static const bossChallengeColor = 0XFFd28c52;
  static const platinumChallengeStarColor = 0XFFcccdcd;

  static const challengeSubmitPageBGStartColor = 0XFFc9d4d8;
  static const challengeSubmitPageBGEndColor = 0XFFc2d0da;

  // Missions
  static const bronzeColor = 0XFFCD7F32;
  static const silverColor = 0XFFC0C0C0;
  static const goldColor = 0XFFD4AF37;
  //0XFFFFD700;

  /* Config Colors */

  /* Config Assets */
  static const defaultImage = 'assets/images/default.jpg';
  static const logoImage = 'assets/images/playersinc-logo.png';
  static const splashImage = 'assets/images/playersinc-logo.png';
  static const logoGoogleImage = 'assets/images/google_logo.png';
  static const tickImage = 'assets/icons/tick.png';
  static const comingSoonImage = 'assets/images/coming_soon.jpg';
  static const rugbyPlayerImage = 'assets/images/rugby_player_boy.jpeg';
  static const bedfordImage = 'assets/images/bedford-blues_logo.jpeg';
  static const noDataImage = 'assets/images/no_data.png';
  static const iceImage = 'assets/images/ice.png';
  static const aw1Image = 'assets/images/aw1.png';
  static const samImage = 'assets/images/sam_matavesi_cutout.png';
  //'assets/images/bedford-blues.png';

  static const concussionHeadImage = 'assets/images/concussion-head.png';
  static const navigationArrowImage = 'assets/images/navigation_arrow.png';
  static const navigationDotsImage = 'assets/images/navigation_dots.png';
  static const minusImage = 'assets/images/minus.png';
  static const plusImage = 'assets/images/plus.png';
  static const pencilImage = 'assets/images/pencil.png';
  static const tickmage = 'assets/images/tick.png';
  static const padlockImage = 'assets/images/padlock.png';
  static const addMediaImage = 'assets/images/add_media.png';
  static const scrollArrowsImage = 'assets/images/scroll_arrows.png';
  static const crossImage = 'assets/images/cross.png';
  static const hamburgerIconImage = 'assets/images/hamburger_icon.png';
  static const rugbyBallImage = 'assets/images/rugby_ball.png';
  static const statsportsIconImage = 'assets/images/statsports_icon.png';
  static const footballIconImage = 'assets/images/football_icon.png';
  static const cricketiconImage = 'assets/images/cricket_icon.png';
  static const playButtonImage = 'assets/images/play_button.png';
  static const appleWatchImage = 'assets/images/apple_watch.png';
  static const asteriskImage = 'assets/images/asterisk.png';
  static const barImage = 'assets/images/bar.png';
  static const grpIconImage = 'assets/images/grp_icon.png';
  static const loudspeakerImage = 'assets/images/loudspeaker.png';
  static const plasterIconImage = 'assets/images/plaster_icon.png';
  static const tickInCircleImage = 'assets/images/tick_in_circle.png';
}
