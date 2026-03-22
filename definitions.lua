--Levels
_G.LEVEL_MADO = level_register("level_LEVEL_MADO_entry", COURSE_NONE, "Madotsuki's Room", "Mado room", 28000, 0x00, 0x28, 0x28)
_G.LVL_PONIKO = level_register("level_LEVEL_PONIKO_entry", COURSE_NONE, "Poniko's House", "poniko", 28000, 0x00, 0x28, 0x28)

--Skyboxes
madosky = get_texture_info("madosky1")
madosky2 = get_texture_info("madosky2")
madosky3 = get_texture_info("madosky3")
madosky4 = get_texture_info("madosky4")
uboasky = get_texture_info("bg_uboa")

madobgm = audio_stream_load("madobgm.ogg")
ponikobgm_on = audio_stream_load("ponikobgmOn.ogg")
ponikobgm_off = audio_stream_load("ponikobgmOff.ogg")
whitedesert = audio_stream_load("whitedesert.ogg")

madoaztec = audio_stream_load("aztecravemonkey.ogg")
tv_eye = get_texture_info("tv_eye")
tv_normal = get_texture_info("tv_normal")

madokalimba = audio_stream_load("KALIMBA.ogg")
KALIMBA_IMAGE = get_texture_info("KALIMBA")
tv_kalimba = get_texture_info("tv_KALIMBA")
tv_on = audio_sample_load("tv_on.ogg")
tv_off = audio_sample_load("tv_off.ogg")

madonasu = audio_stream_load("nasubgm.ogg")
tv_nasu = get_texture_info("tv_nasu")
nasustep = audio_sample_load("nasustep.ogg")
nasuouch = audio_sample_load("nasuouch.ogg")
nasuacquire = audio_sample_load("nasuacquire.ogg")
nasujump = audio_sample_load("nasujump.ogg")

madodream = audio_stream_load("madodream.ogg")
madoenter = audio_sample_load("madoenter.ogg")


ponikoenter = audio_sample_load("ponikoenter.ogg")

