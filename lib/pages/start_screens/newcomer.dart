import 'dart:developer';
// import 'dart:math';

import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/main.dart';
import 'package:exploreapp/pages/start_screens/cinematic.dart';
import 'package:exploreapp/pages/start_screens/sign_in_sign_up.dart';
import 'package:exploreapp/src/permissions.dart';
import 'package:exploreapp/wigets/explorea-btn.dart';
import 'package:exploreapp/wigets/explorea-chekbox.dart';
import 'package:exploreapp/wigets/explorea-text.dart';
import 'package:exploreapp/wigets/explorea-title.dart';
import 'package:exploreapp/wigets/explorea_btn_square.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Newcomer extends StatefulWidget {
  const Newcomer({Key? key}) : super(key: key);

  @override
  _NewcomerState createState() => _NewcomerState();
}

class _NewcomerState extends State<Newcomer> {
  int step = 1; // step/5

  final List<int> days = [];
  final List<String> months = [
    "JAN",
    "FEV",
    "MAR",
    "AVR",
    "MAI",
    "JUN",
    "JUL",
    "AOU",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];
  final List<int> years = [];

  int? daySelected;
  String? monthSelected;
  int? yearSelected;

  SharedPreferences? prefs;
  int? prefUserBirthdate_day;
  String? prefUserBirthdate_month;
  int? prefUserBirthdate_year;
  bool? agreedData;
  bool? agreedAd;
  bool prefAgreedGeo = false;
  bool prefAgreedMicro = false;
  bool prefAgreedCamera = false;

  Future<void> initializePreference() async {
    // Prefer to use SharedPref custom class.
    this.prefs = await SharedPreferences.getInstance();

    this.prefUserBirthdate_day = prefs?.getInt("userBirthdate_day");
    this.prefUserBirthdate_month = prefs?.getString("userBirthdate_month");
    this.prefUserBirthdate_year = prefs?.getInt("userBirthdate_year");
    //
    this.agreedData = prefs?.getBool("dataAgreed") as bool;
    //
    this.agreedAd = prefs?.getBool("adAgreed") as bool;
    //
    this.prefAgreedGeo = prefs?.getBool("geoAgreed") as bool;
    this.prefAgreedMicro = prefs?.getBool("microAgreed") as bool;
    this.prefAgreedCamera = prefs?.getBool("cameraAgreed") as bool;
  }

  @override
  initState() {
    if (!kIsWeb) SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();

    this.initializePreference().whenComplete(() {
      // XXX MAYBE: make it responsive instead
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

      setState(() {});
    });
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([]);

    super.dispose();
  }

  // TODO: Add true adds text.
  String textLorem =
      "Tempor non non ullamco labore voluptate consectetur. Consectetur aliquip aliqua id sit incididunt proident deserunt eu. Magna veniam mollit quis ullamco ut cillum pariatur. Duis nulla consequat laboris proident laborum. Anim consectetur duis eu consectetur voluptate eiusmod. Esse aliquip veniam nisi anim consequat velit nulla. Est aute adipisicing eu veniam laboris enim aute irure. Aliqua sunt culpa esse fugiat sint qui qui officia et sunt laboris cillum nulla. Cupidatat est enim nostrud consequat dolor sunt qui magna pariatur. Elit cupidatat duis aute eiusmod velit pariatur aute nostrud minim elit in. Velit cupidatat minim quis incididunt in est deserunt consectetur cillum nisi ullamco velit anim. Minim dolor commodo labore dolor. Sit aliquip qui amet id occaecat irure commodo minim nisi ad sunt. Velit enim sint sint laborum dolore nisi cillum consectetur. Ad occaecat excepteur minim duis laborum ullamco et qui elit deserunt Lorem velit nisi. Ea anim laboris adipisicing minim nisi deserunt enim consequat. Quis est duis quis ea. Adipisicing enim amet ad sint consequat adipisicing magna. Deserunt dolor commodo non voluptate adipisicing magna amet magna ad minim consequat nostrud. Sunt commodo do sit occaecat. Laboris laboris dolore dolor labore velit duis pariatur laborum ullamco. Aute excepteur ut proident nisi commodo voluptate ad qui qui culpa. Id dolor officia excepteur sit dolore. ";

  // TODO: Add true start text.
  String textStart =
      "Explor'ea, l'exploration game phygital. Un escape game urbain, sc??naris?? et immersif.";

