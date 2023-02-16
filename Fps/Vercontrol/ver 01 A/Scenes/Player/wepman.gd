extends Spatial


# Declare member variables here. Examples:

enum WEPSLOTS {Unarmed,Pistol,Shotgun}

var unlocked = {
	WEPSLOTS.Unarmed: true,
	WEPSLOTS.Pistol: true,
	WEPSLOTS.Shotgun: true,
	}

onready var Sweps = $Sweps.get_children()
var cur_slot = 0
var cur_swep = null

func switch_up():
	cur_slot = (cur_slot + 1) % unlocked.size()
	if !unlocked[cur_slot]:
		switch_up()
	else:
		switch_slot(cur_slot)

func switch_down():
	cur_slot = posmod((cur_slot - 1), unlocked.size())
	if !unlocked[cur_slot]:
		switch_down()
	else:
		switch_slot(cur_slot)

func switch_slot(slot_ind: int):
	if slot_ind < 0 or slot_ind >= unlocked.size():
		return
	if !unlocked[cur_slot]:
		return
	kill_sweps()
	cur_swep = Sweps[slot_ind]
	if cur_swep.has_method("set_active"):
		cur_swep.set_active
	else:
		cur_swep.show()

func kill_sweps():
	for weapon in Sweps:
		if weapon.has_method("set_inactive"):
			weapon.set_inactive()
		else:
			weapon.hide()
