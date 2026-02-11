/// @description Setup credits

var L = LF("Credits")
var _ntmobile_localizers;
var _basegame_localizers;

#region Load Nuclear Throne localizers
var _path = working_directory + "lang/credits.txt"
try {
	_basegame_localizers = file_read(_path)
}
catch(e) {
	if (GM_build_type == "run") {
		throw e
	}
	print(e.longMessage)
	_basegame_localizers = ""
}

if (_basegame_localizers != "") {
	var _list = string_split("\n" + _basegame_localizers, "\n", false),
		_count = array_length(_list)
	
	for(var i = 1; i < _count; ++i) {
		var _current = _list[i]
		if (_current != "") {
			if (_list[i - 1] == "" || _current == "LQA") {
				_list[i] = "@w" + _current
			}
			else {
				_list[i] = "@s" + _current
			}
		}
	}
	
	_basegame_localizers = string_join_ext("\n", _list)
}

#endregion
#region Gather Nuclear Throne Mobile localizer names

var _ctx = { result: "" }

/// @loc:note [Meta] List of usernames of translators, separated by commas.
/// @loc:note [Meta] You may include yourself if your contribution is of significant importance to the translation!
/// @loc:token [Meta] Localizers ""
with (_ctx) {
	struct_foreach(global.language_store, function(_language_id, _struct) {
		if (variable_struct_exists(_struct, "Meta:Localizers")) {
			var _string = string_trim(_struct[$ "Meta:Localizers"])
			if (!string_length(_string)) exit
			
			var _names = string_split(_string, ",", true)
			if (!array_length(_names)) exit
			
			result += "@w" + _language_id
				+ "\n@s" + string_join_ext("\n@s", _names) + "\n\n"
		}
	})
}

_ntmobile_localizers = string_insert_wordwraps(_ctx.result, gui_w + 60, fa_center)

// for some reason using `string_trim` on `_ntmobile_localizers`
// causes the last non-whitespace character to cut off? weird
_ntmobile_localizers = string_copy(_ntmobile_localizers,
	1, string_last_pos("\n\n", _ntmobile_localizers) - 1)

#endregion

