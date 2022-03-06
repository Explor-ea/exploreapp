# exploreapp

## Todo list 

- [x] Créer un profil utilisateur dans Firestore

## Schéma de données

```json
{
    "user": [{
        "birthdate": null,

        "playedScenario": [
          {
            "idScenario": null,
            "playerName": "Nom utilisé pour la partie par le(s) joueur(s), pas unique car scénario horodaté.",

            /* Pour la sauvegarde :  */
            "currentTime": null,
            // "lastPlayedDate": null, // to find last played adventure with that id.
            "lastStep": null,

            /* Pour les stats : */
            "endDate": null,
            "endTime": null, /* seconds */
          }
        ],

        "allowedScenario": [null, null],

        /* Pour les succès mais on en aura pas pour la démo : */
        "success": [
          {
            "id" : null, 
            "idScenario" : null,
            "name": "",
            "description": "Une description courte et marrante."
          }  
        ]
    }],

    "scenario": [{
        "id": null,
        "name": "",
        "duration": "",
        "PRM": false,
        "description": "",
        "difficulty": "",
        "ageLimit": null,
        "address": null, /* Données géo. */
    }]
}   
``` 

## Build et distribution

Avant chaque nouveau déploiement, penser à modifier la version de l'application dans le `pubspec.yaml`.

### Build Android

`flutter build apk`

### Build iOS

La commande `flutter build ipa` could be run on an iOS device, or with the online service : [codemagic.io](https://codemagic.io/apps).
But the iOS app must be signed, by creating an Apple Developer account (100€