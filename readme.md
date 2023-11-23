# 128x64 pixel SSD1306 display driver

Code écrit en assembleur sdasstm8 pour piloter un affichage OLED de 128x64 pixels avec interface I2C. Ces petits affichage sont communément disponibles à petit petit prix. 

Ce projet ne supporte que le mode texte  permettant d'afficher  8 lignes de 21 caractères. Le défilement du texte vers le haut se fait automatiquement lorsque le texte arrive à la fin de l'affichage.

Voir [display.ams](display.asm) pour l'interface de programmation application. 


----------------

sdasstm8 assembly code to drive I2C OLED  using SSD1306 controller for 128x64 pixels. 

This driver only support text as 8 lines of 21 characters. The display auto scroll when text hit the display bottom.

See [display.ams](display.asm) for API.

