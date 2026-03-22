playingNasu = false
nasuBG = get_texture_info("nasu-bg")
SPRITE_NASU = get_texture_info("nasu_sprite")
NASU_SCORE = 0
NASU_HIGHSCORE = mod_storage_load_number("HIGHSCORE")

NASU_ANIM_IDLE = {x = 1, y = 1}
NASU_ANIM_JUMP = {x = 2, y = 1}
NASU_ANIM_WALK1 = {x = 1, y = 2}
NASU_ANIM_WALK2 = {x = 2, y = 2}
NASU_ANIM_WALK3 = {x = 3, y = 2}

NASU_WALK_SPEED = 2.5
NASU_JUMP_HEIGHT = 5
NASU_GRAVITY = 1

NASU_FLOOR_HEIGHT = math.floor(djui_hud_get_screen_height()/2 + nasuBG.height/2 - 91)
NASU_CEIL_HEIGHT = math.floor(djui_hud_get_screen_height()/2 - nasuBG.height/2 + 57)
NASU_LEFT_WALL = math.floor(djui_hud_get_screen_width()/2 - nasuBG.width/2 + 44)
NASU_RIGHT_WALL = math.floor(djui_hud_get_screen_width()/2 + nasuBG.width/2 - 44)
  

n = {
  tex = SPRITE_NASU,
  pos = {x = 240, y = 140},
  vel = {x = 0, y = 0},
  grav = NASU_GRAVITY,
  jumping = false,
  dir = 1,
  anim = {x = 1, y = 1},
  animDebounce = 0,
  walkTimer = 1
}

ep = {
  tex = SPRITE_NASU,
  pos = {x = 260, y = 0},
  vel = 1.75
}

function nasu_player()
  m = gMarioStates[0]
  
  if m.controller.buttonPressed & A_BUTTON ~= 0 and n.jumping == false then
    n.vel.y = - NASU_JUMP_HEIGHT
    audio_sample_play(nasujump, m.pos, 1)
  end
  
  if m.controller.buttonDown & L_JPAD ~= 0 or m.controller.rawStickX/127 < -0.5 then
    n.vel.x = -NASU_WALK_SPEED
    n.animDebounce = n.animDebounce + 1
    if n.jumping == false then
     n.dir = -1
    end
elseif m.controller.buttonDown & R_JPAD ~= 0 or m.controller.rawStickX/127 > 0.5 then
    n.vel.x = NASU_WALK_SPEED
    n.animDebounce = n.animDebounce + 1
    if n.jumping == false then
     n.dir = 1 
     end
end

if n.animDebounce > 4 then
  n.walkTimer = n.walkTimer + 1
  n.animDebounce = 1
  end

if n.walkTimer > 3 then
  n.walkTimer = 1
  if n.jumping == false then
  audio_sample_play(nasustep, m.pos, 1)
  end
  end
  
  if m.controller.buttonDown & L_JPAD == 0 and m.controller.buttonDown & R_JPAD == 0 and math.abs(m.controller.rawStickX/127) < 0.5 then
    if n.jumping == false then
    n.anim = NASU_ANIM_IDLE
    n.walkTimer = 0
    end
    n.vel.x = 0
  end
  
  if m.controller.buttonPressed & B_BUTTON ~= 0 then
    _G.MAPi.hangout_edit_bgm(hangout_madotsuki, 1, madobgm)
      _G.MAPi.hangout_edit_env_tint(hangout_madotsuki, 1, {r = 255, g = 255, b = 255}, {x = 0, y = 0, z = 0})
      kalimba_event = false
      texture_override_reset("LEVEL_MADO_dl_terebi_rgba32")
      audio_sample_play(tv_off, {x = -881, y = 171, z = 812}, 7)
      playingNasu = false
      event = not event
      set_mario_action(m, ACT_IDLE, 0)
      soft_reset_camera(m.area.camera)
    end
  
  if n.pos.y > NASU_FLOOR_HEIGHT then
    n.pos.y = NASU_FLOOR_HEIGHT
    n.jumping = false
  end

if n.pos.y < NASU_FLOOR_HEIGHT then
  n.vel.y = n.vel.y + n.grav
  n.jumping = true
end

