# 128x64 pixel SSD1306 display driver

Code écrit en assembleur sdasstm8 pour piloter un affichage OLED de 128x64 pixels avec interface I2C. Ces petits affichages sont communément disponibles à petit prix. 

Ce projet ne supporte que le mode texte  permettant d'afficher  8 lignes de 21 caractères. Le défilement du texte vers le haut se fait automatiquement lorsque le texte arrive à la fin de l'affichage.

Voir [display.asm](display.asm) pour l'interface de programmation application. 

## fonctions d'interface du module **display**. 

    * **put_char** Affiche la caractère à la postion courante du curseur. Passe le caractère dans **A**
    * **put_string** Affiche une chaîne de caractères à la position courante du curseur. Passe l'adresse de la chaîne dans **Y**.
    * **set_line** Déplace le curseur texte au début de la ligne indiquée en paramètre dans **A**.
    * **crlf** Déplace le curseur texte au début de la ligne suivant et génère un défilement vers le haut automatique si requis.
    * **display_clear** Efface l'affichage et déplace le curseur en haut à gauche.
    * **put_byte** Affiche un entier octet en hexadécimal à la position courante du curseur. L'octet est passé dans **A''  
    * **put_hex_int** Affiche un entier en hexadécimal à la position courante du curseur. L'entier est  passé dans **X**.

## fichiers 

    * [i2c.asm](i2c.asm)  pilote pour le périphéique  I2C  utilise une interruption.
    * [oled_128_64.asm](oled_128_64.asm)  Code pour initialiser l'affichage OLED 128x64 pixels 
    * [display.asm](display.asm) Gestion de l'affichage texte de 8 lignes, 21 caractères par ligne.
    * [hardware_init](hardware_init.asm) initialisation matérielle.
    * [font.asm](font.asm) police de caractères ASCII 6x8 pixels.
    * [oled-font.asm](oled-font.asm) police de caractères ASCII 6x8 pixels adapté (rotation 90 degrés) à cet afficahge OLED.    
    * [tools/rotate-font.c](tools/rotate-font.c) code source du programme utilisé pour convertir [font.asm](font.asm) en [oled-font.asm](oled-font.asm).
    * [app.asm](app.asm) Application démo. Affiche la température ambiante en Celcius et Fahrahneit.

----------------

sdasstm8 assembly code to drive I2C OLED  using SSD1306 controller for 128x64 pixels display. 

This driver only support text as 8 lines of 21 characters. The display auto scroll when text hit the display bottom.


See [display.asm](display.asm) for text diplay API.

## files 

    * [i2c.asm](i2c.asm)  I2C peripheral driver, it use I2C interrupt.
    * [oled_128_64.asm](oled_128_64.asm)  128x64 OLED display initialisation and support functions. 
    * [display.asm](display.asm) Functions to display text 8 lines of 21 characters.
    * [hardware_init](hardware_init.asm) hardware initialisation.
    * [font.asm](font.asm) 6x8 pixels ASCII font.
    * [oled-font.asm](oled-font.asm) 6x8 ASCII font adapted for this specific OLED display. The font is rotated 90 degrees left.    
    * [tools/rotate-font.c](tools/rotate-font.c) source code of tool surd to rotate font [font.asm](font.asm) to [oled-font.asm](oled-font.asm).
    * [app.asm](app.asm) Demo application. Display room temperature in Celcius and Fahrahneit.


