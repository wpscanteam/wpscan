#Colissimo WooCommerce Changelog

## 1.1

### Fonctionnalités

- Prise en charge de étiquettes au format ZPL et DPL : 
  - Possibilité de générer les étiquettes de livraison au format ZPL ou DPL
  - Possibilité d'imprimer les étiquettes de livraison au format ZPL ou DPL directement sur une imprimante thermique via USB ou Ethernet.

- Impression en masse des étiquettes de livraisons de plusieurs commandes depuis le listing des commandes Colissimo

- Il est désormais possible de trier les commandes du listing Colissimo selon :
  - Le nom du client
  - L'adresse de livraison
  - Le pays de livraison
  - La méthode de livraison
  - Le statut de la livraison
  - Le numéro de bordereau

- Il est désormais possible de filtrer les commandes du listing Colissimo selon :
  - Le pays de livraison
  - La méthode de livraison
  - Le statut de livraison
  - Les étiquettes générées ("Aller", "Retour", "Aller et Retour" et "Étiquette non générée")

- Le nombre de commandes affichées par page sur le listing Colissimo est paramétrable via l'option de WordPress "Options de l'écran"

### Améliorations

- Ajout de la référence de la commande sur l'étiquette de livraison

- Les prix des méthodes de livraisons se basent désormais sur le prix TTC

- Lors de l'impression d'une étiquette de livraison, la facture n'est plus présente 

### Correctifs

- Résolution d'un problème qui pouvait se poser au moment de la sauvegarde des prix des méthodes de livraison, s'il y avait la présence de nombres décimaux

- Résolution d'un problème qui faisait que le prix de la commande pris en compte pour le calcul du prix de la méthode de livraison n'incluait pas les réductions liées à des coupons 

- Résolution d'un problème qui pouvait rendre l'ouverture de la pop-up de choix du point relais impossible pour le client

- Résolution de la prise en charge du multisite

- Résolution d'un problème qui pouvait rendre le lien de suivi non-fonctionnel

- Résolution d'un problème qui pouvait empêcher la sélection d'un point relais si un autre avait été choisi précedemment

- Résolution d'un problème qui pouvait empêcher la génération du formulaire CN23