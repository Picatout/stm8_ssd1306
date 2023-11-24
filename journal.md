### 2023-11-24

* renommé certaines variables 
    * cur_x  renommé   col 
    * cur_y  renommé   line 
    * start_page renommé scroll_line 

* complété démo [app.asm](asm.asm). Démonstration lecture sonde de températeur avec affichage en Celcius et Fahranheit.

### 2023-11-23

* Transformé app.asm en démo pour sonde de température.

* Corrigé bogue dans *set_page*.

* Réorganisation du code et nettoyage.

* Création du fichier [inc/ssd1306.inc](inc/ssd1306.inc).

### 2023-11-22

* Création de la branche *text_only* pour tester un nouveau modèle suportant en priorité le texte plutôt que les graphiques.
    * le ssd1306 est configuré en mode PAGE 

* Mode texte complété.


* -------------------

* Nouveau projet dérivé de stm8_chipcon pour me concentrer sur l'utilisation des OLED basé sur le contrôleur SSD1306 128x64 pixels.

* Suppression des fichiers concernant spécifiquement CHIPCON.

* Modification de Makefile 

* Renommé et modifié chipcon.asm en oled128x64.asm

### 2023/11/21

* Reprise du projet avec rotation de la police 6x8 pixels.

* Modifié put_char pour utiliser la police oled_font_6x8. 

### 2023/11/19

* Projet suspendu à cause de la lenteur de l'affichage.

### 2023/11/18

* Travail sur jeu LEM. 

### 2023/11/17

* travail sur jeu LEM.

* test code VM TONE, corrigé bogue dans routine *tone* 


* programme de test pixi ajouté et tester.

* Modification à la VM. et à la routine main.

### 2023/11/13

* Ajout du cocd PIXI à la VM. 

* Ajout du programme LEM 

### 2023/11/12

* Complété et testé le système de menu.

### 2023/11/11

* Travail sur le système de menu

### 2023/11/10

* Création *menu*

* Modification de put_string pour scroller l'écran vers le haut lorsque le curseur texte arrive ne bas de l'affichage.

* Ajout de l'opcode SCU  à la VM 

* Retravaillé  les scrolling vertical en mettant en commun la bouche principale. *down_n_lines* et *up_n_lines* partagent *vertical_shift*.

### 2023/11/09

* Ajout du moniteur  [monitor.asm](monitor.asm).

* Continuer test sur machine virtuelle.


### 2023/11/08

* Débuter test de la machine virtuelle SCHIP.

* travail sur ship.cam 

### 2023/11/07

* travail sur schip.asm complété. 

### 2023/11/06

* travail sur schip.asm 

### 2023/11/05

* travail sur schip.asm 

### 2023/11/04

* travail sur schip.asm 

### 2023/11/03

* Déplacé code de test dans [test.asm](test.asm).

### 2023/11/02 

* Ajout des routines de décalage de l'affichage dans [display.asm](display.asm):
    * *down_n_pixels* décale vers le bas de **n** pixels.
    * *left4pixels* décale vers la gauche de 4 pixels.
    * *right4pixels* décale vers la droite de 4 pixels.

* Corrigé bogue dans routine *put_string* qui imprimait 15 charactères par ligne au lieu de 16.

* Utilisation du TIMER2 pour la génération des tonalité. Ajout de la routine *tone*.

* Création de [schip.asm](schip.asm)

* Remplacement du stm8s103f3 qui n'a pas suffisamment de mémoire RAM par carte NUCLEO_8S207K8 

### 2023/11/01

* Ajout de la routine *scroll* dans [oled_128_64.asm](oled_128_64.asm).

* Ajout de *put_char*  et *put_string* dans [display.asm](display.asm).

### 2023/10/31

* Ajout de fonctions graphiques dans display.asm 

* Ajout de [display.asm](display.asm)

* Modifié I2cIntHandler pour gérer i2c_count > 255

### 2023/10/30

* résolue problème avec l'envoie des commandes à l'affichage OLED. l'octet de continuation doit-être envoyé avant chaque octet et non seulement au début du message.