  String textDataManage = """
  Objet
Chez Explor'ea, le respect de votre priv??e et de votre confidentialit?? est et sera toujours notre priorit?? absolue.
Nous concevons et d??veloppons nos produits de fa??on ?? ce que vous puissiez leur faire pleinement confiance et que votre seule et unique pr??occupation reste de d??couvrir des lieux en jouant avec nos exploration games. 
Cette politique de confidentialit?? (ci-apr??s PDC ??) a vocation ?? vous informer de l'utilisation de vos donn??es ?? caract??re personnel par Explor'ea.

   G??n??ralit??s
L'??dition de la l'Application Explor'ea est assur??e par la Soci??t?? Explor'ea SAS au capital de xxx euros immatricul??e au Registre de la Greffe du Tribunal de commerce de Rennes sous le num??ro RC n?? 000000000/ n?? identifiant fiscal FR00000000000 dont le si??ge social est situ?? au Rue Pierre de Maupertuis 35170 Bruz (ci-apr??s la Soci??t?? ??). 
Cette Soci??t?? est repr??sent??e par sa pr??sidente, Gloria CHESNEL.
Pour rappel, les personnes autoris??es ?? utiliser les Services Explor'ea sont d??finies dans les Conditions G??n??rales d'Utilisation et de Vente.

  Informations recueillies
Les informations que nous recueillons sont soit le fait de vos transmissions ?? notre ??gard, soit r??cup??r??es automatiquement lors de votre usage de nos services. 
Il y a deux types de donn??es que vous nous transmettez: 
les donn??es publiques, ?? savoir vos r??sultats et classement, visibles par les autres utilisateurs en fin de jeu. 
les donn??es priv??es, ?? savoir identifiants de connexion et nom d'??quipe,  qui ne sont visibles que par Explor'ea
Ces donn??es peuvent ??tre soit obligatoires pour utiliser nos Services, soit facultatives et en ce sens, il s'agit de votre choix personnel de les communiquer ou non.
 
    Donn??es relatives ?? l'inscription 
Lors de l'inscription, il est demand?? un identifiant mail et un mot de passe pour se connecter ?? l'Application Explor'ea.  
Donn??es relatives aux transmissions avec Match Activity :  
Lors de vos interactions avec Explor'ea, ?? travers la fonction de jeu, en envoyant un email ?? notre support ?? l'adresse contact.explorea@gmail.com, vous serez amen??s ?? nous communiquer des donn??es qui seront collect??es par Explor'ea. 
Ces donn??es sont notamment la date et l'heure de la prise de contact et toutes les informations n??cessaires ?? identifier les personnes (t??moignages satisfaction. suggestions.).
En acceptant d'utiliser l'Application Explor'ea, le Membre accepte de fait et sans r??serve la collecte de ces donn??es et le traitement r??alis?? par Explor'ea dans la pr??sente PDC. 
3.2 : Donn??es automatiquement recueillies 
Certaines donn??es sont automatiquement recueillies lors de votre utilisation de l'Application Explor'ea.
Ces donn??es sont de mani??re non exhaustive votre date d'inscription ?? l'Application, votre position g??ographique avec votre consentement initial (priv??e), vos achats de Sc??narios (priv??e) ou encore vos interactions dans le Jeu (priv??e).
Explor'ea ne consulte pas ces donn??es mais a la possibilit?? technique de le faire si jamais cela s'av??rait n??cessaire. Ces ??changes ne sont jamais communiqu??s ?? une tierce personne qui n'y a pas pris part, sauf sur requ??te judiciaire et/ou conform??ment aux dispositions l??gislatives ou r??glementaires applicables.  
La collecte de ces informations est obligatoire et essentielle ?? Explor'ea pour vous permettre d'utiliser nos Services.
En acceptant d'utiliser l'Application Explor'ea. l'Utilisateur accepte de fait et sans r??serve la collecte de ces donn??es et le traitement r??alis?? par Explor'ea dans la pr??sente PDC. 
 
Nota bene:
 
Explor'ea ne collecte et ne traite aucune donn??e bancaire.
 
Pour Android, le paiement est trait?? et g??r?? par la soci??t?? Stripe, leader mondial du paiement en ligne, qui g??re de mani??re crypt??e la communication avec les banques. Pour iOS, le paiement est trait?? et g??r?? par la soci??t?? Apple Inc directement via le compte iTunes du Membre.

Match Activity n'a aucun contr??le sur le paiement, sur le transfert de fonds ou encore sur le changement de devises et les frais inh??rents ?? ces op??rations. Explor'ea n'a aucun acc??s et ne collecte aucune donn??e de paiement.
L'int??gralit?? des op??rations de paiements sont g??r??es par la soci??t?? Stripe ou par Apple qui sont par cons??quent seuls responsables de l'int??gralit?? des op??rations de paiements. 
Pour plus d'informations sur la gestion par la soci??t?? Stripe des op??rations de paiements, les Utilisateurs de Explor'ea peuvent se rendre sur le lien suivant: https://stripe.com/fr/ privacy
A d??faut d'??l??ments contraires apport??s par le Membre abonn??, les registres informatis??s. conserv??s dans les syst??mes informatiques de Explor'ea dans des conditions raisonnables de s??curit??, seront consid??r??s comme les preuves des communications, des commandes, des validations et des paiements intervenus entre l'Utilisateur et Explor'ea. Ces informations feront foi sauf ?? en apporter la preuve ??crite et contraire par l'Utilisateur. L'archivage de ces ??l??ments est effectu?? sur un support fiable et durable de mani??re ?? correspondre ?? une copie fid??le et durable conform??ment ?? l'article 1348 du code civil. 
 
  Qu'est ce que nous faisons de vos donn??es ?
Vos donn??es sont collect??es et utilis??es car elles sont n??cessaires au bon fonctionnement de votre compte de Membre au sein de l'Application conform??ment ?? cette PDC et aux Conditions G??n??rales d'Utilisation, ce qui permet l'ex??cution du contrat entre vous et Explor'ea. Elles sont utilis??es notamment : 
pour cr??er et g??rer votre compte de Membre.
pour vous apporter le soutien technique au travers de notre support.
pour vous faire parvenir des notifications
Vos donn??es nous permettent de vous g??olocaliser avec votre consentement, ce qui nous permet de personnaliser votre exp??rience utilisateur en vous proposant les Sc??narios de Jeu qui se trouvent aux alentours de vous, et vous permet de vivre une exp??rience de jeu immersive. 
Nota bene: Votre g??olocalisation est priv??e et n'est accessible ?? aucune tierce personne et vous pouvez d??sactiver ?? tout moment cette option sur votre device.  
Vos donn??es sont utilis??es pour vous prot??ger en d??tectant des comportements frauduleux qui pourraient nuire ?? la s??curit?? de l'Application. Explor'ea a une obligation de moyen de tout mettre en oeuvre pour s??curiser au maximum ses Services donc si vous souhaitez appliquer votre droit de vous opposer ?? l'usage de certaines de ces donn??es tel que vous l'autorise la l??gislation, il se peut que nous soyons contraints de rompre le contrat qui nous lie et de devoir stopper notre collaboration pour des motifs l??gitimes et imp??ratifs.

 
  Comment g??rer vos droits sur vos donn??es ? 
Conform??ment ?? la loi n?? 78-17 du 6 janvier 1978, dite loi Informatique et Libert??s et au RGPD. chaque Membre dispose d'un droit d'acc??s, de rectification et, le cas ??ch??ant d'un droit ?? la portabilit?? et ?? l'effacement sur ses donn??es personnelles, ainsi que d'opposition au traitement ou ?? sa limitation et du droit de d??finir des directives relatives au sort de ses donn??es personnelles apr??s son d??c??s.
Explor'ea s'engage ?? respecter la protection des donn??es personnelles et ?? traiter ces demandes dans les meilleurs d??lais pour satisfaire au maximum les demandes de nos Membres. 
Pour exercer vos droits, vous pouvez, sous r??serve de prouver votre identit??, nous envoyer un email ?? contact.explorea@gmail.com en pr??cisant votre demande. 
Nota bene: En cas de d??saccord avec notre Soci??t??, vous pouvez ??mettre une r??clamation aupr??s de l'autorit?? de contr??le nationale comp??tente en mati??re de protection des donn??es.
Explication de vos droits susvis??s:
Le droit d'acc??s autorise le Membre ?? interroger Explor'ea en vue d'obtenir la communication des donn??es le concernant sous une forme accessible sur le fondement de l'article 39 de la loi Informatique et Libert??s et de l'article 15 du RGPD. Votre droit d'acc??s ne doit pas porter atteinte ?? la vie priv??e des tiers, c'est pourquoi vous n'aurez acc??s qu'?? vos donn??es personnelles et non pas ?? celles de tiers (par exemple, vous ne pourrez avoir communication que des messages que vous avez envoy??s et non pas de ceux que vous avez re??us).
Le droit de rectification conf??re au Membre le droit d'exiger d'Explor'ea que soient rectifi??es, compl??t??es, mises ?? jour ou effac??es les donn??es ?? caract??re personnel le concernant, qui sont inexactes, incompl??tes, ??quivoques, p??rim??es ou dont l'utilisation, la communication ou la conservation est interdite sur le fondement de l'article 40 de la loi Informatique et Libert??s et de l'article 16 du RGPD. Vous pouvez modifier ou rectifier certaines donn??es directement depuis l'application, dans la section ???Mon Profil??? 
Le droit ?? la portabilit?? conf??re au Membre le droit de recevoir les donn??es ?? caract??re personnel qu'il a fournies ?? Explor'ea, dans un format structur??, couramment utilis?? et lisible par machine et de les transmettre ?? un autre responsable de traitement, sur le fondement de l'article 20 du RGPD.
Le droit d'opposition conf??re au Membre le droit de s'opposer sans frais et de mani??re discr??tionnaire, ?? ce que ses donn??es soient utilis??es par Explor'ea ?? des fins de prospection, notamment commerciale et aux traitements fond??s sur l'int??r??t l??gitime de Explor'ea, sur le fondement de l'article 38 de la loi Informatique et Libert??s et de l'article 21 du RGPD. Pour les traitements fond??s sur l'int??r??t l??gitime. Explor'ea conserve la possibilit?? de justifier de motifs l??gitimes et imp??rieux pour continuer le traitement.

Le droit ?? l'effacement conf??re au Membre le droit d'exiger l'effacement sans frais de mani??re discr??tionnaire des donn??es communiqu??es ?? Explor'ea, dans la limite des droits fond??s sur l'article 17 du RGPD. Vous pouvez supprimer votre Compte en utilisant la fonctionnalit?? correspondante directement sur l'Application. Nous vous informons que l'ensemble de vos donn??es seront supprim??es de l'application Explor'ea. Cependant, Explor'ea, en tant qu'h??bergeur. a l'obligation l??gale de conserver vos donn??es personnelles pendant un an au titre de l'article 6-11) de la loi n'2004-575 du 21 juin 2004 pour la confiance dans l'??conomie num??rique. Vos donn??es seront conserv??es dans une base d'archives s??par??e de nos bases de production et seulement aux fins de r??pondre ?? une r??quisition judiciaire. Elles seront d??finitivement supprim??es ?? l'expiration du d??lai d'un an. 
Le droit ?? la limitation conf??re au Membre le droit de demander la limitation du traitement de ses donn??es par Explor'ea dans les conditions de l'article 18 du RGPD. 
Le droit pour le Membre de d??finir ses directives relatives ?? la conservation, ?? l'effacement et ?? la communication de ses donn??es ?? caract??re personnel apr??s son d??c??s conform??ment ?? l'article 40-1 de la loi Informatique et Libert??s
 
  Dur??e de conservation de vos donn??es
Vos donn??es sont stock??es par Explor'ea durant toute la p??riode o?? le Contrat repr??sent?? par les CGU vous lie ?? la Soci??t??.
Vos donn??es seront d??finitivement supprim??es un an apr??s la fin du Contrat susvis??, que cela intervienne suite ?? une suppression d??finitive du Compte par le Membre ou alors suite ?? une suppression du Compte du Membre par la Soci??t??. 
Lors de la suppression du Compte d'un Membre :  
Le profil du Membre sera rendu invisible aux autres Membres. 
Les donn??es du Membre seront conserv??es pendant le d??lai de 1 an ?? compter de cette date au regard notamment des obligations l??gales qui p??sent sur Explor'ea puis supprim??es d??finitivement ?? l'issue de ce d??lai.
 Les avantages disponibles sur le Compte du Membre au jour de la suppression de son compte seront d??finitivement perdus, sans possibilit?? de remboursement.
Le Membre ne pourra pas r??activer son ancien Compte et son adresse email utilis??e pour ce dernier ne sera plus utilisable sur l'Application durant l'ann??e de conservation de ses donn??es. 
Rappel, conform??ment ?? son statut d'h??bergeur. Explor'ea est tenu d'une obligation l??gale de conserver certaines donn??es ?? caract??re personnel des Membres pendant une dur??e d'un an sur le fondement de l'article 6. Il de la loi pour la confiance dans l'??conomie num??rique du 21 juin 2004.
 
  Nous contacter
Pour tout contact, il faudra nous justifier votre identit?? et nous fournir votre adresse email qui a servi ?? la cr??ation du Compte Explor'ea. 
Nos coordonn??es sont les suivantes:  contact.explorea@gmail.com 
Explor'ea fait tout ce qui est en son pouvoir pour vous garantir une protection des donn??es optimale mais n'h??sitez pas ?? nous contacter pour nous proposer des am??liorations ou des suggestions.
Explor'ea a toujours ??t?? et sera toujours ?? l'??coute de ses Utilisateurs car c'est gr??ce ?? vous que nous vivons une aventure extraordinaire.
Merci pour votre lecture.
""";

