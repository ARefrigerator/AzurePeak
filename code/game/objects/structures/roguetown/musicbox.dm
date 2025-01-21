#define MUSIC_TAVCAT_OTHERWORLDLY list(\
	"Lore" = 'sound/music/jukeboxes/otherworld/ac-ler.ogg',\
	"Landmarks of Lullabies" = 'sound/music/jukeboxes/otherworld/ac-lol.ogg',\
	"Waters of Sacrifice" = 'sound/music/jukeboxes/otherworld/acn-wos.ogg',\
	"Solar Wind" = 'sound/music/jukeboxes/otherworld/av_solar.ogg',\
	"Balthasar" = 'sound/music/jukeboxes/otherworld/ac-balthasar.ogg',\
	"Dead Windmills" = 'sound/music/jukeboxes/otherworld/dead_windmills.ogg',\
	"In Heaven Everythin" = 'sound/music/jukeboxes/otherworld/in_heaven_eif.ogg',\
	"Jazznocn" = 'sound/music/jukeboxes/otherworld/jazznocn.ogg',\
	"Vivalaluna-Damla" = 'sound/music/jukeboxes/otherworld/vivalaluna-damla.ogg',\
	"Shades of Futility" = 'sound/music/jukeboxes/otherworld/fb-sofutile.ogg',\
	"Mr Doubt" = 'sound/music/jukeboxes/otherworld/mr_doubt.ogg'\
)
#define MUSIC_TAVCAT_GENERIC list(\
	"Song 1" = 'sound/music/jukeboxes/gen/tavern1.ogg',\
	"Song 2" = 'sound/music/jukeboxes/gen/tavern2.ogg',\
	"Song 3" = 'sound/music/jukeboxes/gen/tavern3.ogg'\
)

/datum/looping_sound/musloop
	mid_sounds = list()
	mid_length = 18000 // This is 30 minutes - just in case something wierd happens.
	volume = 50
	extra_range = 6
	falloff = 0
	persistent_loop = TRUE
	var/stress2give = /datum/stressevent/music
	channel = CHANNEL_JUKEBOX

/datum/looping_sound/musloop/on_hear_sound(mob/M)
	. = ..()
	if(stress2give)
		if(isliving(M))
			var/mob/living/carbon/L = M
			L.add_stress(stress2give)

/obj/structure/roguemachine/musicbox
	name = "wax music device"
	desc = "A marvelous device invented to record sermons. Aleksandar Gemrald Sparks invented this machine to discover prophecies of Psydon's return but failed. It now brings us strange music from another realm."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "music0"
	density = TRUE
	anchored = TRUE
	max_integrity = 0
	var/datum/looping_sound/musloop/soundloop
	var/list/init_curfile = list('sound/music/jukeboxes/gen/tavern1.ogg') // A list of songs that curfile is set to on init. MUST BE IN ONE OF THE MUSIC_TAVCAT_'s.
	var/curfile // The current track that is playing right now
	var/playing = FALSE // If music is playing or not. playmusic() deals with this don't mess with it.
	var/curvol = 50 // The current volume at which audio is played. MAPPERS MAY TOUCH THIS.
	var/playuponspawn = FALSE // Does the music box start playing music when it first spawns in? MAPPERS MAY TOUCH THIS.

/obj/structure/roguemachine/musicbox/Initialize()
	. = ..()
	curfile = pick(init_curfile)
	soundloop = new(src, FALSE)
	if(playuponspawn)
		playmusic("START")
		update_icon()

/obj/structure/roguemachine/musicbox/Destroy()
	. = ..()
	del(soundloop)

/obj/structure/roguemachine/musicbox/update_icon()
	icon_state = "music[playing]"

/obj/structure/roguemachine/musicbox/proc/playmusic(mode="TOGGLE") // "TOGGLE" | "START" | "STOP"
	playsound(loc, 'sound/misc/Bug.ogg', 100, FALSE, -1)
	if(mode=="TOGGLE")
		if(!playing)
			if(curfile)
				playing = TRUE
				soundloop.mid_sounds = list(curfile)
				soundloop.cursound = null
				soundloop.volume = curvol
				soundloop.start()
		else
			playing = FALSE
			soundloop.stop()
	if(mode=="START")
		if(!playing)
			if(curfile)
				playing = TRUE
				soundloop.mid_sounds = list(curfile)
				soundloop.cursound = null
				soundloop.volume = curvol
				soundloop.start()
	if(mode=="STOP")
		playing = FALSE
		soundloop.stop()