if n.jumping == true then
  n.anim = NASU_ANIM_JUMP
  else
    if n.walkTimer == 1 then
      n.anim = NASU_ANIM_WALK1
    elseif n.walkTimer == 2 then
      n.anim = NASU_ANIM_WALK2
    elseif n.walkTimer == 3 then
      n.anim = NASU_ANIM_WALK3
      end
  end
  
end

function egg_plant_update()
  m = gMarioStates[0]
  
  if math.abs((n.pos.x) - (ep.pos.x + 8)) < 4 and math.abs((n.pos.y) - (ep.pos.y + 8)) < 8 then
    if n.jumping == true then
      ep.pos.y = NASU_CEIL_HEIGHT
      ep.pos.x = math.random(NASU_LEFT_WALL, NASU_RIGHT_WALL - 8)
      NASU_SCORE = NASU_SCORE + 10
      audio_sample_play(nasuacquire, m.pos, 1)
      end
  end
  
  if ep.pos.x > NASU_RIGHT_WALL or ep.pos.x < NASU_LEFT_WALL then
    ep.pos.x = math.random(NASU_LEFT_WALL, NASU_RIGHT_WALL - 8)
    end
  
  
  if ep.pos.y > NASU_FLOOR_HEIGHT then
    ep.pos.y = NASU_CEIL_HEIGHT
    ep.pos.x = math.random(NASU_LEFT_WALL, NASU_RIGHT_WALL - 8)
    
    audio_sample_play(nasuouch, m.pos, 1)
    
    if NASU_SCORE > NASU_HIGHSCORE then
      NASU_HIGHSCORE = NASU_SCORE
      mod_storage_save_number("HIGHSCORE", NASU_HIGHSCORE)
    end
    
    NASU_SCORE = 0
    end
  
  end


function render_nasu()
  if playingNasu == false then return end
  
  set_mario_action(gMarioStates[0], ACT_READING_NPC_DIALOG, 0)
  
  djui_hud_set_resolution(RESOLUTION_N64)
  
  NASU_FLOOR_HEIGHT = math.floor(djui_hud_get_screen_height()/2 + nasuBG.height/2 - 91)
  NASU_CEIL_HEIGHT = math.floor(djui_hud_get_screen_height()/2 - nasuBG.height/2 + 57)
  NASU_LEFT_WALL = math.floor(djui_hud_get_screen_width()/2 - nasuBG.width/2 + 44)
  NASU_RIGHT_WALL = math.floor(djui_hud_get_screen_width()/2 + nasuBG.width/2 - 44)
  
  nasu_player()
  
  if n.pos.x < NASU_LEFT_WALL then
    n.pos.x = NASU_LEFT_WALL
  elseif n.pos.x > NASU_RIGHT_WALL then
    n.pos.x = NASU_RIGHT_WALL
    end
  
  
  djui_hud_set_color(0, 0, 0, 200)
  djui_hud_render_rect(0, 0, djui_hud_get_screen_width(), djui_hud_get_screen_height())
  djui_hud_set_color(255, 255, 255, 255)
  
  djui_hud_render_texture(nasuBG, djui_hud_get_screen_width()/2 - nasuBG.width/2, djui_hud_get_screen_height()/2 - nasuBG.height/2, 1, 1)
  
  --red creature
  n.pos.x = n.pos.x + n.vel.x
  n.pos.y = n.pos.y + n.vel.y
  
  djui_hud_render_texture_tile(n.tex, n.pos.x - (n.dir*4), n.pos.y - 16, n.dir, 1, n.anim.x*16 - 16, n.anim.y*16 - 16, 16, 16)
  
  --eggplant
  ep.pos.y = ep.pos.y + ep.vel
  
  djui_hud_render_texture_tile(ep.tex, ep.pos.x + 4, ep.pos.y, 1, 1, 32, 0, 8, 8)
  
  egg_plant_update()
  
  scoreText = "SCORE "..string.format("%05d", tostring(NASU_SCORE))
  
  highScoreText = "HISCORE "..string.format("%05d", tostring(NASU_HIGHSCORE))
  
  djui_hud_print_text(scoreText, NASU_RIGHT_WALL - djui_hud_measure_text("SCORE 00000")/2 + 8, NASU_FLOOR_HEIGHT + 8, 0.45)
  djui_hud_print_text(highScoreText, NASU_LEFT_WALL, NASU_FLOOR_HEIGHT + 8, 0.45)
  
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, render_nasu)
