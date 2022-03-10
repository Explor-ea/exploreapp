import 'package:exploreapp/wigets/explorea-line.dart';
import 'package:exploreapp/wigets/explorea-title-secondary.dart';
import 'package:exploreapp/wigets/explorea_fab.dart';
import 'package:flutter/material.dart';

import '../../explorea_colors.dart';

class Cgv extends StatelessWidget {
  const Cgv({Key? key}) : super(key: key);

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
                ExploreaTitleSecondary(text: "de Vente")
              ],
            ),
            Container(
              height: 50,
            ),
            Expanded(
                child: SingleChildScrollView(
              // TODO: integrate real CFV text
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

  TARIFS ET MODALITES FINANCIERES
Le téléchargement de l'Application est gratuit.
L'Application téléchargée gratuitement permet d'accéder à tous les Scénarios proposés, et l'Utilisateur devra réaliser le paiement (s'il y a lieu) pour pouvoir jouer.  
    Paiements et conditions de vente
Le Service payant est accessible vingt-quatre heures sur vingt-quatre, sept jours sur sept, dans la limite des conditions d'utilisation susvisées. 
L'offre tarifaire d' Explor'ea est dépendante du type de scénario, et exige un paiement en une fois : 
Scénario long : 15 euros 
Scénario court : 8 euros 
Scénario de démo : Gratuit 
 
Les tarifs indiqués ci-dessus sont susceptibles d'évoluer sur l'Appliation, c'est alors le tarif affiché sur l'Application qui est celui à prendre en compte, les tarifs ci-dessus n'étant mentionnés qu'à titre indicatif. 
Les tarifs sont indiqués sur l'Application en Euros et toutes taxes comprises.  
La validation du paiement par le Membre équivaut à l'acceptation du Contrat qui le lie à Explor'ea.  
Pour Android, le paiement est traité et géré par la société Stripe, leader mondial du paiement en ligne, qui gère de manière cryptée la communication avec les banques. 
Pour iOS, le paiement est traité et géré par la société Apple Inc directement via le compte iTunes du Membre. 
Explor'ea n'a aucun contrôle sur le paiement, sur le transfert de fonds ou encore sur le changement de devises et les frais inhérents à ces opérations. Explor'ea n'a aucun accès et ne collecte aucune donnée de paiement.
L'intégralité des opérations de paiements sont gérées par la société Stripe ou par Apple qui sont par conséquent seuls responsables de l'intégralité des opérations de paiements.
Pour plus d'informations sur la gestion par la société Stripe des opérations de paiements, les Utilisateurs de Match Activity peuvent se rendre sur ce lien : https://stripe.com/fr/privacy
A défaut d'éléments contraires apportés par le Membre abonné, les registres informatisés. conservés dans les systèmes informatiques de Explor'ea dans des conditions raisonnables de sécurité, seront considérés comme les preuves des communications, des commandes, des validations et des paiements intervenus entre le Membre et Explor'ea. Ces informations feront foi sauf à en apporter la preuve écrite et contraire par le Membre. L'archivage de ces éléments est effectué sur un support fiable et. durable de manière à correspondre à une copie fidèle et durable conformément à l'article 1348 du code civil
Le contrat dure à minima durant toute la période d'installation de l'Application et les périodes de jeu sélectionnés par le Membre.   
Explor'ea se réserve le droit de suspendre l'accès d'un Membre au Service Payant, sans préavis ni indemnité, notamment en cas de:
non-respect par le Membre des présentes conditions générales d'utilisation et de vente:
fourniture de fausses informations lors de son inscription
agissements contraires aux intérêts commerciaux ou moraux de Explor'ea 
Concernant le droit de rétractation, conformément aux dispositions de l'article L. 121-20-21° du Code de la Consommation le Membre qui achète un Scénario payant reconnaît et accepte expressément que la fourniture du Service Payant commence dès la validation de son paiement soit avant la fin du délai de 14 jours francs prévu par le Code de la Consommation et reconnaît et accepte en conséquence de ne pas bénéficier du droit de rétractation lié à la vente en ligne ou à distance. En conséquence, aucune demande de rétractation, d'annulation ou de remboursement ne sera recevable pour la période souscrite.
Le Membre souhaitant bénéficier d'un Scénario Payant, déclare avoir la capacité d'accepter les présentes conditions générales d'utilisation et de vente, c'est à dire avoir la majorité légale et ne pas faire l'objet d'une mesure de protection juridique des majeurs (mise sous sauvegarde de justice, sous tutelle ou sous curatelle) ou, si ce dernier est mineur, être titulaire d'une autorisation parentale lui permettant de souscrire.
Le Membre souhaitant bénéficier d'un Service déclare être résident sur le territoire français et disposer d'une carte bancaire émise en France par un établissement bancaire français ou une carte internationale valable..

  DUREE 
Dans le cas du téléchargement de l'Application gratuite, les présentes Conditions Générales sont souscrites pour une durée indéterminée à compter de leur acceptation par l'Utilisateur.

  RESILIATION 
L'accès à l'Application et au Service pourrait être interrompu temporairement ou définitivement, notamment en cas de cessation par Explor'ea de l'activité en cause, ou en cas de liquidation judiciaire ou amiable de la société Explor'ea. Les présentes Conditions Générales seraient alors résiliées de plein droit. 
En cas de décès de l'Utilisateur, les relations contractuelles entre celui-ci et Explor'ea seront résiliées de plein droit et son Compte personnel sera désactivé, sur production des pièces justificatives pertinentes des ayants droit. Son contenu ne pourra être transmis aux ayants droit que sur décision de justice. 
En cas de violation des présentes Conditions Générales par l'Utilisateur, ou des lois et règlements en vigueur, notamment, mais pas exclusivement, en cas de manquement par un Utilisateur à l'une ou plusieurs des règles précitées à l'Article 7. ou en cas de comportement compromettant ou risquant de compromettre le bon fonctionnement du Service ou de porter atteinte aux droits des tiers ou à la réputation du Service, Explor'ea se réserve le droit de suspendre et/ou de résilier unilatéralement l'exécution des présentes, et de bloquer et/ou supprimer le Compte personnel de l'Utilisateur concerné, ainsi que son accès à tout ou partie du Service, de supprimer les Contenus litigieux. de façon temporaire ou définitive, sans que cela ouvre droit pour l'Utilisateur à une quelconque indemnité, et sans préjudice de toute action en justice que Explor'ea pourrait intenter par la suite pour faire valoir ses droits.

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
