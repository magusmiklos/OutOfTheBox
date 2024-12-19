extends Node

# E => Nothing
# X => Chaos Block
# P => Player
# S => Solid not movable
# F => finish door where the player should go
# K => the player have to pick up this key to be able to open the door the F
# I => ice

var map = null

const map1 = [
	"SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS",
	"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEKEES",
	"SEEEEEEEEPEEEEEEEEEEEEEEEEEEEEEEEEEEEESSSSSSS",
	"SSSSSSSSSSSSEEEEEEEEEEEEEEEEEEEEEEEEEESEEEEES",
	"SEEEEEEEEEESEEEEEEEEEEEEEEEEEEEEEEEEEESEEEEES",
	"SEEEEEEEEEESXEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEFS",
	"SEEEEEEEEEESEXEEEEEEEEEEEEEEEEEEEEEEEESSSSSSS",
	"SEEEEEEEEEESXEEEEEEEEEEEEEEEEEEEEEEEEESEEEEES",
	"SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS",
]

const map2 = [
	"SSSSSSSSSSSSSSSSSS",
	"SEEEEEEEEXEXEEEEES",
	"SEEEEEEEEEXEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SPEEEEEEEEEEEEEEES",
	"SIIIIIIIIIIIIIIIIS",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEES",
	"SEEEEEEEFEEEEEEEES",
	"SSSSSSSSSSSSSSSSSS",
]

const map3 = [
		"SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS",
		"SEEXEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
		"SEXXEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
		"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
		"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
		"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
		"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
		"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
		"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
		"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
		"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
		"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
		"SEEEEEEEEEEEEEEEEEPEEEEEEEEEEEEES",
		"SSSSSSSSSSSSSIIISSSSSSSSSSSSSSSSS",
		"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
		"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
		"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
		"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
		"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEES",
		"SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEXFS",
		"SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS",
]

const map4 = [
	"SSSSSSSSSS",
	"SEEEEEEIES",
	"SEEEEEEIES",
	"SEEEEEEIES",
	"SEEEEEEIES",
	"SPEEEEEIFS",
	"SSSSSSSSSS",
]

const map5 = [
	"SSSSSSSSSSS",
	"SEFESEXEIES",
	"SEEESEEEIES",
	"SEEESEEEIES",
	"SEEESEEEIES",
	"SEPESEEEIES",
	"SEIESSSSISS",
	"SSIIIIIIISS",
	"SSSSSSSSSSS",
]

const map6 = [
	"SSSSSSSSSS",
	"SEEEEEEEES",
	"SEEEEEEEKS",
	"SSSEEESSSS",
	"SEEEEEEEES",
	"SEEEEEEEES",
	"SEEEEEEEES",
	"SEEEEEEEES",
	"SEPEEEEEFS",
	"SSSXXXSSSS",
	"SEEEEEEEES",
	"SEEEEEEEES",
	"SEEEEEEEES",
	"SEEEEEEEES",
	"SEEEEEEEES",
	"SEEEEEEEES",
	"SEEEEEEEES",
	"SEEEEEEEES",
	"SEEEEEEEKS",
	"SSSEEESSSS",
	"SSSSSSSSSS",
]

const map7 = [
	"SSSSSSSSSSSSSSSSSSSSSS",
	"SEEEEEEEEEEEEEEEEEEEES",
	"SEXEEEEEEEEEEEEEEEEEES",
	"SEPEEEEEEEEEEEEEEEEEFS",
	"SSSSSSSSEEEEESSSSSSSSS",
	"SSSSSSSSSSSSSSSSSSSSSS",
]

const map8 = [
	"SSSSSSSSSSSSSSSSSSSSSS",
	"SEXEEEEEEESEEEESEEEEES",
	"SXXEEEEEEESEEEESEEEEES",
	"SEEEEEEEEESEEEESEEEEES",
	"SEEEEEEEEESPEEEEEEEEFS",
	"SEEEEEEEEESSSEEESSSSSS",
	"SEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEES",
	"SSSSSSSSSSSSSSSSSSSSSS",
]

const map9 = [
	"SSSSSSSSSSSSSSSSSSSSSS",
	"SEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEKS",
	"SEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEEEEEEES",
	"SEEEEEEEEEEEEEEESEXEES",
	"SEEEEEEEEEEEEEEESEEEES",
	"SEXEEEEEEEEEEEEESSSSSS",
	"SEPEEEEEEEEEEEEEEEEEFS",
	"SSSSSSSSSSSSSSSSSSSSSS",
]

var current_map = null
const maps = [map1,map2,map3,map4,map5,map6,map7,map8,map9]
const key_map = [1,0,0,0,0,2,0,0,1]

var keys = 0

var from = [
	[
		"EEE",
		"EEE",
		"EEE"
	],
	[
		"EEE",
		"EEE",
		"EEE"
	],
	[
		"EEE",
		"EEE",
		"EEE"
	],
]

var to = [
	[
		"EEE",
		"EEE",
		"EEE"
	],
	[
		"EEE",
		"EEE",
		"EEE"
	],
	[
		"EEE",
		"EEE",
		"EEE"
	],
]

var menu = false
var start = false


var is_chaos_selected = true

func reset_rules():
	to = [
	[
		"EEE",
		"EEE",
		"EEE"
	],
	[
		"EEE",
		"EEE",
		"EEE"
	],
	[
		"EEE",
		"EEE",
		"EEE"
	],
]

	from = [
	[
		"EEE",
		"EEE",
		"EEE"
	],
	[
		"EEE",
		"EEE",
		"EEE"
	],
	[
		"EEE",
		"EEE",
		"EEE"
	],
	
]

	start = false
	is_chaos_selected = true
	
