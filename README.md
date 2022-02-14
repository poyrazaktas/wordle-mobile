# Wordle Mobile

It is a Flutter implementation of the game Wordle. Since I want to play it without waiting the next day, I made an offline version of it.
Every attempt would be checked with the "assets/words.json" file. Since **sqflite** package doesn't support [concurrent read and write transaction](https://pub.dev/packages/sqflite#current-issues). I didn't use **sqflite** package, instead of this, I coded my file service as [FileHelper](https://github.com/poyrazaktas/wordle-mobile/blob/main/lib/helpers/file_helper.dart). I also added features like switching between dark and light mode, and color blind mode.

The way I manage attempts is a little dirty so I am open to any suggestions and pull requests for this.







https://user-images.githubusercontent.com/56718583/153901890-9c49d9bb-c759-4f90-a55a-0e359513e366.mp4

