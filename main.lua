-- name: [MAP] Yume Nikki Level Pack

if MAPi_Active then
  --adds a new hangout to mapi
  hangout_madotsuki = MAPi.hangout_map_add(
    LEVEL_MADO, 
    "Madotsuki's Room",
    "The room of the protagonist from the game Yume Nikki!",
    "Kristall",
    get_texture_info("prev-mado"),
    madobgm
    )
    
  --adds an entry sound to the hangout
  MAPi.hangout_add_entry_sound(hangout_madotsuki, madoenter)
  
  --adds a skybox to the hangout, it will complete a full rotation in 240 seconds
  MAPi.hangout_add_skybox(hangout_madotsuki, {
    skytype = "ico",
    front = madoSkies[1]
  }, 240)

  MAPi.hangout_edit_text_color(hangout_madotsuki, {r = 0xD2, g = 0x54, b = 0x69})
  
  --adds an environment tint so it can be modified later
  MAPi.hangout_add_env_tint(hangout_madotsuki, {r = 255, g = 255, b = 255}, {x = 0, y = 0, z = 0})
  
  --adds a new hangout to mapi
  hangout_poniko = MAPi.hangout_map_add(
    LVL_PONIKO, 
    "Poniko's House",
    "The house of one of the NPCs from the game Yume Nikki! (it does the thing btw)",
    "Kristall",
    get_texture_info("prev-poniko"),
    {
      [1] = ponikobgm_on,
      [2] = whitedesert
    })
  
  --Adds an entry sound to the level
  MAPi.hangout_add_entry_sound(hangout_poniko, ponikoenter)
  
  --Adds an environment tint to the map so it can be modified later
  MAPi.hangout_add_env_tint(hangout_poniko, {r = 255, g = 255, b = 255}, {x = 0, y = 0, z = 0})
  
  --adds a non existent skybox to area 1 (poniko house) so it uses the default one set in blender (in this case pitch black)
  MAPi.hangout_add_skybox(hangout_poniko, {nil})
  
  MAPi.hangout_edit_text_color(hangout_poniko, {r = 0xAD, g = 0xD6, b = 0x5C})

  --adds a skybox to area 2 (uboa's trap) since it is the second time the function is called on the same hangout
  MAPi.hangout_add_skybox(hangout_poniko,
   {
    skytype = "ico",
    front = uboasky
  }, 120)
  
  else
    djui_popup_create("MAPi is not active! Activate to use this mod", 2)
end