credittext = [
	[
		L("Presents", "@yVLAMBEER @wPRESENTS"),
	],
	[
		L("GameBy", "@wA GAME BY"),
	],
	[
		"@w" + L("Lead", "Project Lead, Design & Development"),
		"@sJan Willem Nijman",
	],
	[
		"@w" + L("Production", "Production & Additional Development"),
		"@sRami Ismail",
	],
	[
		"@w" + L("Art", "Art Direction, Lead Artist & Animation"),
		"@sPaul Veer",
	],
	[
		"@w" + L("Music", "Original Soundtrack"),
		"@sJukio Kallio",
	],
	[
		"@w" + L("Sound", "Sound Design"),
		"@sJoonas Turner",
	],
	[
		"@w" + L("Art2", "Additional Artwork"),
		"@sJustin Chan",
	],
	[
		"@w" + L("Music2", "Additional Music Credits"),
		"",
		"@w" + L("Music2:Oasis", "Oasis"),
		"@sJUKIO KALLIO#Danny Baranowski",
		"",
		"@w" + L("Music2:PizzaSewers", "Pizza Sewers"),
		"@sJUKIO KALLIO#Eirik Suhrke",
		"",
		"@w" + L("Music2:Venus", "Venus"),
		"@sJUKIO KALLIO#Adam 'Doseone' Drucker",
		"",
		"@w" + L("Music2:CursedCaves", "Cursed Caves"),
		"@sJUKIO KALLIO#Richard 'Disasterpeace' Vreeland",
		"",
		"@w" + L("Music2:Jungle", "Jungle"),
		"@sJUKIO KALLIO#Daniel Hagstrom",
		"",
		"@w" + L("Music2:MansionHC", "Mansion & Hyper Crystal"),
		"@sJUKIO KALLIO#Joonas Turner",
	],
	[
		"@w" + L("Music2:TeaBreak", "Tea Break"),
		loc_fmt("Music2:TeaBreak:1", "Original Composition by %", "Eirik Suhrke@w"),
		"",
		"@w" + L("Music2:Consult", "Additional Music Consultation"),
		"@sJoonas Turner@w"
	],
	[
		"@w" + L("Voice:Main", "The voice of Fish, Crystal, Eyes,#Melting, Plant, Steroids,#Robot, Chicken,Horror,#Yung Cuz, Enemies & Bosses"),
		"@sJoonas Turner@w",
		"",
		"@w" + L("Voice:RebelAnd", "Rebel & Additional IDPD"),
		"@sIsa And",
		"",
		"@w" + L("Voice:YV", "Y.V. & Venus Enemies"),
		"@sAdam Drucker",
		"",
		"@w" + L("Voice:Frog", "Frog"),
		"@sJukio Kallio",
		"",
		"@w" + L("Voice:Captain", "Captain"),
		"@sMyy Lohi",
		"",
		"@w" + L("Voice:Rogue", "Rogue"),
		"@sDanielle McRae",
		"",
		"@w" + L("Voice:IDPD", "Additional IDPD"),
		"@sNiilo Takalainen"
	],
	[
		"@w" + L("PromoArt", "Promotional Artwork"),
		"@sJustin Chan",
		"",
		"@w" + L("Conlang", "Language Design"),
		"@sJoonas Turner",
		"",
		"@w" + L("Management", "Backend Programming#Community Management#Release Management"),
		"@sRami Ismail",
		"",
		"@w" + L("YAL", "Additional Programming#Porting"),
		"VADYM 'YELLOWAFTERLIFE' DIACHENKO",
		"",
		"@w" + L("AdditionalEngineering", "Addional Engineering"),
		"@sJuju Adams",
	],
	[
		"@w" + L("Trailers", "Trailers"),
		"@sBram Ruiter#Daniel Carneiro#Kert Gartner#Marlon Wiebe#",
		"",
		"@w" + L("Event Logistics", "Event Logistics"),
		"@sAdriel Wallick#Fred Wood#Jon Kay#Maya Kramer#Rami Ismail",
	],
	[
		"@w" + L("Marketing", "Marketing"),
		"@sRami Ismail",
		"",
		"@w" + L("Additional Marketing", "Additional Marketing"),
		"@sJan Willem Nijman#Joonas Turner#Jukio Kallio#Justin Chan#Paul Veer"
	],
	[
		"@wNUCLEAR THRONE MOBILE",
		"",
		/// @loc:token [R:Credits] Creator "PROJECT CREATOR & MAINTAINER"
		"@w" + loc("R:Credits", "Creator", "PROJECT CREATOR & MAINTAINER"),
		"TONCHO_",
		"",
		/// @loc:token [R:Credits] TestersAndStaff "TESTERS"
		"@w" + loc("R:Credits", "TestersAndStaff", "TESTERS"),
		"@sEVILCAT   CZIMBALA   SKUHNUH   WINT#VOROB   DRAKIN   TIREDMETAL   #LOMEGAI   PLOWECH   SENJEY",
		"",
		/// @loc:token [R:Credits] Localization "LOCALIZATION CONTRIBUTORS"
		"#@w" + loc("R:Credits", "Localization", "LOCALIZATION CONTRIBUTORS"),
		"#" + _ntmobile_localizers,
		"#",
		/// @loc:token [R:Credits] LegacyLocalization "LEGACY LOCALIZERS"
		"@w" + loc("R:Credits", "LegacyLocalization", "LEGACY LOCALIZERS"),
		"",
		"@wBRAZILIAN PORTUGUESE#@sMIGUEL#TITIO CARTOLA#GUIZARD#POTATO SALAD#",
		"@wSPANISH#@sFRI#BAYRON#WALTERLZ#",
		"@wPOLISH#@sLOSSTAROTT#",
		"@wUKRAINIAN#@sPRAWO#REPKON#",
		"@wPERSIAN#@sPLOOB"
	],
	[
		"@wValve#@sAnna Sweet#Augusta Butlin#John Bartkiw#Matt Nickerson##@wHumble#@sAlex Ting#Will Turnbull##@wTwitch#@sErnest Le#Jon 'Carnage' Joyce##@wDevstream Support#@sBenn Powell#Dominik Johann#Gieron#Lisa 'Wertle' Brown#Seef 'IgnoTV' Ismail#Sleepcycles#Vlambot#XSplit##@wYoYo Games#@sMike Dailly#Russell Kay#Peter Hall#Sandy Duncan#Stuart Poole##@wSONY Computer Entertainment#@sAdam Boyes#Andrew Wong#Ben Andac#Blanca Nunez Ibanez#Bob Jordan#Brian Silva#Dan 'Shoe' Hsu#Gio Corsi#Jericho Guerrero#John Drake#John Kopp#Julio Perez#Justin Massongill#Laura Casey#Lorenzo Grimaldi#Nathalie Closs#Nick Suttner#Richard Lee#Ryan Clements#Shahid Kamal Ahmad#Shane Bettenhausen#Shuhei Yoshida#Sid Shuman",
		"",
		"@w" + L("Merchandise", "Merchandise"),
		"Fangamer#Fred Wood#Gijs van Kooten#Jon 'Jonty' Hicks#Jon Kay#Level Up Studios#Shawn Handyside#",
		"",
		"@w" + L("Wiki Master", "Wiki Master"),
		"Gieron",
		"",
		"@wThronebutt",
		"Ivan Ostric",
		"Chitinlink",
		"",
		L("Update Videos", "Update Videos"),
		"Tengu Drop",
		"",
		"@w" + L("BobWeave", "Bobbing & Weaving"),
		"SleepCycles",
		"",
		"@w" + L("Community Challenges", "Community Challenges"),
		"Solid",
		"",
		"@w" + L("World Tournament", "World Tournament"),
		"Smite",
		"",
		"@w" + L("SpecialThanks", "Special Thanks"),
		"17-Bit#Adriel Wallick#Alexa#Allan Keith#Anthony Carboni#Bart Jan Bultman#Beau Blyth#Ben Vance#Bisnap#Brandon Boyer#Brian van Bruggen#Bronson Zgeb#Burgeroise#Chris Charla#CodeMan38#Crystal Chan#Daniel 'Manna' Hagstrom#DED#DevilAzite#Derek Yu#Dutch Game Garden#Evan Balster#Glitch City#Greg Wohlwend#Hademar#Jack Oatley#James Eagler#Janette Silvasti#Jerry Holkins#Jerry van Kooten#Jord Coerse#JMickle#Kakujo#Kitty Calis#Kosti Kallio#Kristy Norindr#Mark Essen#Martin Kvale#Martin van der Wolf#Mike Feith#Mirva Kontio#Neri & Bali#Nigel Lowrie#Phil Tibitoski#Pissasedat#Poppenkast#Ross Turner#Roy Nathan de Groot#Richard Boeser#Seef Ismail#Sidonie Tise#Sirpa Kallio#Sirpa Niskala#Slackbot#Ster#Sven Ruthner#Ted Martens#Teddy Diefenbach#Tingle#Tuuka#Vincent Nijman#Wiley 'Willy Woggins' Wiggins#Zach Gage",
		"",
		"@w" + L("Mojam", "Nuclear Throne would not exist without#Humble, MOJANG and the organizers#of MOJAM 2013"),
		"",
		"@w" + L("MadeWithGameMaker", "Nuclear Throne was created using#YoYoGames' GameMaker"),
		"",
		"@w" + L("BigMony", "Nuclear Throne extends its thanks to#COOL BIG MONY BIZNIZ INC.#for providing the image of Yung Venuz."),
		"",
		"Anna Sweet#Augusta Butlin#John Bartkiw#Matt Nickerson#​##Alex Ting#Will Turnbull#​##Ernest Le#Jon 'Carnage' Joyce#​##Benn Powell#Dominik Johann#Gieron#Lisa 'Wertle' Brown#Seef 'IgnoTV' Ismail#Sleepcycles#Vlambot#XSplit#​##Mike Dailly#Russell Kay#Peter Hall#Sandy Duncan#Stuart Poole#​##Adam Boyes#Andrew Wong#Ben Andac#Blanca Nunez Ibanez#Bob Jordan#Brian Silva#Dan 'Shoe' Hsu#Gio Corsi#Jericho Guerrero#John Drake#John Kopp#Julio Perez#Justin Massongill#Laura Casey#Lorenzo Grimaldi#Nathalie Closs#Nick Suttner#Richard Lee#Ryan Clements#Shahid Kamal Ahmad#Shane Bettenhausen#Shuhei Yoshida#Sid Shuman###Fangamer#Fred Wood#Gijs van Kooten#Jon 'Jonty' Hicks#Jon Kay#Level Up Studios#Shawn Handyside#​##Gieron#Ivan Ostric#Tengu Drop#SleepCycles#Solid#Smite#17-Bit#Adriel Wallick#Alexa#Allan Keith#Anthony Carboni#Bart Jan Bultman#Beau Blyth#Ben Vance#Bisnap#Brandon Boyer#Brian van Bruggen#Bronson Zgeb#Burgeroise#Chris Charla#CodeMan38#Crystal Chan#Daniel 'Manna' Hagstrom#DED#DevilAzite#Derek Yu#Dutch Game Garden#Evan Balster#Glitch City#Greg Wohlwend#Hademar#Jack Oatley#James Eagler#Janette Silvasti#Jerry Holkins#Jerry van Kooten#Jord Coerse#JMickle#Kakujo#Kitty Calis#Kosti Kallio#Kristy Norindr#Mark Essen#Martin Kvale#Martin van der Wolf#Mike Feith#Mirva Kontio#Neri & Bali#Nigel Lowrie#Phil Tibitoski#Pissasedat#Poppenkast#Ross Turner#Roy Nathan de Groot#Richard Boeser#Seef Ismail#Sidonie Tise#Sirpa Kallio#Sirpa Niskala#Slackbot#Ster#Sven Ruthner#Ted Martens#Teddy Diefenbach#Tingle#Tuuka#Vincent Nijman#Wiley 'Willy Woggins' Wiggins#Zach Gage###​##​#",
	],
	[
		"@w" + L("Community", "Nuclear Throne could not exist#without the Vlambeer community.#This game could have gone off-track#in so many ways,#but your patience, support, enthusiasm,#feedback and hard work kept us sharp,#motivated and eager to find#fun and new ways to end your runs.")
	],
	[
		"@w" + L("Family", "Thanks to our family, our friends#and our partners#for their unyielding support,#love, care and patience.#@w<3")
	],
	[
		"@w" + L("You", "Thank you for playing!")
	],
	[
		"@wNUCLEAR THRONE",
	]
]

array_map_ext(credittext, function(_lines) {
	return "@s" + string_hash_to_newline(string_join_ext("\n@s", _lines))
})

if (_basegame_localizers != "") {
	var _length = array_length(credittext)
	credittext[_length - 5] += $"\n{_basegame_localizers}"
}
