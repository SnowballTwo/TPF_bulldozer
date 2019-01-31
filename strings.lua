local function readAll(file)
	local f = assert(io.open(file, "rb"))
	local content = f:read("*all")
	f:close()
	return content
end

function data()
	return {
		de = {
			title = "Planierraupe & Abrissbirne",
			description = "Zwei mächtige Werkzeuge zum Planieren und Abreißen",
			snowball_bulldozer_title = "Planierraupe",
			snowball_bulldozer_description = "Kann zum Planieren einer beliebig geformten Fläche genutzt werden.\n\z
		-----------------------------------------\n\z
		\n\z
		Schritt 1: Im Modus 'Planen' den Umriss der Fläche festlegen.\n\z		
		Schritt 2: Einstellungen festlegen.\n\z		
		Schritt 3: Mit einem Klick auf 'Planieren' den Bereich planieren.\n\z
		-----------------------------------------\n\z
		\n\z
		Zurücksetzen: Entfernt den aktuellen Bereich, falls vorhanden.",
			snowball_wreckingball_title = "Abrissbirne",
			snowball_wreckingball_description = "Kann zum Entfernen vieler Objekte auf einmal genutzt werden.\n\z
		-----------------------------------------\n\z
		\n\z
		Schritt 1: Im Modus 'Planen' den Umriss des Abrissbereichs festlegen.\n\z		
		Schritt 2: Gewünschten Objekttyp zum Abreißen festlegen.\n\z		
		Schritt 3: Mit einem Klick auf 'Abreißen' alles im Bereich abreißen.\n\z
		-----------------------------------------\n\z
		\n\z
		Zurücksetzen: Entfernt den aktuellen Bereich, falls vorhanden.\n\n\z
		Hinweis: Gesucht wird nach der Objektmitte, d.h. Objekte am Rand des Bereichs werden eventuell nicht entfernt.",
			snowball_bulldozer_mode = "Modus",
			snowball_bulldozer_type = "Typ",
			snowball_bulldozer_plan = "Planen",
			snowball_bulldozer_bulldoze = "Abreißen",
			snowball_bulldozer_level = "Planieren",
			snowball_bulldozer_reset = "Zurücksetzen",
			snowball_bulldozer_all = "Alle",
			snowball_bulldozer_assets = "Assets",
			snowball_bulldozer_constructions = "Gebäude",
			snowball_bulldozer_leveling = "Aktion",
			snowball_bulldozer_equal = "Einebnen",
			snowball_bulldozer_less = "Abtragen",
			snowball_bulldozer_greater = "Aufschütten"
		},
		en = {
			title = "Bulldozer & Wreckingball",
			description = "Two powerful tools to level and destroy",
			snowball_bulldozer_title = "Bulldozer",
			snowball_bulldozer_description = "Can be used to level an area of arbitary shape.\n\z	
	-----------------------------------------\n\z
	\n\z
	Step 1: Set the outline of the bulldozer in 'plan' mode.\n\z	
	Step 2: Specify further settings.\n\z	
	Step 3: Level the area by clicking 'level'.\n\z	
	-----------------------------------------\n\z
	\n\z
	Reset: removes the current outline if one exists.",
			snowball_wreckingball_title = "Wreckingball",
			snowball_wreckingball_description = "Can be used to bulldoze a lot of objects at once.\n\z	
	-----------------------------------------\n\z
	\n\z
	Step 1: Set the outline of the wreckingball in 'plan' mode.\n\z	
	Step 2: Specify the entity types to bulldoze.\n\z	
	Step 3: Bulldoze everything in the area with 'bulldoze'.\n\z	
	-----------------------------------------\n\z
	\n\z
	Reset: removes the current outline if one exists.\n\n\z
	Hint: Searches for the center of an object, which means that objects near the border are possibly not bulldozed",
			snowball_bulldozer_mode = "mode",
			snowball_bulldozer_type = "type",
			snowball_bulldozer_plan = "plan",
			snowball_bulldozer_bulldoze = "bulldoze",
			snowball_bulldozer_level = "level",
			snowball_bulldozer_reset = "reset",
			snowball_bulldozer_all = "all",
			snowball_bulldozer_assets = "assets",
			snowball_bulldozer_constructions = "buildings",
			snowball_bulldozer_leveling = "leveling",
			snowball_bulldozer_equal = "planar",
			snowball_bulldozer_less = "remove",
			snowball_bulldozer_greater = "add"
		}
	}
end
