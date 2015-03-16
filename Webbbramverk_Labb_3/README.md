#Installation

Let's start with the api folder!

1. Download the file and unzip it.
2. Open the project (RubyMine recommended)
3. Write "bundle install" to install all the gems
4. Then write "rake db:migrate" to install the database.
5. Then write "rake db:seed" to create an admin.
6. To start the server write "rails s"

NOTE: If your using nitrous then you'll have to change the origins url in the config.ru file on line 8.

Now let's continue with the angular part of the project!

1. Download the file and unzip it.
2. Open the project (Webstorm recommended).
3. Open the index.html file in the app folder.
4. Now open the file by pressing one of the browser-buttons in the upper-right corner.(They apper by hovering the mouse)

NOTE: If you have changed the url in the api project then you'll have to change the url in updateController, mainController, loginController, detailController and createEventController. 

If you have any questions don't hesitate to contact me.

Usernames: Hades, Kalle, Olle.
Password: password.
All the users have the same password.

## Förändringar i apiet

* För att användaren ska slippa fråga efter olika resurser och sedan loopa ut vilken resurs som tillhör vilken så får nu användaren ut alla resurser tillhörande ett event när man gör en get på event.

* Apiet kontrollerar nu så att bara samma användare kan ta bort eller uppdatera sin egna resurs.

* Ett event har nu fått en titel.

* När man skapar ett event så skapas även nu en position.

## Beskrivning

Syftet med applikationen är att användare ska kunna gå in och kolla upp vad för aktiviteter som finns på olika platser i världen. En inloggad användare kan skapa, uppdatera och ta bort ett event. En användare som inte är inloggad kan fortfarande titta runt på olika aktiviteter.
