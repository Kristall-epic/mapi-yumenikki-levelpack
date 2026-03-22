
PONIKO_ON = 1
PONIKO_NIGHT = 2
PONIKO_UBOA = 3

uboa = false
apparition = audio_stream_load("uboa.ogg")
uboaouch = audio_sample_load("uboaouch.ogg")
flash = 0

function light_switch()
  if gNetworkPlayers[0] then
    if uboa == true then
      flash = 3
  return end

  event = not event
  
  if event == true then
    
    if math.random(1, 32) == 2 then
    poniko_set_textures(PONIKO_UBOA)
    _G.MAPi.hangout_edit_bgm(hangout_poniko, 1, apparition)
    flash = 3
    uboa = true
    return
    end
    
    _G.MAPi.hangout_edit_bgm(hangout_poniko, 1, ponikobgm_off)
    _G.MAPi.hangout_edit_env_tint(hangout_poniko, 1, {r = 180, g = 180, b = 180}, {x = 0, y = 1, z = 0})
    
    poniko_set_textures(PONIKO_NIGHT)
    
    else
      reset_poniko()
    end
  
  end
end

function marioUpdate(m)
  
  if m.playerIndex ~= 0 then
    return end
  if _G.MAPi.get_cur_hangout() ~= hangout_poniko then
    return end

    LOOP_POINT = djui_hud_get_screen_width()/djui_hud_get_screen_height()*1800

  if gNetworkPlayers[0].currAreaIndex == 2 then
    local c = gLakituState
    local focusPos = {
      x = m.pos.x,
      y = math.lerp(c.focus.y, 700, 0.1),
      z = m.pos.z
    }
    
    local camPos = {
      x = m.pos.x,
      y = math.lerp(c.pos.y, 800, 0.1),
      z = m.pos.z - 2500
    }
    
    m.pos.z = 0
    m.forwardVel = m.forwardVel/1.05
    
    if m.pos.x > LOOP_POINT then
      m.pos.x = -LOOP_POINT + 1
      focusPos.x = m.pos.x
      camPos.x = m.pos.x
      focusPos.z = m.pos.z
      camPos.z = m.pos.z - 2500
      skip_camera_interpolation()
    elseif m.pos.x < -LOOP_POINT then
      m.pos.x = LOOP_POINT - 1
      focusPos.x = m.pos.x
      camPos.x = m.pos.x
      focusPos.z = m.pos.z
      camPos.z = m.pos.z - 2500
      skip_camera_interpolation()
    end

    vec3f_copy(c.focus, focusPos)
    vec3f_copy(c.pos, camPos)
    
    end
  
  if uboa == true then
    cur_obj_shake_screen(SHAKE_POS_BOWLING_BALL)
    
    if m.controller.buttonPressed & START_BUTTON ~= 0 then
      m.controller.buttonPressed = m.controller.buttonPressed & ~START_BUTTON
      play_sound(SOUND_MENU_CAMERA_BUZZ, m.marioObj.header.gfx.cameraToObject)
      flash = 3
    end
    
    if mario_is_within_rectangle(-1333, -1110, 140, 360) ~= 0 and m.pos.y < 360 then
      audio_sample_play(uboaouch, m.pos, 3)
      warp_to_warpnode(LVL_PONIKO, 2, gNetworkPlayers[0].currActNum, 0x0A)
      camera_freeze()
      end
    
    end
  
  if debounce > 0 then
    debounce = debounce - 1
    end
  
  if debounce == 0 and mario_is_within_rectangle(95, 230, 90, 250) ~= 0 and ((m.action == ACT_JUMP_KICK and m.forwardVel < 0) or m.action & MARIO_KICKING ~= 0) then
    light_switch()
    debounce = 30
    end
  
end

function flashing()
  
  if flash > 0 then
    djui_hud_set_color(255, 255, 255, 255)
    djui_hud_render_rect(0, 0, djui_hud_get_screen_width(), djui_hud_get_screen_height())
    flash = flash - 1
    end
  
end

function on_exit_uboa()
  if (gNetworkPlayers[0].currLevelNum == LVL_PONIKO and gNetworkPlayers[0].currAreaIndex ~= 2) or gNetworkPlayers[0].currLevelNum ~= LVL_PONIKO then
    camera_unfreeze()
    end
  end

if _G.MAPi_Active then
hook_event(HOOK_ON_HUD_RENDER_BEHIND, flashing)
hook_event(HOOK_MARIO_UPDATE, marioUpdate)
hook_event(HOOK_ON_WARP, on_exit_uboa)
end

function reset_poniko()
  
  if gNetworkPlayers[0].currAreaIndex == 2 then
    return end

_G.MAPi.hangout_edit_bgm(hangout_poniko, 1, ponikobgm_on)
      _G.MAPi.hangout_edit_env_tint(hangout_poniko, 1, {r = 255, g = 255, b = 255}, {x = 0, y = 0, z = 0})
      
      poniko_set_textures(PONIKO_ON)
      
end


ponikofloorpink = get_texture_info("ponikofloorpink")
ponikofloorpink_night = get_texture_info("ponikofloorpink_night")
ponikofloor_uboa = get_texture_info("ponikofloor_uboa")
ponikowallwood = get_texture_info("ponikowallwood")
poniko_floor_wall = get_texture_info("poniko_floor_wall")
poniko_floor_wall_night = get_texture_info("poniko_floorwall_night")
poniko_floor_wall_uboa = get_texture_info("poniko_floorwall_uboa")


poniko_spritesheet_day = get_texture_info("poniko_sprite_day")
poniko_spritesheet_night = get_texture_info("poniko_sprite_night")
poniko_spritesheet_uboa = get_texture_info("poniko_sprite_uboa")

function poniko_set_textures(txt)
  
  if txt == PONIKO_NIGHT then
    texture_override_set("LEVEL_PONIKO_dl_ponikofloorpink_ci4", ponikofloorpink_night)
    texture_override_set("LEVEL_PONIKO_dl_ponikowallwood_ci4", ponikofloorpink_night)
    texture_override_set("LEVEL_PONIKO_dl_poniko_floor_wall_ci4", poniko_floor_wall_night)
    texture_override_set("LEVEL_PONIKO_dl_ponikoday_rgba16", 
      poniko_spritesheet_night)
  end
  
  if txt == PONIKO_ON then
    
    texture_override_reset("LEVEL_PONIKO_dl_ponikofloorpink_ci4")
    texture_override_reset("LEVEL_PONIKO_dl_ponikowallwood_ci4")
    texture_override_reset("LEVEL_PONIKO_dl_poniko_floor_wall_ci4")
    texture_override_reset("LEVEL_PONIKO_dl_ponikoday_rgba16")
  end
  
  if txt == PONIKO_UBOA then
    texture_override_set("LEVEL_PONIKO_dl_ponikofloorpink_ci4", ponikofloor_uboa)
    texture_override_set("LEVEL_PONIKO_dl_ponikowallwood_ci4", ponikofloor_uboa)
    texture_override_set("LEVEL_PONIKO_dl_poniko_floor_wall_ci4", poniko_floor_wall_uboa)
    texture_override_set("LEVEL_PONIKO_dl_ponikoday_rgba16", 
      poniko_spritesheet_uboa)
    end
  
  
  end