import 'package:exploreapp/wigets/explorea-line.dart';
import 'package:exploreapp/wigets/explorea-title-secondary.dart';
import 'package:exploreapp/wigets/explorea_fab.dart';
import 'package:flutter/material.dart';

import '../../explorea_colors.dart';

class Cgu extends StatelessWidget {
  const Cgu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ExploreaFab(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.all(8.0),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExploreaTitleSecondary(text: "Conditions"),
                Row(
                  children: [
                    ExploreaLine(
                      width: 40.0,
                      color: ExploreaColors.yellow,
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                    ),
                    ExploreaTitleSecondary(text: "Générales")
                  ],
                ),
                ExploreaTitleSecondary(text: "d'Utilisation")
              ],
            ),
            Container(
              height: 50,
            ),
            Expanded(
                child: SingleChildScrollView(
              // TODO: integrate real CGU text
              child: Text(
                """
Si vous utilisez de quelque manière que ce soit l'Application Mobile Explor'ea, vous vous engagez à respecter les termes des présentes Conditions Générales qui constituent un contrat entre la société Explor'ea et vous-même.
 
  INTRODUCTION
La société Explor'ea. société par actions simplifiée au capital de xxx euros, inscrite au Registre de la Greffe du Tribunal de commerce de Rennes sous le numéro RC n° 000000000/ nº identifiant fiscal FR00000000000. dont dont le siège social est situé au Rue Pierre de Maupertuis 35170 Bruz. exploite l'Application Mobile Explor'ea » ci-après dénommée << l'Application » ou «<le Service »,
 
La Directrice de la publication est Madame Gloria CHESNEL. L'adresse électronique du contact est: contact.explorea@gmail.com.
L'Hébergeur de l'Application est xxx, dont le siège se situe xxx. 
La Plateforme est réservée à un public dont l'âge minimum est de 18 ans ou émancipé. Si des personnes ayant moins de 18 ans, non émancipées, s'inscrivent à la Plateforme, Explor'ea considère que ces personnes ont accepté avec leurs représentants légaux ces CGU, et ce sans réserve. La Société Explor'ean'a pas pour obligation et ne dispose pas des moyens pour vérifier l'identité ou l'âge des personnes s'inscrivant à ses Services. 
En cas de non-acceptation des CGU stipulées dans le présent contrat, l'Utilisateur se doit de renoncer à l'accès des Services proposés par l'Application.

  DÉFINITIONS
Aux fins des présentes Conditions Générales, les termes définis ci-après auront la signification suivante (les termes débutant par une majuscule au sein du Contrat, qu'ils soient utilisés au singulier ou au pluriel, auront la signification qui leur est donnée ci-aprės):
Application :  désigne l'Application Mobile développée par la société Explor'ea afin de proposer des Scénarios de jeu dans le but de découvrir des lieux autrement. 
Mon Compte : désigne le compte de l'Utilisateur sur l'Application auquel ce dernier est connecté une fois qu'il a accepté les Conditions Générales d'Utilisation et qu'il a renseigné certaines informations d'identification. 
Conditions Générales: désigne les présentes Conditions Générales d'Utilisation de l'Application 
Information ou Contenu : désigne toute information ou donnée que les Utilisateurs ou Explor'ea transmettent sur l'Application, y compris toute information ou donnée générée par l'Application à la suite de son utilisation par les Utilisateurs et de leur accès à celle-ci. 
Informations confidentielles : désignent les informations que l'une ou l'autre des Parties souhaite protéger contre toute divulgation ou utilisation non autorisée et qui sont désignées comme étant confidentielles, par écrit, au moment de la divulgation ou immédiatement après la divulgation orale, ou qui, au regard du contexte, doivent être considérées comme confidentielles. 
Inscription :  désigne le processus de connexion au Compte personnel de l'Utilisateur sur l'Application consistant dans l'acceptation des Conditions Générales d'utilisation et la communication d'informations d'identification.  
Propriété intellectuelle  : désigne collectivement toutes marques de commerce. tous dessins. logos, accroches publicitaires, slogans, modèles, marques, noms. noms commerciaux, graphiques. icônes ou autres signes distinctifs, liens hypertextes, concepts, idées. améliorations, brevets, droits d'auteur, Informations confidentielles, savoir-faire (y compris tous les documents, diagrammes, informations, dispositifs, données techniques et scientifiques et autres procédés et méthodes, ainsi que toutes les informations disponibles concernant la commercialisation et la promotion des Services décrits ci-après, ainsi que toutes les modifications ou améliorations qui y sont apportées), les secrets commerciaux et tout autre type de droits de propriété intellectuelle (enregistrés ou non, brevetables ou non) et droits. similaires de toute nature en vertu des lois de toute autorité gouvernementale, y compris. notamment, toutes les demandes et tous les enregistrements liés à ce qui précède, qu'une Partie possède, prend sous licence, utilise et/ou détient (actuellement ou non) sur l'Application Explor'ea ou en rapport avec cette-dernière.  
Service :  désigne les Services proposés par l'Application tels que décrits aux présentes Conditions Générales. 
Utilisateur :  désigne toute personne physique qui utilise l'Application selon les termes des présentes Conditions Générales.
Scénario : désigne le ou les scénarios de jeu proposés dans l'Application Explor'ea, à l'achat ou gratuits. 

  OBJET ET CHAMP D'APPLICATION DES CONDITIONS GÉNÉRALES D'UTILISATION 
Les présentes Conditions Générales régissent les rapports entre Explor'ea et les Utilisateurs de l'Application et s'appliquent sans restriction ni réserve pour toute utilisation ou téléchargement de l'Application.
L'Utilisateur est tenu d'accepter les présentes Conditions Générales pour tout téléchargement et pour toute utilisation de l'Application en cochant la case « J'accepte les Conditions Générales d'Utilisation ».
Explor'ea pourra modifier les présentes Conditions Générales à tout moment, sans préavis et sans avoir à le communiquer préalablement aux Utilisateurs, dès lors que cela lui semble opportun. Les Utilisateurs seront informés de la modification des présentes par le biais de la publication des Conditions Générales actualisées. Les Conditions Générales modifiées prendront effet à partir de leur publication. La poursuite de l'utilisation du Service à la suite de cette publication constitue une acceptation de la nouvelle version des présentes Conditions Générales. 
Il est conseillé aux Utilisateurs de lire très attentivement les présentes Conditions Générales et de consulter régulièrement les Conditions Générales mises à jour.
Dans le cas où un Utilisateur n'accepterait pas les présentes Conditions Générales ou refuserait de s'y conformer, il ne doit pas utiliser l'Application. Dans ce cas, il est recommandé de désinstaller l'Application. En procédant à son Inscription, l'Utilisateur confirme avoir pris connaissance des présentes Conditions Générales et accepte de s'y soumettre sans réserve. 
Sauf preuve contraire, les données enregistrées dans le système informatique de l'Application constituent la preuve de l'ensemble des transactions conclues avec les Utilisateurs.
 
  PRESENTATION GENERALE DU SERVICE 
    Objet du Service
Le Service est une application mobile proposant des Scénarios de jeu, de type exploration game, escape game outdoor, qui permet à l'Utilisateur de découvrir des lieux à travers un jeu.  
    Fonctionnement du Service
L'Application Explor'ea peut être téléchargée via les boutiques d'applications mobiles (AppStore et Google Play Store) sur un terminal mobile de type smartphone. 
Pour bénéficier du Service, l'Utilisateur doit donc disposer d'un smartphone, d'un accès internet et d'un Compte personnel d'Utilisateur (voir Article 5). 
Les fonctionnalités de l'Application sont les suivantes:
 
L'Utilisateur renseigne les informations nécessaires pour la création d'un Compte personnel d'Utilisateur conformément à l'article 5.
L'Utilisateur peut chercher les scénarios disponibles autour de lui ou dans une zone de recherche sur la map. 
L'Utilisateur peut choisir un Scénario et consulter sa fiche descriptive 
L'Utilisateur peut choisir de jouer à un Scénario, si celui-ci est payant, il devra d'abord procéder au paiement.
L'utilisateur joue le Scénario  
 
  CRÉATION D'UN COMPTE PERSONNEL D'UTILISATEUR 
Pour accéder au Service, tout Utilisateur doit préalablement procéder à son Inscription en créant un Compte personnel d'Utilisateur. 
Afin de créer un Compte personnel d'Utilisateur, l'Utilisateur doit s'inscrire en remplissant les Informations demandées au démarrage de l'Application. Les informations que l'Utilisateur doit renseigner sont les suivantes: Email, Mot de passe, Date de naissance.
 
En cas d'oubli de mot de passe, il suffit de cliquer sur « mot de passe oublié » et l'Application envoie à l'adresse e-mail de l'Utilisateur un lien permettant de le redéfinir. Le renseignement de ces données et la validation du Compte personnel sont indispensables à la fourniture du Service.
L'Utilisateur s'engage à fournir des informations vraies, sincères, complètes et toujours à jour.
Dans le cas où les informations transmises par l'Utilisateur se révéleraient fausses. incomplètes, obsolètes ou ne permettant pas la fourniture du Service dans les meilleures conditions, Explor'ea se réserve le droit de procéder à la fermeture du Compte personnel de l'Utilisateur et ainsi de lui refuser l'accès au Service, sans préavis et sans que cela ne lui ouvre un quelconque droit à indemnité.
L'Utilisateur s'engage à ne créer qu'un seul Compte personnel correspondant à son identité.
L'Utilisateur reste seul responsable de tout usage qui pourrait être fait de ses identifiants et mot de passe, et de leur confidentialité, ainsi que de toute utilisation de son Compte personnel. L'Utilisateur s'engage à informer immédiatement Explor'ea de toute utilisation ou risque d'utilisation frauduleuse de son Compte personnel, et de toute atteinte à la confidentialité et à la sécurité de ses identifiants et mot de passe à l'adresse électronique de contact suivante : contact.explorea@gmail.com. 
Explor'ea ne pourra en aucun cas être tenue responsable de toute perte ou vol ou tout dommage resultant de la perte ou du vol ou d'une utilisation frauduleuse des données d'identifications des Utilisateurs.

  OBLIGATIONS DE L'UTILISATEUR
Le Service a pour finalité de proposer des activités ludiques, immersives, au travers de Scénarios de jeu à jouer dans des villes. Toute utilisation du Service contraire à cette finalité sera contraire aux présentes Conditions Générales.
L'Utilisateur reconnaît disposer de la compétence et des moyens techniques nécessaires pour télécharger et utiliser l'Application, le matériel utilisé restant exclusivement à sa charge. L'Utilisateur s'engage à communiquer des informations exactes lors de son inscription permettant l'accès au Service conformément à l'Article 5 des présentes Conditions Générales. 
L'Utilisateur est notamment informé du fait que l'utilisation du Service peut nécessiter l'acceptation de la géolocalisation lorsqu'il souhaite prendre connaissance des options de sorties autour de lui. 
L'Utilisateur s'engage à faire une utilisation adéquate et licite du Service et de ses contenus. conformément à la législation en vigueur, les présentes Conditions Générales, la morale, les bonnes mœeurs et l'ordre public. 
Les Utilisateurs qui utilisent le Service pour des finalités interdites par la loi et/ou contraires aux présentes Conditions Générales s'exposent à des poursuites judiciaires et les données permettant leur identification pourront être fournies aux autorités compétentes en cas de procédure judiciaire engagée contre eux.
l'Utilisateur est entièrement responsable de l'utilisation faite du Service, ainsi que des décisions qu'il pourrait prendre après avoir consulté les informations contenues dans l'Application. Explor'ea ne peut être tenue pour responsable de tout dommage direct ou indirect, de quelque nature que ce soit, causé par une mauvaise utilisation, par l'utilisation illégale ou illicite du Service par un Utilisateur, par toute information ou tout autre contenu communiqué, transmis ou diffusé par un Utilisateur à l'occasion de l'utilisation du Service, ou par tout manquement. quelconque d'un Utilisateur aux présentes Conditions Générales.

Il est interdit pour l'Utilisateur de télécharger, envoyer, diffuser, transmettre tout Contenu violant tout brevet. marque déposée, secret de fabrication, droit d'auteur, droit de propriété intellectuelle ou tout autre droit de propriété appartenant à autrui: 
 
  OBLIGATIONS DE EXPLOR'EA
Explor'ea s'engage à fournir un Service conforme aux présentes Conditions Générales.
Explor'ea se réserve le droit de modifier toute Information ou tout Contenu figurant dans l'Application, à tout moment et sans préavis, dans le cadre de sa mise à jour ou de la correction d'erreurs ou d'inexactitudes ou si cela lui semble opportun sans que cela ouvre droit à une quelconque réparation pour les Utilisateurs.. 
En cas de violation des présentes Conditions Générales ou des lois et règlements en vigueur. notamment en cas de manquement par un Utilisateur à l'une ou plusieurs des règles précitées à l'Article 7, ou dont le comportement pourrait compromettre ou risquer de compromettre le bon fonctionnement du Service ou porter atteinte aux droits des tiers ou à la réputation du Service. Explor'eay se réserve le droit de suspendre et/ou de résilier unilatéralement l'exécution des présentes dans les conditions visées à l'Article 11 des présentes, et de bloquer et/ou supprimer le Compte personnel de l'Utilisateur concerné ainsi que son accès à tout ou partie du Service, de supprimer les contenus litigieux, de façon temporaire ou définitive, sans que cela ouvre droit pour l'Utilisateur à une quelconque indemnité.

  LIMITATION DE RESPONSABILITÉ 
A tout moment. Explor'ea pourra modifier, interrompre temporairement ou définitivement l'accès au Service, et ce, sans avoir à en informer les Utilisateurs au préalable, Explor'ea ne prenant aucun engagement de maintenir un accès permanent et ininterrompu à l'Application et/ou au Service. Explor'ea n'est en aucun cas responsable de ces interruptions et des conséquences qui peuvent en découler pour l'Utilisateur.
Explor'ea ne sera pas responsable du fonctionnement inadéquat du Service s'il résulte d'opérations de maintenance, d'incidents, ou de problèmes liés à sa capacité à supporter les systèmes indispensables à l'utilisation du Service, même si Explor'ea fera ses meilleurs efforts pour assurer une réponse rapide, sans se responsabiliser pour les retards liés aux services de télécommunications. Explor'ea ne sera en aucun cas responsable du mauvais fonctionnement des opérateurs téléphoniques et des fournisseurs d'accès Internet auxquels I'Utilisateur aura eu recours, ni des plateformes de moyens de paiement que l'Utilisateur emploierait pour effectuer les paiements.
L'Utilisateur reste seul responsable de tout usage qui pourrait être fait de ses identifiants et mot de passe, et de leur confidentialité, ainsi que de toute utilisation de son Compte personnel Explor'ea ne pourra en aucun cas être tenue responsable de toute perte ou vol ou tout dommage résultant d'une utilisation frauduleuse des données d'identification des Utilisateurs. 
En tant que prestataire technique, Explor'ea n'est pas tenue de vérifier la véracité des informations fournies par les Utilisateurs et décline toute responsabilité quant à l'inexactitude des données, Informations et Contenus diffusés par les Utilisateurs via l'Application, ou des erreurs ou omissions qu'ils pourraient comporter ainsi que tout dommage consécutif à l'utilisation de tout Contenu fournit par un Utilisateur.
Explor'ea ne pourra en aucun cas être tenue responsable de toute conséquence qui pourrait survenir à l'occasion de rencontres ou prises de contact entre plusieurs Utilisateurs, à la suite de l'utilisation de l'Application.
Explor'ea n'est pas non plus responsable de la mauvaise configuration du terminal mobile de l'Utilisateur. Il appartient à chaque Utilisateur de s'assurer du bon fonctionnement et de la configuration de son matériel
 
 DUREE 
Dans le cas du téléchargement de l'Application gratuite, les présentes Conditions Générales sont souscrites pour une durée indéterminée à compter de leur acceptation par l'Utilisateur.

  RESILIATION 
L'accès à l'Application et au Service pourrait être interrompu temporairement ou définitivement, notamment en cas de cessation par Explor'ea de l'activité en cause, ou en cas de liquidation judiciaire ou amiable de la société Explor'ea. Les présentes Conditions Générales seraient alors résiliées de plein droit. 
En cas de décès de l'Utilisateur, les relations contractuelles entre celui-ci et Explor'ea seront résiliées de plein droit et son Compte personnel sera désactivé, sur production des pièces justificatives pertinentes des ayants droit. Son contenu ne pourra être transmis aux ayants droit que sur décision de justice. 
En cas de violation des présentes Conditions Générales par l'Utilisateur, ou des lois et règlements en vigueur, notamment, mais pas exclusivement, en cas de manquement par un Utilisateur à l'une ou plusieurs des règles précitées à l'Article 7. ou en cas de comportement compromettant ou risquant de compromettre le bon fonctionnement du Service ou de porter atteinte aux droits des tiers ou à la réputation du Service, Explor'ea se réserve le droit de suspendre et/ou de résilier unilatéralement l'exécution des présentes, et de bloquer et/ou supprimer le Compte personnel de l'Utilisateur concerné, ainsi que son accès à tout ou partie du Service, de supprimer les Contenus litigieux. de façon temporaire ou définitive, sans que cela ouvre droit pour l'Utilisateur à une quelconque indemnité, et sans préjudice de toute action en justice que Explor'ea pourrait intenter par la suite pour faire valoir ses droits.
 
  PROPRIÉTÉ INTELLECTUELLE
12.1 Titres de Propriété intellectuelle de Explor'ea
L'ensemble du Contenu de l'Application, les photographies, logos, images, sons, vidéo, textes, ou illustrations ainsi que sa structure, les bases de données, logiciels, codes ainsi que tout autre matériel et élément visuel composant l'Application est protégé, notamment par le droit de la Propriété intellectuelle dont Explor'ea reste le seul titulaire.
Les présentes Conditions Générales n'emportent aucune cession d'aucune sorte de droits de la Propriété intellectuelle sur les éléments appartenant à Explor'ea au bénéfice de l'Utilisateur. 
Les Utilisateurs s'engagent à citer les droits de Propriété intellectuelle attachés aux éléments composants L'Application et s'interdisent, notamment de les diffuser, publier. transmettre, céder à tout tiers, de les exploiter à des fins commerciales, de les reproduire, de les copier ou de les modifier sans l'autorisation expresse et préalable de Explor'ea. Toute extraction ou réutilisation des données contenues dans l'Application, au-delà de son usage normal est strictement interdite à tout Utilisateur et est soumise à l'autorisation expresse et préalable de Explor'ea. 
12.2 Droit d'usage de l'Application par l'Utilisateur
L'Utilisateur ne dispose que d'un droit d'usage strictement personnel, non exclusif et non transférable de l'Application. Tout autre usage est soumis à l'autorisation préalable et expresse de Explor'ea.
Toute reproduction, représentation ou diffusion, y compris l'addition à celle-ci de nouvelles fonctions ou la réalisation de modifications sur celle-ci qui altéreront son fonctionnement, par quelque moyen que ce soit et sur quelque support que ce soit, est formellement interdite, à la seule exception du droit de reproduire pour stockage aux fins de représentation pour copie de sauvegarde ou impression sur support papier en un exemplaire, sous condition du respect de l'intégrité des documents.
Le droit d'utilisation de l'Application accordé en vertu des présentes Conditions Générales pourra être résilié à tout moment par l'Utilisateur la désinstallation l'Application et l'élimination de l'ensemble des copies de l'Application sur ses appareils ou par la résiliation des présentes selon les termes de l'article 11 des présentes.

  LÉGISLATION APPLICABLE-LANGUE
Les présentes Conditions de service sont rédigées en langue française.
En cas de traduction dans une ou plusieurs langues étrangères, seul le texte français fera foi. 
Les présentes Conditions Générales, leur application, leur exécution, leur mise en oeuvre, leur interprétation, leur résiliation, ainsi que tous les procès et toutes les procédures spéciales qui pourraient résulter de leur violation seront soumis à la loi et la réglementation française en vigueur, à l'exclusion de toute autre législation, quelle que soit la nationalité de l'Utilisateur.
 
  ATTRIBUTION DE COMPETENCE
 
En cas de différend entre les Parties concernant la conclusion, l'interprétation, l'exécution et/ ou la résiliation de ces Conditions Générales. et avant toute action en justice devant les tribunaux compétents, les Parties s'efforceront de rechercher toutes les solutions amiables pour le règlement du litige dans un délai de quinze (15) jours, 
En application du Règlement n' 524/2013 relatif au règlement en ligne des litiges de consommation, le Client est informé que tout litige issu des présentes conditions générales pourra être porté devant la plateforme de règlement en ligne des litiges accessibles via le lien suivant: http://ec.europa.eu/consumers/odr/ à partir du 15 février 2016.
De convention expresse, à défaut d'accord amiable entre les Parties, les juridictions du ressort du siège social de la société Explor'ea seront seules compétentes pour tout litige ou contestation se rapportant notamment, mais pas exclusivement à la formation, l'interprétation, à l'exécution, ou à l'inexécution, à la résiliation des présentes, nonobstant pluralité de défendeurs ou appel en garantie, même pour les procédures conservatoires, en référé ou par requête.
 
  ANNULATION ET INEFFICACITÉ DES CLAUSES
La nullité ou l'impossibilité de mise en œuvre de l'une des quelconque clauses des présentes Conditions Générales, si elle ne remet pas en cause notablement l'équilibre contractuel, n'affectera que la clause concernée et n'entraînera pas l'annulation des présentes Conditions Générales.
""",
                style: TextStyle(color: ExploreaColors.purple),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
