// Eleven unique mercenary type; should be scary in a way solo but easy to kill with a group or bow.
/datum/advclass/mercenary/blackoak
	name = "Black Oak's Guardian"
	tutorial = "A shady guardian of the Black Oaks. Half mercenary band, half irregular militia fighting for control of their ancestral elven homeland of the Peaks. Thankfully, you are not here today to shed the blood of the Duke's men- unless someone pays you to.."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		/datum/species/human/halfelf,
		/datum/species/elf/wood,
	)
	outfit = /datum/outfit/job/roguetown/mercenary/blackoak
	category_tags = list(CTAG_MERCENARY)

/datum/outfit/job/roguetown/mercenary/blackoak/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/elven_boots
	cloak = /obj/item/clothing/cloak/forrestercloak
	head = /obj/item/clothing/head/roguetown/helmet/heavy/elven_helm
	gloves = /obj/item/clothing/gloves/roguetown/elven_gloves
	belt = /obj/item/storage/belt/rogue/leather/black
	armor = /obj/item/clothing/suit/roguetown/armor/plate/elven_plate
	backl = /obj/item/storage/backpack/rogue/satchel
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	pants = /obj/item/clothing/under/roguetown/trou/leather
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	var/classes = list("Melee (Polearms)", "Ranged (Bows)")
	var/classchoice = input("Choose your archetype", "Available archetypes") as anything in classes
	switch(classchoice)
		if("Melee (Polearms)")
			if(H.mind)
				H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
				H.change_stat("endurance", 2)
				H.change_stat("constitution", 1)
				H.change_stat("strength", 3)

				beltl = /obj/item/rogueweapon/huntingknife/idagger/steel/special
				r_hand = /obj/item/rogueweapon/halberd/glaive
				backr = /obj/item/gwstrap
				backpack_contents = list(/obj/item/roguekey/mercenary, /obj/item/storage/belt/rogue/pouch/coins/poor)
		if("Ranged (Bows)")
			if(H.mind)
				H.mind.adjust_skillrank(/datum/skill/combat/bows, 5, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/knives, 5, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
				H.change_stat("perception", 3)
				H.change_stat("speed", 3)

				beltr = /obj/item/rogueweapon/huntingknife/idagger/steel/parrying
				beltl = /obj/item/quiver/arrows
				backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/longbow
				backpack_contents = list(/obj/item/roguekey/mercenary, /obj/item/storage/belt/rogue/pouch/coins/poor, /obj/item/rogueweapon/huntingknife/idagger/steel)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_AZURENATIVE, TRAIT_GENERIC)
