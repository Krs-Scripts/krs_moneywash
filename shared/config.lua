lib.locale()

cfg = {}

cfg.waitRewashing = 60000 -- The player must wait 1 minute before being able to launder dirty money again.

cfg.washDuration = 30000 -- The time it takes for the player to launder the money. 30 seconds.

cfg.percentage = 0.50 -- Laundering percentage.

cfg.iconDialog = 'fa-solid fa-sack-dollar' -- Dialog icon.

cfg.positionProgress = 'middle' -- Progress bar position.

cfg.positionTextUi = "right-center" -- TextUI position.

cfg.iconTextUi = 'fa-solid fa-sack-dollar' -- TextUI icon.

cfg.borderRadius = 5 -- TextUI border radius.

cfg.backgroundColor = '#25262B' -- TextUI background color.

cfg.color = 'white' -- TextUI text color.

cfg.positionWashing = { 

    {
        coords = vector3(637.0958, 2784.7517, 42.0103), -- Money laundering location.
    },
}
