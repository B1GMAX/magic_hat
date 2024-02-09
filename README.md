The project uses the following API - https://hp-api.onrender.com/, to fetch all the necessary
information.
The app consists of 3 screens: Home Screen, List Screen, and Details Screen. The Main Screen is a
wrapper screen with a page view containing 2 screens and a navigator bar.
The Home screen displays randomly selected characters (photo and full character name).
You can load another character using the "pull to refresh" gesture on the main screen.
For each selection, the total/success/failure count is listed and displayed in fields at the top of
the main screen and the list screen.
The "Reset" button resets all previously guessed characters and sets all total values to zero.
The List screen displays previously guessed guessed (successful and unsuccessful) and the number of
attempts for each character (until successful guessing).
Clicking a character's row on the list screen will open the details screen. Information about the
character is displayed only if the character has been guessed correctly.