/obj/structure/roguemachine/musicbox/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return

	user.changeNext_move(CLICK_CD_MELEE)

	var/button_selection = input(user, "What button do I press?", "\The [src]") as null | anything in list("Stop/Start","Change Song","Change Volume")
	if(!Adjacent(user))
		return
	if(!button_selection)
		to_chat(user, span_info("I change my mind..."))
		return
	user.visible_message(span_info("[user] presses a button on \the [src]."),span_info("I press a button on \the [src]."))
	playsound(loc, pick('sound/misc/keyboard_select (1).ogg','sound/misc/keyboard_select (2).ogg','sound/misc/keyboard_select (3).ogg','sound/misc/keyboard_select (4).ogg'), 100, FALSE, -1)

	if(button_selection=="Stop/Start")
		playmusic("TOGGLE")
	
	if(button_selection=="Change Song")
		var/songlists_selection = input(user, "Which song list?", "\The [src]") as null | anything in list("OTHERWORLDLY"=MUSIC_TAVCAT_OTHERWORLDLY, "GENERIC"=MUSIC_TAVCAT_GENERIC)
		playsound(loc, pick('sound/misc/keyboard_select (1).ogg','sound/misc/keyboard_select (2).ogg','sound/misc/keyboard_select (3).ogg','sound/misc/keyboard_select (4).ogg'), 100, FALSE, -1)
		user.visible_message(span_info("[user] presses a button on \the [src]."),span_info("I press a button on \the [src]."))
		var/chosen_songlists_selection = null
		if(songlists_selection=="OTHERWORLDLY")
			chosen_songlists_selection = MUSIC_TAVCAT_OTHERWORLDLY
		if(songlists_selection=="GENERIC")
			chosen_songlists_selection = MUSIC_TAVCAT_GENERIC
		var/song_selection = input(user, "Which song do I play?", "\The [src]") as null | anything in chosen_songlists_selection
		if(!Adjacent(user))
			return
		if(!song_selection)
			to_chat(user, span_info("I change my mind..."))
			return
		playsound(loc, pick('sound/misc/keyboard_select (1).ogg','sound/misc/keyboard_select (2).ogg','sound/misc/keyboard_select (3).ogg','sound/misc/keyboard_select (4).ogg'), 100, FALSE, -1)
		user.visible_message(span_info("[user] presses a button on \the [src]."),span_info("I press a button on \the [src]."))
		curfile = chosen_songlists_selection[song_selection]
		playmusic("STOP")
		playmusic("START")

	if(button_selection=="Change Volume")
		var/volume_selection = input(user, "How loud do you wish me to be?", "\The [src] (Volume Currently : [curvol]/[100])") as num|null
		if(!Adjacent(user))
			return
		if(!volume_selection)
			to_chat(user, span_info("I change my mind..."))
			return
		if(volume_selection == curvol)
			to_chat(user, span_info("The dial is already set to that volume!"))
			return
		playsound(loc, pick('sound/misc/keyboard_select (1).ogg','sound/misc/keyboard_select (2).ogg','sound/misc/keyboard_select (3).ogg','sound/misc/keyboard_select (4).ogg'), 100, FALSE, -1)
		user.visible_message(span_info("[user] presses a button on \the [src]."),span_info("I press a button on \the [src]."))
		volume_selection = clamp(volume_selection, 0, 100)
		if(curvol<volume_selection)
			to_chat(user, span_info("I make \the [src] get louder."))
		else
			to_chat(user, span_info("I make \the [src] get quieter."))
		curvol = volume_selection
		playsound(loc, 'sound/misc/Bug.ogg', 100, FALSE, -1)
		playmusic("STOP")
		playmusic("START")

	update_icon()

/obj/structure/roguemachine/musicbox/tavern
	init_curfile = list(\
		'sound/music/jukeboxes/gen/tavern1.ogg',\
		'sound/music/jukeboxes/gen/tavern2.ogg',\
		'sound/music/jukeboxes/gen/tavern3.ogg',\
		'sound/music/jukeboxes/otherworld/ac-lol.ogg',
		'sound/music/jukeboxes/otherworld/ac-balthasar.ogg',\
		'sound/music/jukeboxes/otherworld/vivalaluna-damla.ogg',\
	)
	curvol = 65
	playuponspawn = TRUE
	
/obj/structure/roguemachine/musicbox/Initialize()
	. = ..()
	soundloop.extra_range = 12
	soundloop.falloff = 6