  @override
  Widget build(BuildContext context) {
    for (var i = 1; i <= 31; i++) {
      this.days.add(i);
    }

    int currentYear = new DateTime.now().year;
    for (var i = currentYear; i >= currentYear - 100; i--) {
      this.years.add(i);
    }

    return Container(
      decoration: const BoxDecoration(gradient: ExploreaGradients.yellow),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            this.step < 5
                ? Expanded(flex: 5, child: buildImage())
                : Container(),
            Expanded(
                flex: this.step < 5 ? 12 : (12 + 5),
                child: Column(
                  children: [
                    Container(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: buildStep(),
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 10.0,
                    child: LinearProgressIndicator(
                      minHeight: 10.0,

                      value: 0.20 * this.step,
                      backgroundColor: Colors.transparent,
                      valueColor:
                          new AlwaysStoppedAnimation(ExploreaColors.purple),
                      // backgroundColor: ExploreaColors.purple,
                      semanticsLabel: 'Linear progress indicator',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStep() {
    switch (this.step) {
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: ExploreaTitle(text: "Explor'ea"),
            ),
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          child: ExploreaText(
                              text: /* this.textStart */ this.textLorem)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                // child: ElevatedButton(
                //   onPressed: () {
                //     setState(() {
                //       this.step = 2;
                //     });
                //   },
                //   // style: ButtonStyle(
                //   //     shape:
                //   //         MaterialStateProperty.all<RoundedRectangleBorder>(
                //   //             RoundedRectangleBorder(
                //   //                 borderRadius:
                //   //                     BorderRadius.circular(100)))),
                //   style: ElevatedButton.styleFrom(
                //     shape: StadiumBorder(),
                //     primary: ExploreaColors.purple,
                //     minimumSize: Size(315.0, 53),
                //   ),

                //   child: Text("C'est parti !"),
                // ),

                child: ExploreaBtnSquare(
                  onPressed: () {
                    setState(() {
                      this.step = 2;
                    });
                  },
                  text: "C'est parti !",
                  paddingHorizontal: 50.5,
                ),
              ),
            ),
          ],
        );

        break;

      //

      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: ExploreaTitle(text: "Quel ??ge avez vous ?"),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Stack(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                            initialPage: this.prefUserBirthdate_day != null
                                ? this.prefUserBirthdate_day! - 1
                                : 0,
                            height: 50.0,
                            // aspectRatio: 10.0,
                            enlargeCenterPage: true,
                            viewportFraction: 0.3,
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            onPageChanged: (daySelected, changeReason) {
                              daySelected = daySelected % 31 + 1;
                              log((daySelected).toString());
                              log(changeReason.toString());

                              setState(() {
                                this.daySelected = daySelected;
                              });
                            }),
                        items: this.days.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  // width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  width: 50.0,
                                  alignment: Alignment.center,
                                  child: ExploreaTitle(
                                    text: '$i',
                                    color: i == this.daySelected
                                        ? ExploreaColors.purple
                                        : (i == this.prefUserBirthdate_day &&
                                                this.daySelected == null)
                                            ? ExploreaColors.purple
                                            : Colors.grey,
                                  ));
                            },
                          );
                        }).toList(),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_left,
                                color: ExploreaColors.purple,
                                size: 32.0,
                              ),
                              Expanded(
                                  child: Container(
                                color: Colors.green,
                              )),
                              Icon(
                                Icons.arrow_right,
                                color: ExploreaColors.purple,
                                size: 32.0,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                            initialPage: this
                                .months
                                .indexOf(this.prefUserBirthdate_month ?? "JAN"),
                            height: 50.0,
                            enlargeCenterPage: true,
                            viewportFraction: 0.3,
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            onPageChanged: (monthSelected, changeReason) {
                              this.monthSelected = this.months[monthSelected];
                              log((this.monthSelected).toString());
                              log(changeReason.toString());

                              setState(() {});
                            }),
                        items: this.months.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  // width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  // width: 70.0,
                                  alignment: Alignment.center,
                                  child: FittedBox(
                                    child: ExploreaTitle(
                                      text: '$i',
                                      color: i == this.monthSelected
                                          ? ExploreaColors.purple
                                          : (i == this.prefUserBirthdate_month &&
                                                  this.monthSelected == null)
                                              ? ExploreaColors.purple
                                              : Colors.grey,
                                    ),
                                  ));
                            },
                          );
                        }).toList(),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_left,
                                color: ExploreaColors.purple,
                                size: 32.0,
                              ),
                              Expanded(
                                  child: Container(
                                color: Colors.green,
                              )),
                              Icon(
                                Icons.arrow_right,
                                color: ExploreaColors.purple,
                                size: 32.0,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                            initialPage: this
                                .years
                                .indexOf(this.prefUserBirthdate_year ?? 2021),
                            reverse: true,
                            height: 50.0,
                            enlargeCenterPage: true,
                            viewportFraction: 0.3,
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            onPageChanged: (yearSelected, changeReason) {
                              this.yearSelected = this.years[yearSelected];
                              log((this.yearSelected).toString());
                              log(changeReason.toString());
                              setState(() {});
                            }),
                        items: this.years.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  // width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  // width: 70.0,
                                  alignment: Alignment.center,
                                  child: FittedBox(
                                    child: ExploreaTitle(
                                      text: '$i',
                                      color: i == this.yearSelected
                                          ? ExploreaColors.purple
                                          : (i == this.prefUserBirthdate_year &&
                                                  this.yearSelected == null)
                                              ? ExploreaColors.purple
                                              : Colors.grey,
                                    ),
                                  ));
                            },
                          );
                        }).toList(),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_left,
                                color: ExploreaColors.purple,
                                size: 32.0,
                              ),
                              Expanded(
                                  child: Container(
                                color: Colors.green,
                              )),
                              Icon(
                                Icons.arrow_right,
                                color: ExploreaColors.purple,
                                size: 32.0,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: ExploreaBtnSquare(
                text: "Suivant",
                disabled: (this.daySelected == null &&
                        this.prefUserBirthdate_day == null) ||
                    (this.monthSelected == null &&
                        this.prefUserBirthdate_month == null) ||
                    (this.yearSelected == null &&
                        this.prefUserBirthdate_year == null),
                onPressed: () {
                  setState(() {
                    this.step = 3;

                    if (this.daySelected != null) {
                      this.prefUserBirthdate_day = this.daySelected;
                      prefs?.setInt(
                          "userBirthdate_day", this.prefUserBirthdate_day!);
                    }
                    if (this.monthSelected != null) {
                      this.prefUserBirthdate_month = this.monthSelected;
                      prefs?.setString(
                          "userBirthdate_month", this.prefUserBirthdate_month!);
                    }
                    if (this.yearSelected != null) {
                      this.prefUserBirthdate_year = this.yearSelected;
                      prefs?.setInt(
                          "userBirthdate_year", this.prefUserBirthdate_year!);
                    }
                  });
                },
                paddingHorizontal: 50.5,
              )),
            ),
          ],
        );
        break;

