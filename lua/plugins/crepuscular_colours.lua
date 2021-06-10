local lush = require("lush")
local hsl = lush.hsl

-- CREPUSCULAR -------------------------

-- Colours
local colours = {
	black = hsl(275, 20, 10), -- original "#111224"
	blue = hsl(215, 75, 45), -- original "#155199"
	cyan = hsl(175, 45, 60), -- original "#6187ae"
	green = hsl(130, 30, 30), -- original "#354e39"
	grey = hsl(315, 5, 30), -- original "#786674"
	orange = hsl(20, 75, 50), -- original "#ec722f"
	purple = hsl(260, 75, 45), -- original "#673a5b"
	red = hsl(350, 60, 40), -- original "#a95062"
	white = hsl(30, 60, 80), -- original "#ebd3b9"
	yellow = hsl(40, 100, 60), -- original "#ffc346"

	lightBlack = hsl(275, 25, 15), -- original "#222035"
	lightBlue = hsl(215, 75, 60), -- original "#356ea5"
	lightCyan = hsl(175, 60, 90), -- original "#83a0c8"
	lightGreen = hsl(85, 30, 45), -- original "#5e723f"
	lightGrey = hsl(310, 10, 60), -- original "#9f8d9d"
	lightOrange = hsl(25, 100, 67), -- original "#fe882e"
	lightPurple = hsl(260, 75, 75), -- original "#9f7195"
	lightRed = hsl(0, 90, 80), -- original "#c5696e"
	lightWhite = hsl(45, 70, 95), -- original "#fcf9f0"
	lightYellow = hsl(40, 100, 75), -- original "#ffd782"
}

return colours
