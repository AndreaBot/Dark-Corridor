# Dark-Corridor
![180](https://github.com/AndreaBot/Dark-Corridor/assets/128467098/f1eca37f-1708-43f3-9e3c-de28cff0e985)

Dark Corridor is a retro-looking 2D game where the player navigates a corridor looting various items and fighting enemies.
This is an app that still to this day I am absolutely proud of, countless hours have gone into this project and I am very pleased with the end result.
Not knowing about SpreiteKit back in the day, this app has been built with static images.

At the start of the game, the player is able to pick a Hero of his/her choice and give it a custom name. The red and blue heroes are available for free while the green and dark ones need to be purchased from the store using in-game currency.

![RedHeroFront](https://github.com/AndreaBot/Dark-Corridor/assets/128467098/b270d47c-1a58-42ce-ad47-987d9242b4f2) ![BlueHeroFront](https://github.com/AndreaBot/Dark-Corridor/assets/128467098/91eeffe6-61b2-4dac-8be8-dde0df36ee7f)  ![GreenHeroFront](https://github.com/AndreaBot/Dark-Corridor/assets/128467098/5978af72-a0e5-4307-af93-19e9ab47d3ae)  ![DarkHeroFront](https://github.com/AndreaBot/Dark-Corridor/assets/128467098/23461f5a-fbf2-482f-a3ee-44063809c852)

<img width="220" alt="Screenshot 2024-06-05 at 20 26 30" src="https://github.com/AndreaBot/Dark-Corridor/assets/128467098/28d952b8-2fc4-41f2-b1c8-3ff0d3c2931d"> <img width="220" alt="Screenshot 2024-06-05 at 20 26 49" src="https://github.com/AndreaBot/Dark-Corridor/assets/128467098/7b68bc58-7c5c-4762-8639-ec4083b7dc0a">

Rooms in the corridor have a random chance to either be empty, contain an item or spawn an enemy.

Discoverable loots includes:

- Diamonds (worth 10 points)
- Gold (worth 3 points)
- Dirt (worth 1 point)
- Potions (restores 15HP)
- Power Ups (increases attack power by 3 points)

![Diamond](https://github.com/AndreaBot/Dark-Corridor/assets/128467098/7976eb2d-316e-4c87-80bd-fea8260927aa) ![Gold](https://github.com/AndreaBot/Dark-Corridor/assets/128467098/3c60454d-b4eb-4530-b5ad-f26572778e83) ![Dirt](https://github.com/AndreaBot/Dark-Corridor/assets/128467098/898a00f7-d191-4f76-b8c0-4982247be87a) ![Potion](https://github.com/AndreaBot/Dark-Corridor/assets/128467098/b3ef953e-3da1-4adc-9ca1-96e154b6466d) ![PowerUp](https://github.com/AndreaBot/Dark-Corridor/assets/128467098/2c448741-b099-466b-8fe5-815b0ad8078d)

Each collected item is saved in an inventory page displaying the quantity for each as well giving the player a chance to drink a potion to restore some health.

<img width="220" alt="Screenshot 2024-06-05 at 20 35 51" src="https://github.com/AndreaBot/Dark-Corridor/assets/128467098/8ef2f1d6-3f70-453b-8ac8-35c6318c90f7">

The Dark Corridor is also filled with enemies! The player can encounter:

- Mutant Pig
- Possessed Spellbook
- Horned Bat
- Death's Emissary
- Creepy Lady

![PigBig](https://github.com/AndreaBot/Dark-Corridor/assets/128467098/362b7236-3084-402b-923a-ef2c658434c2) ![SpellbookBig](https://github.com/AndreaBot/Dark-Corridor/assets/128467098/16e5d333-605f-41dc-aa74-3f4b0758eb04) ![HornedBat](https://github.com/AndreaBot/Dark-Corridor/assets/128467098/434c0979-dc83-4364-b26e-8874e07563b0) ![Death's Emissary](https://github.com/AndreaBot/Dark-Corridor/assets/128467098/30886e5f-4c5e-4d1f-9fd9-92b96e4b8c68) ![Creepy Lady](https://github.com/AndreaBot/Dark-Corridor/assets/128467098/6f5cf14e-3110-4e3c-9cfa-2b15a200d53c)

Each enemy has its own sound effects, spawn animations, attacks and stats.

The battles are handled in a similar way as in the Pokemon games: they are turned based, attacks have a chance to miss and there are plenty of sound effects, text animations and on-screen messages to complete the experience.

<img width="220" alt="Screenshot 2024-06-05 at 20 34 31" src="https://github.com/AndreaBot/Dark-Corridor/assets/128467098/e47063de-22b4-4425-a8a8-19d39d26dcd1">

Defeating enemies rewards the player with soul items: the more powerful enemies (the Possessed Spellbook and Creepy Lady) release 2 souls, the other ones just 1. Each soul is worth 5 points.

The game includes two end-game screens:

- if the player dies in battle all resources are lost and zero points are awarded,
- if the player leaves the corridor alive, he gets a certain amount of points based on the loot he/she managed to gather. These points can be used in the store to unlock more characters and buy power-ups.

<img width="220" alt="Screenshot 2024-06-05 at 20 36 13" src="https://github.com/AndreaBot/Dark-Corridor/assets/128467098/3ace65d8-83b3-4b9e-b1f4-f638d1ace44a">

The player is free to leave the corridor at any point (not during a battle) but the more rooms he/she enters the more points can be collected.

The game's main screen also includes a store and a stats screen.

<img width="220" alt="Screenshot 2024-06-05 at 20 36 40" src="https://github.com/AndreaBot/Dark-Corridor/assets/128467098/12f1d47f-aa47-427a-abbb-1958c549bb7d"> <img width="220" alt="Screenshot 2024-06-05 at 20 37 03" src="https://github.com/AndreaBot/Dark-Corridor/assets/128467098/a02f40c3-6a17-4871-9ed7-40b8555bcd25">

In the store the player can spend collected points to purchase new playable characters, buy potions, power ups and a special item to come back to life in case of death in battle.

The stats screen displays:

- Current amount of points
- Highest score ever
- Number of successful escapes and deaths
- Overall quantity that has ever been found for each loot item
- Number of times each enemy has been defeated.



Credits:
- Sprites and tiles: SciGho (www.itch.io)
- Main menu music: 8 bit Eskes (https://www.youtube.com/@8biteskes630)
- Main game music: z3r0 (https://www.youtube.com/@z3r0CopyrightFreeMusic)
- Battle music: Epic Music Journey (https://www.youtube.com/@epicmusicjourney4688)
- Battle win music: AdamHaynes (https://www.youtube.com/@AdamHaynesMusic)
- End game music: David Renda (https://www.fesliyanstudios.com/royalty-free-music/download/8-bit-surf/568)
- All other sound effects have been downloaded from www.samplefocus.com
