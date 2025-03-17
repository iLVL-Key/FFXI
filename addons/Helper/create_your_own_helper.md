# The Helper File
## File Name, Type, and Location
The file name should be the name of your Helper. Upper or lower case does not matter, but do remove any special characters. If the name has a space in it, either use an underscore instead or remove the space entirely. This name will only be used by the user when loading/setting the Helper directly (`//helper load your_helper_name`) so it should be simple enough for them to remember and type.  
This is an XML file, ending in `.xml`, that should be placed inside the `/addons/Helper/data/helpers` folder.

## Contents
Inside this file, of course, is where the Helper addon will look to pull text from when a notification/alert goes off. If it does not exist in this file, it simply will not play the notification/alert.  

The best way to start to create your own Helper file, is to make a copy of the `Vana.xml` file in the `/addons/Helper/data/helpers` folder and change the name to your Helpers name (see **File Name, Type, and Location**, above).  

Once you have created this copy and changed the name, open the file in your preferred Text File Editor. Notepad will work, but I personally prefer [Visual Studio Code](https://code.visualstudio.com/), and [Notepad++](https://notepad-plus-plus.org/) is another good choice.  

You can simply go down line by line and change the text to whatever you like, they should be pretty self-explanitory on what they are for. Do note that a few of them will have placeholders, such as `${member}`, and it would be best to keep those included somewhere in your new text. It will work just fine if you decide to remove it, but using it will give the user additional context for that text.  

Another thing to note is that the numbers for the `name_color` and `text_color` relate to a specific chat channel in-game. If you have the Battlemod addon loaded, you can type `//bm colortest` and it will spit out a lot of colored numbers into your chatlog for reference. I have noticed that some of the numbers and their colors don't seem to match up when used in other addons, though I'm not sure where that issue lies. In addition, since these are technically chat channels that are being "borrowed" to color the text in the users chat log, you will run across some number/colors that may move the Helpers text into a different window if the user has the chatlog split into two windows. This is a result of fixing an issue where if the text is too long, and spills over into a second line in the users chatlog, it will lose its coloring and revert to the initial color set by add_to_chat. To fix that, I made the initial chat channel/color be the same as the text color, but then that introduced the issue where some colors will be in different windows.  

For the Flavor Text, you'll notice that each line is numbered. The total number does not matter, you can have 1 total, or you can have 200. All you will need to do is keep the numbers unique and in order.

Once you finish your changes and save that file, you can then load it in-game with `//helper load your_helper_name`.  

Now that we've gotten the basics for your new Helper done, you could stop there and it will work just fine, but let's add some pizazz!



# Faceplates
The Faceplate system looks for two files: `faceplate_small.png` and `faceplate_large.png`. If either aren't there when they are called, it simply won't display the Faceplate. This means if you only supply a "large" one, and the user has Faceplates set to small, it will not display when a notification/alert goes off, but will if the user switches to large.  
The large Faceplate should be `180px x 180px` and the small should be `100px x 100px`. This is not a hard requirement, but a best practice to stay consistent.  

![faceplate_large](https://github.com/user-attachments/assets/2cbf259d-d163-4d70-9a5b-8667efe0be02)  
Large Faceplate example  

![faceplate_small](https://github.com/user-attachments/assets/6f6ff1a7-7aad-42c1-af85-a93f913bbeb0)  
Small Faceplate example



# Custom Sounds
The Custom Sound system is fairly flexible, so there are varying ways you can decide to make sounds clips. Some sounds have been grouped, and the Generic sound will played if one of the Specifics is not present. This means if you do all of the Specifics in a group, you do not need to do the Generic. Conversely, you can also only do the Generic and it will be used in place of the Specifics for that group.
- A sound file for each, doing the Specific and not the Generics (31 total).
- A sound file for each, but only the Generics for the groups (23 total).
- A sound file for the Generics, and a single sound file for the rest (5 total).
- A singe sound file (notification.wav) that gets used for everything.

The addon uses a hierarchy to decide which sound to play when a notification/alert happens. Note that if you do not supply any sound files for your Helper, it will still use the default sounds.  

("player" here means the addon user, "member" is anyone not the player.)
## Notification
* **notification.wav** - Played for anything that doesn't have a specific sound. This also means you can have nothing but this and it will be used for everything.

## Ability Ready
* **ability_ready.wav** - Any ability (with a cooldown of 10min or longer) is now ready to use.

## Capped Job Points
* **capped_job_points.wav** - The players job points are now capped.

## Capped Merit Points
* **capped_merit_points.wav** - The players merit points are now capped.

## Food Wears Off
* **food_wears_off.wav** - The players food has just worn off.

## Mireu Has Popped
* **mireu_popped.wav** - Mireu has just popped.

## Mog Locker Nearing Expiration
* **mog_locker_expiring.wav** - The players Mog Locker is nearing expiration. Plays one week before the expiration date, then once per day until expired or renewed.

## A Party Member Has Low MP
* **party_low_mp.wav** - A player in the players party has low MP. Plays only if the player is on RDM or BRD. Text will adjust to refresh/ballad based on players job if `${refresh}` is used, but this sound file will be played for either job.

## Mystical Canteen Reminder
* **reminder_canteen.wav** - A new Mystical Canteen is ready.

## Moglophone Reminder
* **reminder_moglophone.wav** - A new Moglophone is ready.

## Shiny Ra'Kaznarian Plate Reminder
* **reminder_plate.wav** - A new Shiny Ra'Kaznarian Plate is ready.

## Reraise Check
* **reraise_check.wav** - The player does not have Reraise on.

## Reraise Wears Off
* **reraise_wears_off.wav** - The player has lost Reraise.

## Regional Buff Wears Off
* **signet_wears_off.wav** - The player has lost a Regional Buff (Signet, Sigil, Sanction, or Ionis).

## Sparkolade Reminder
* **sparkolade_reminder.wav** - A reminder to use your Sparkolades. Plays once per week.

## Sublimation Charged
* **sublimation_charged.wav** - Sublimation has finished charging.

## Vorseal Is About To Wear Off
* **vorseal_wearing.wav** - The players Vorseal will wear off in 10 minutes.

## Leader
* **now_alliance_leader.wav** - The player is now the alliance leader.
* **now_party_leader.wav** - The player is now the party leader.

## Member Joined 
### Member Joined *Generic*
* **member_joined_party.wav** - Used if the below "Member Joined Specific" files are not present. Played for any instance of a member (including the player) joining a party/alliance. If the 4 files below are all present, this file will not be used at all.
### Member Joined *Specific*
If any (or all) of these are missing, it will play the above member_joined_party.wav in their place.
* **you_joined_party.wav** - The player joins a party.
* **you_joined_alliance.wav** - The player joins a pre-established alliance.
* **member_joined_party.wav** - A member joins your party.
* **member_joined_alliance.wav** - A member joins your alliance.

## Member Left
### Member Left *Generic*
* **member_left_party.wav** - Used if the below "Member Left Specific" files are not present. Played for any instance of a member (including the player) leaving a party/alliance. If the 4 files below are all present, this file will not be used at all.
### Member Left *Specific*
If any (or all) of these are missing, it will play the above member_left_party.wav in their place.
* **you_left_party.wav** - The player left their party.
* **you_left_alliance.wav** - The player left their party that was in an alliance.
* **member_left_party.wav** - A member left your party.
* **member_left_alliance.wav** - A member left a different party that was in your alliance.

## Party Joined
### Party Joined *Generic*
* **party_joined_alliance.wav** - Used if the below "Party Joined Specific" files are not present. Played when the players party joins an alliance, or when a different party joins the players pre-established alliance. If the 2 files below are both present, this file will not be used at all.
### Party Joined *Specific*
* **your_party_joined_alliance.wav** - The players party has joined an alliance.
* **other_party_joined_alliance.wav** - A different party has joined the players pre-established alliance.

## Party Left
### Party Left *Generic*
* **party_left_alliance.wav** - Used if the below "Party Left Specific" files are not present. Played when the players party left an alliance, or when a different party left the players alliance. If the 2 files below are both present, this file will not be used at all.
### Party Left *Specific*
* **your_party_left_alliance.wav** - The players party has left an alliance.
* **other_party_joined_alliance.wav** - A different party has left the players alliance.