//

      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(flex: 1, child: Container()),
            Expanded(
                flex: 2,
                child: ExploreaTitle(text: "La gestion de vos donn??es")),
            // TODO: add padding bot, for this step and the others surely
            Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Expanded(
                      child: Scrollbar(
                        isAlwaysShown: true,
                        child: SingleChildScrollView(
                            child: ExploreaText(text: this.textDataManage)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8, 0.0, 8.0),
                      child: Row(
                        children: [
                          ExploreaCheckbox(
                            isChecked: this.agreedData ?? false,
                            onChanged: (newValue) {
                              setState(() {
                                this.agreedData = newValue;
                                if (this.agreedData != null)
                                  prefs?.setBool(
                                      'dataAgreed', this.agreedData!);
                              });
                            },
                            label: "J'accepte...",
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Center(
                child: ExploreaBtnSquare(
                  text: "Suivant",
                  disabled: !(this.agreedData == true),
                  paddingHorizontal: 50.5,
                  onPressed: () {
                    setState(() {
                      this.step = 4;
                    });
                  },
                ),
              ),
            ),
          ],
        );

        break;

      //

      case 4:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: ExploreaTitle(text: "Publicit??s personnalis??es"),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Expanded(
                    // flex: 2,
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          child: ExploreaText(text: this.textLorem)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 8, 0.0, 8.0),
              child: Center(
                child: Row(
                  children: [
                    ExploreaCheckbox(
                      isChecked: this.agreedAd ?? false,
                      onChanged: (newValue) {
                        setState(() {
                          this.agreedAd = newValue;
                          if (this.agreedAd != null)
                            prefs?.setBool('adAgreed', this.agreedAd!);
                        });
                      },
                      label: "J'accepte...",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: ExploreaBtnSquare(
                  text: "Suivant",
                  disabled: !(this.agreedAd == true),
                  paddingHorizontal: 50.5,
                  onPressed: () {
                    setState(() {
                      this.step = 5;
                    });
                  },
                ),
              ),
            ),
          ],
        );

        break;

//

      case 5:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: 260.0,
                        child:
                            ExploreaTitle(text: "Autorisations mat??rielles")),
                  ],
                ),
              ),
            ),
            SizedBox(height: 22.0),

            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ExploreaBtn(
                          onPressed: () {
                            checkAndAskPosition().then((permission) {
                              if (permission.index > 1) {
                                setState(() {
                                  this.prefAgreedGeo = true;
                                  prefs?.setBool(
                                      'geoAgreed', this.prefAgreedGeo);
                                });
                              }
                            });
                          },
                          disabled: this.prefAgreedGeo == false,
                          icon: Icons.check,
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child:
                            // btn
                            Text("G??olocalisation",
                                style: TextStyle(
                                    color: ExploreaColors.purple,
                                    fontSize: 24.0)),
                        flex: 8,
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ExploreaBtn(
                          onPressed: () {
                            setState(() {
                              this.prefAgreedMicro = !this.prefAgreedMicro;
                              prefs?.setBool(
                                  'microAgreed', this.prefAgreedMicro);
                            });
                          },
                          disabled: this.prefAgreedMicro == false,
                          icon: Icons.check,
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Text("Microphone",
                            style: TextStyle(
                                color: ExploreaColors.purple, fontSize: 24.0)),
                        flex: 8,
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ExploreaBtn(
                          onPressed: () {
                            setState(() {
                              this.prefAgreedCamera = !this.prefAgreedCamera;
                              prefs?.setBool(
                                  'cameraAgreed', this.prefAgreedCamera);
                            });
                          },
                          disabled: this.prefAgreedCamera == false,
                          icon: Icons.check,
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Text("Appareil Photo",
                            style: TextStyle(
                                color: ExploreaColors.purple, fontSize: 24.0)),
                        flex: 8,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Expanded(child: Container()),
            Center(
                child: ExploreaBtnSquare(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Consumer<ApplicationState>(
                          builder: (context, appState, _) => SignInSignUp(
                            loginState: appState.loginState,
                          ),
                        )));
              },
              text: "C'est parti !",
              paddingHorizontal: 50.5,
              disabled: !(this.prefAgreedGeo == true &&
                  this.prefAgreedMicro == true &&
                  this.prefAgreedCamera == true),
            )),
          ],
        );

        break;

      default:
        return Container(
          color: Colors.red,
          width: 20.0,
          height: 20.0,
        );
    }
  }

  Widget buildImage() {
    switch (this.step) {
      case 1:
        return Container(
            // height: 275.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/home-scenes/home-scene-1.png"))));

      case 2:
        return Container(
            // height: 275.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/home-scenes/home-scene-2.png"))));

      case 3:
        return Container(
            // height: 275.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/home-scenes/home-scene-3.png"))));

      case 4:
        return Container(
            // height: 275.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/home-scenes/home-scene-3.png"))));

      default:
        return Container();
    }
  }
}
