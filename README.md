# krs_moneywash


![FiveM® by Cfx re - Krs Gamemode 19_07_2023 14_10_06](https://github.com/KRS-KAROS/krs_moneywash/assets/131356071/45bb446e-f921-422b-841f-82d204da7c06)

![FiveM® by Cfx re - Krs Gamemode 19_07_2023 14_15_25](https://github.com/KRS-KAROS/krs_moneywash/assets/131356071/ab9ddcd8-32dd-4c9b-b465-6c9aa0882dc1)

```lua

Krs    = {}

Krs.Currency     = '$' -- € / $
Krs.Washprezzo    = '50' -- How much should be removed by washing - !! do not add %!! --
Krs.Icon = "fa-solid fa-sack-dollar"
Krs.Label = "Money washing"
Krs.type = 'ox_target' -- Set the type to 'marker' 'ox_target'

Krs.PosWash = {
    
    marker = vector3(607.2974, -3084.1411, 6.0693), -- I use Markers
}

Krs.NpcWash = {

    {
     modelloNpc = 'g_m_y_korlieut_01', -- https://docs.fivem.net/docs/game-references/ped-models/ --
     posizioneNpc = vector4(607.3422, -3084.7659, 5.0693, 3.2135), -- I use ox_target on the Ped
    }
  
}

Krs.Lang = {

    ['titolo1']   = 'KRS', -- NAME TITLE BG --
    ['titolo2']  = 'MONEYWASH', -- NAME TITLE BG --
    ['msg'] = '[E] - Money Washing', 
    ['prezzo']       = 'Price',
    ['soldisporchi']     = 'Dirty Money', 
    ['soldipuliti']      = 'Clean Money', 
    ['lavaggiosoldi']    = 'wash money', 
    ['nonhaisoldi']    = 'You don\'t have enough Dirty Money to wash, come back later when you have more.', 
    ['accetta']      = 'accept',
    ['annulla']      = 'cancel',
}

-- Blip Money Wash
Krs.PosBlipWash = {

    {
        poswashmoney = vector3(607.3422, -3084.7659, 5.0693),
        blip = {
            active = true,
            sprite = 500,
            color = 43,
            size = 0.7,
            name = "Money washing"
        }
    },
}

```
