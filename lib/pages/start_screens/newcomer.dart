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
      "Explor'ea, l'exploration game phygital. Un escape game urbain, scénarisé et immersif.";

  String textDataManage = """
  Objet
Chez Explor'ea, le respect de votre privée et de votre confidentialité est et sera toujours notre priorité absolue.
Nous concevons et développons nos produits de façon à ce que vous puissiez leur faire pleinement confiance et que votre seule et unique préoccupation reste de découvrir des lieux en jouant avec nos exploration games. 
Cette politique de confidentialité (ci-après PDC ») a vocation à vous informer de l'utilisation de vos données à caractère personnel par Explor'ea.

   Généralités
L'édition de la l'Application Explor'ea est assurée par la Société Explor'ea SAS au capital de xxx euros immatriculée au Registre de la Greffe du Tribunal de commerce de Rennes sous le numéro RC nº 000000000/ nº identifiant fiscal FR00000000000 dont le siège social est situé au Rue Pierre de Maupertuis 35170 Bruz (ci-après la Société »). 
Cette Société est représentée par sa présidente, Gloria CHESNEL.
Pour rappel, les personnes autorisées à utiliser les Services Explor'ea sont définies dans les Conditions Générales d'Utilisation et de Vente.

  Informations recueillies
Les informations que nous recueillons sont soit le fait de vos transmissions à notre égard, soit récupérées automatiquement lors de votre usage de nos services. 
Il y a deux types de données que vous nous transmettez: 
les données publiques, à savoir vos résultats et classement, visibles par les autres utilisateurs en fin de jeu. 
les données privées, à savoir identifiants de connexion et nom d'équipe,  qui ne sont visibles que par Explor'ea
Ces données peuvent être soit obligatoires pour utiliser nos Services, soit facultatives et en ce sens, il s'agit de votre choix personnel de les communiquer ou non.
 
    Données relatives à l'inscription 
Lors de l'inscription, il est demandé un identifiant mail et un mot de passe pour se connecter à l'Application Explor'ea.  
Données relatives aux transmissions avec Match Activity :  
Lors de vos interactions avec Explor'ea, à travers la fonction de jeu, en envoyant un email à notre support à l'adresse contact.explorea@gmail.com, vous serez amenés à nous communiquer des données qui seront collectées par Explor'ea. 
Ces données sont notamment la date et l'heure de la prise de contact et toutes les informations nécessaires à identifier les personnes (témoignages satisfaction. suggestions.).
En acceptant d'utiliser l'Application Explor'ea, le Membre accepte de fait et sans réserve la collecte de ces données et le traitement réalisé par Explor'ea dans la présente PDC. 
3.2 : Données automatiquement recueillies 
Certaines données sont automatiquement recueillies lors de votre utilisation de l'Application Explor'ea.
Ces données sont de manière non exhaustive votre date d'inscription à l'Application, votre position géographique avec votre consentement initial (privée), vos achats de Scénarios (privée) ou encore vos interactions dans le Jeu (privée).
Explor'ea ne consulte pas ces données mais a la possibilité technique de le faire si jamais cela s'avérait nécessaire. Ces échanges ne sont jamais communiqués à une tierce personne qui n'y a pas pris part, sauf sur requête judiciaire et/ou conformément aux dispositions législatives ou réglementaires applicables.  
La collecte de ces informations est obligatoire et essentielle à Explor'ea pour vous permettre d'utiliser nos Services.
En acceptant d'utiliser l'Application Explor'ea. l'Utilisateur accepte de fait et sans réserve la collecte de ces données et le traitement réalisé par Explor'ea dans la présente PDC. 
 
Nota bene:
 
Explor'ea ne collecte et ne traite aucune donnée bancaire.
 
Pour Android, le paiement est traité et géré par la société Stripe, leader mondial du paiement en ligne, qui gère de manière cryptée la communication avec les banques. Pour iOS, le paiement est traité et géré par la société Apple Inc directement via le compte iTunes du Membre.

Match Activity n'a aucun contrôle sur le paiement, sur le transfert de fonds ou encore sur le changement de devises et les frais inhérents à ces opérations. Explor'ea n'a aucun accès et ne collecte aucune donnée de paiement.
L'intégralité des opérations de paiements sont gérées par la société Stripe ou par Apple qui sont par conséquent seuls responsables de l'intégralité des opérations de paiements. 
Pour plus d'informations sur la gestion par la société Stripe des opérations de paiements, les Utilisateurs de Explor'ea peuvent se rendre sur le lien suivant: https://stripe.com/fr/ privacy
A défaut d'éléments contraires apportés par le Membre abonné, les registres informatisés. conservés dans les systèmes informatiques de Explor'ea dans des conditions raisonnables de sécurité, seront considérés comme les preuves des communications, des commandes, des validations et des paiements intervenus entre l'Utilisateur et Explor'ea. Ces informations feront foi sauf à en apporter la preuve écrite et contraire par l'Utilisateur. L'archivage de ces éléments est effectué sur un support fiable et durable de manière à correspondre à une copie fidèle et durable conformément à l'article 1348 du code civil. 
 
  Qu'est ce que nous faisons de vos données ?
Vos données sont collectées et utilisées car elles sont nécessaires au bon fonctionnement de votre compte de Membre au sein de l'Application conformément à cette PDC et aux Conditions Générales d'Utilisation, ce qui permet l'exécution du contrat entre vous et Explor'ea. Elles sont utilisées notamment : 
pour créer et gérer votre compte de Membre.
pour vous apporter le soutien technique au travers de notre support.
pour vous faire parvenir des notifications
Vos données nous permettent de vous géolocaliser avec votre consentement, ce qui nous permet de personnaliser votre expérience utilisateur en vous proposant les Scénarios de Jeu qui se trouvent aux alentours de vous, et vous permet de vivre une expérience de jeu immersive. 
Nota bene: Votre géolocalisation est privée et n'est accessible à aucune tierce personne et vous pouvez désactiver à tout moment cette option sur votre device.  
Vos données sont utilisées pour vous protéger en détectant des comportements frauduleux qui pourraient nuire à la sécurité de l'Application. Explor'ea a une obligation de moyen de tout mettre en oeuvre pour sécuriser au maximum ses Services donc si vous souhaitez appliquer votre droit de vous opposer à l'usage de certaines de ces données tel que vous l'autorise la législation, il se peut que nous soyons contraints de rompre le contrat qui nous lie et de devoir stopper notre collaboration pour des motifs légitimes et impératifs.

 
  Comment gérer vos droits sur vos données ? 
Conformément à la loi n° 78-17 du 6 janvier 1978, dite loi Informatique et Libertés et au RGPD. chaque Membre dispose d'un droit d'accès, de rectification et, le cas échéant d'un droit à la portabilité et à l'effacement sur ses données personnelles, ainsi que d'opposition au traitement ou à sa limitation et du droit de définir des directives relatives au sort de ses données personnelles après son décès.
Explor'ea s'engage à respecter la protection des données personnelles et à traiter ces demandes dans les meilleurs délais pour satisfaire au maximum les demandes de nos Membres. 
Pour exercer vos droits, vous pouvez, sous réserve de prouver votre identité, nous envoyer un email à contact.explorea@gmail.com en précisant votre demande. 
Nota bene: En cas de désaccord avec notre Société, vous pouvez émettre une réclamation auprès de l'autorité de contrôle nationale compétente en matière de protection des données.
Explication de vos droits susvisés:
Le droit d'accès autorise le Membre à interroger Explor'ea en vue d'obtenir la communication des données le concernant sous une forme accessible sur le fondement de l'article 39 de la loi Informatique et Libertés et de l'article 15 du RGPD. Votre droit d'accès ne doit pas porter atteinte à la vie privée des tiers, c'est pourquoi vous n'aurez accès qu'à vos données personnelles et non pas à celles de tiers (par exemple, vous ne pourrez avoir communication que des messages que vous avez envoyés et non pas de ceux que vous avez reçus).
Le droit de rectification confère au Membre le droit d'exiger d'Explor'ea que soient rectifiées, complétées, mises à jour ou effacées les données à caractère personnel le concernant, qui sont inexactes, incomplètes, équivoques, périmées ou dont l'utilisation, la communication ou la conservation est interdite sur le fondement de l'article 40 de la loi Informatique et Libertés et de l'article 16 du RGPD. Vous pouvez modifier ou rectifier certaines données directement depuis l'application, dans la section “Mon Profil” 
Le droit à la portabilité confère au Membre le droit de recevoir les données à caractère personnel qu'il a fournies à Explor'ea, dans un format structuré, couramment utilisé et lisible par machine et de les transmettre à un autre responsable de traitement, sur le fondement de l'article 20 du RGPD.
Le droit d'opposition confère au Membre le droit de s'opposer sans frais et de manière discrétionnaire, à ce que ses données soient utilisées par Explor'ea à des fins de prospection, notamment commerciale et aux traitements fondés sur l'intérêt légitime de Explor'ea, sur le fondement de l'article 38 de la loi Informatique et Libertés et de l'article 21 du RGPD. Pour les traitements fondés sur l'intérêt légitime. Explor'ea conserve la possibilité de justifier de motifs légitimes et impérieux pour continuer le traitement.

Le droit à l'effacement confère au Membre le droit d'exiger l'effacement sans frais de manière discrétionnaire des données communiquées à Explor'ea, dans la limite des droits fondés sur l'article 17 du RGPD. Vous pouvez supprimer votre Compte en utilisant la fonctionnalité correspondante directement sur l'Application. Nous vous informons que l'ensemble de vos données seront supprimées de l'application Explor'ea. Cependant, Explor'ea, en tant qu'hébergeur. a l'obligation légale de conserver vos données personnelles pendant un an au titre de l'article 6-11) de la loi n'2004-575 du 21 juin 2004 pour la confiance dans l'économie numérique. Vos données seront conservées dans une base d'archives séparée de nos bases de production et seulement aux fins de répondre à une réquisition judiciaire. Elles seront définitivement supprimées à l'expiration du délai d'un an. 
Le droit à la limitation confère au Membre le droit de demander la limitation du traitement de ses données par Explor'ea dans les conditions de l'article 18 du RGPD. 
Le droit pour le Membre de définir ses directives relatives à la conservation, à l'effacement et à la communication de ses données à caractère personnel après son décès conformément à l'article 40-1 de la loi Informatique et Libertés
 
  Durée de conservation de vos données
Vos données sont stockées par Explor'ea durant toute la période où le Contrat représenté par les CGU vous lie à la Société.
Vos données seront définitivement supprimées un an après la fin du Contrat susvisé, que cela intervienne suite à une suppression définitive du Compte par le Membre ou alors suite à une suppression du Compte du Membre par la Société. 
Lors de la suppression du Compte d'un Membre :  
Le profil du Membre sera rendu invisible aux autres Membres. 
Les données du Membre seront conservées pendant le délai de 1 an à compter de cette date au regard notamment des obligations légales qui pèsent sur Explor'ea puis supprimées définitivement à l'issue de ce délai.
 Les avantages disponibles sur le Compte du Membre au jour de la suppression de son compte seront définitivement perdus, sans possibilité de remboursement.
Le Membre ne pourra pas réactiver son ancien Compte et son adresse email utilisée pour ce dernier ne sera plus utilisable sur l'Application durant l'année de conservation de ses données. 
Rappel, conformément à son statut d'hébergeur. Explor'ea est tenu d'une obligation légale de conserver certaines données à caractère personnel des Membres pendant une durée d'un an sur le fondement de l'article 6. Il de la loi pour la confiance dans l'économie numérique du 21 juin 2004.
 
  Nous contacter
Pour tout contact, il faudra nous justifier votre identité et nous fournir votre adresse email qui a servi à la création du Compte Explor'ea. 
Nos coordonnées sont les suivantes:  contact.explorea@gmail.com 
Explor'ea fait tout ce qui est en son pouvoir pour vous garantir une protection des données optimale mais n'hésitez pas à nous contacter pour nous proposer des améliorations ou des suggestions.
Explor'ea a toujours été et sera toujours à l'écoute de ses Utilisateurs car c'est grâce à vous que nous vivons une aventure extraordinaire.
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
              child: ExploreaTitle(text: "Quel âge avez vous ?"),
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
                child: ExploreaTitle(text: "La gestion de vos données")),
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
              child: ExploreaTitle(text: "Publicités personnalisées"),
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
                            ExploreaTitle(text: "Autorisations matérielles")),
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
                            Text("Géolocalisation",
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
