
event = false
kalimba_event = false
xPos = 0
xPosBottom = 0
debounce = 0

madoSkies = {
  [1] = madosky,
  [2] = madosky2,
  [3] = madosky3,
  [4] = madosky4,
}

function randomSky()
  if gNetworkPlayers[0] then
randomSky = math.random(1, 4)
_G.MAPi.hangout_edit_skybox(hangout_madotsuki, 1, {front = madoSkies[randomSky]
  })

event = false
kalimba_event = false
_G.MAPi.hangout_edit_bgm(hangout_madotsuki, 1, madobgm)
_G.MAPi.hangout_edit_env_tint(hangout_madotsuki, 1, {r = 255, g = 255, b = 255}, {x = 0, y = 0, z = 0})
reset_poniko()
uboa = false
playingNasu = false
      
texture_override_reset("LEVEL_MADO_dl_terebi_rgba32")

end
end

function event_madotsuki(m)
  
 -- djui_hud_render_texture(artificialLife, 0, 0, 1, 1)
  
  if m.playerIndex ~= 0 then
    return end
  if _G.MAPi.get_cur_hangout() ~= hangout_madotsuki then
    return end
  
  if debounce > 0 then
    debounce = debounce - 1
    end
  
  if (mario_is_within_rectangle(-746, -458, 720, 1020) ~= 0 and (m.pos.y > 75 and m.pos.y < 95)) and mario_is_ground_pound_landing(m) and debounce == 0 then
    event = not event
    debounce = 30
    
    if event == true then
      
      audio_sample_play(tv_on, {x = -881, y = 171, z = 812}, 7)
      
      if randomSky == 1 or randomSky == 2 then
    _G.MAPi.hangout_edit_bgm(hangout_madotsuki, 1, madonasu)
    texture_override_set("LEVEL_MADO_dl_terebi_rgba32", tv_nasu)
    playingNasu = true
    else
      
      if math.random(1, 8) == 2 then
      _G.MAPi.hangout_edit_bgm(hangout_madotsuki, 1, madokalimba)
      _G.MAPi.hangout_edit_env_tint(hangout_madotsuki, 1, {r = 63, g = 63, b = 63}, {x = 0, y = 1, z = 0})
      kalimba_event = true
      texture_override_set("LEVEL_MADO_dl_terebi_rgba32", tv_kalimba)
      else
      _G.MAPi.hangout_edit_bgm(hangout_madotsuki, 1, madodream)
     texture_override_set("LEVEL_MADO_dl_terebi_rgba32", tv_eye)
     _G.MAPi.hangout_edit_env_tint(hangout_madotsuki, 1, {r = 127, g = 127, b = 127}, {x = 0, y = 1, z = 0})
      end
      
      end
  
    else
      _G.MAPi.hangout_edit_bgm(hangout_madotsuki, 1, madobgm)
      _G.MAPi.hangout_edit_env_tint(hangout_madotsuki, 1, {r = 255, g = 255, b = 255}, {x = 0, y = 0, z = 0})
      kalimba_event = false
      texture_override_set("LEVEL_MADO_dl_terebi_rgba32", tv_normal)
      audio_sample_play(tv_off, {x = -881, y = 171, z = 812}, 7)
      playingNasu = false
    end
  end
  
end

function kalimba()
  djui_hud_set_resolution(RESOLUTION_N64)
  
  if gMarioStates[0].playerIndex ~= 0 then
    return end
  
  if _G.MAPi.get_cur_hangout() ~= hangout_madotsuki then
    return end
  
  if event == true and kalimba_event == true then
    xPos = xPos + 1
    
    if xPos > 256 then
      xPos = 0
    end
    
    djui_hud_render_texture_tile(KALIMBA_IMAGE, 0, 0, 0.125, 2, xPos, 0, 1024, 64)
    
    djui_hud_render_texture_tile(KALIMBA_IMAGE, 0, djui_hud_get_screen_height() - 128, 0.125, 2, -1 * xPos + 256, 64, 1024, 64)
    
    end
  
end

if _G.MAPi_Active then

hook_event(HOOK_ON_HUD_RENDER_BEHIND, kalimba)

hook_event(HOOK_MARIO_UPDATE, event_madotsuki)

hook_event(HOOK_ON_WARP, randomSky)

end