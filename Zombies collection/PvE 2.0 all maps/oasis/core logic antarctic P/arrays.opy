#Global variables

globalvar roundnumber 0
globalvar numberOfZombies 1
globalvar Difficulty 3
globalvar powerconnected 13
globalvar Died 18
globalvar Vectordoorpositions 21
globalvar doors 26
globalvar impulseDoorArray 27
globalvar telespot 28
globalvar lesszomb 29
globalvar walljumpers 30
globalvar dispencerposition 31
globalvar zombspeed 32
globalvar zombstrafe 33
globalvar zombjump 34
globalvar experiencesystem 35
globalvar hero 36
globalvar idlebots 37
globalvar dispencerplaced 38
globalvar trapeffect 41
globalvar start 42
globalvar buyheros 43
globalvar buyperks 44
globalvar doorradius 46
globalvar mysterylocations 47
globalvar rngbox 48
globalvar boxcounter 49
globalvar rngbox2 50
globalvar boxcounter2 51
globalvar Mysterylocations2 52
globalvar omnicspawn 53
globalvar bossSpawn 54
globalvar bot1spawn 55
globalvar bot2spawn 56
globalvar challengewave 58
globalvar chwaveinterval 59
globalvar setspawn 60
globalvar aprilquotes 61
globalvar aprilrng 62
globalvar spawntype 63
globalvar botspawnzone 64
globalvar Beameffectdoors 65
globalvar Bosssequencer 66
globalvar dooreffectsequencer 67
globalvar appenddoorsequencer 68
globalvar startlines 70
globalvar heroradius 71
globalvar diedradius 72
globalvar tipstrings 73
globalvar bossbuypositions 74
globalvar herobuyrandomized 75
globalvar perkbuyrandomized 76
globalvar outofpsawn 77
globalvar romanN 78
globalvar romanNcounter 79
globalvar teleportercolor 80
globalvar teleporterwait 81
globalvar forindex 82
globalvar forindex2 83
globalvar diedphrase 84
globalvar diedtext 85


#Player variables

playervar points 0
playervar magazines 3
playervar doublemag 4
playervar sprintburstperk 9
playervar healthmax 10
playervar damagevariable 11
playervar healvariable 12
playervar InfoUI 13
playervar InfoCooldown 14
playervar botTarget 16
playervar HideHints 17
playervar XPlevel 23
playervar Jugg 26
playervar singlelives 27
playervar Packapunch 28
playervar Maniac 30
playervar revived 31
playervar revivebought 32
playervar UI 33
playervar idlebot 36
playervar healovertime 38
playervar xp 39
playervar Movement 40
playervar Head_HP 41
playervar Part 42
playervar Part2 43
playervar Speed 44
playervar doorimpulse 45
playervar dispencereffect 46
playervar xparray 47
playervar herohp 49
playervar currentheroxp 51
playervar doormessage 52
playervar currentdoor 53
playervar Major_Attacks 55
playervar currentdoorIndex 56
playervar do 57
playervar doorresponse 58
playervar heroswap 59
playervar currentswap 60
playervar perkinfo 61
playervar Perkui 62
playervar currentmagazines 63
playervar currentultcharge 64
playervar ultcharge 65
playervar heroiconswap 66
playervar abilitycooldown 67
playervar followerbuy 68


#Subroutine names

subroutine herobuy1250 0
subroutine herobuy1750 2
subroutine doorimpulse 3
subroutine wavespawn 4
subroutine followerattack1 5
subroutine followerattack2 6
subroutine perkbuyanimation 7
subroutine followerbuy 8
subroutine PaPsound 9


rule "arrays":
    bossbuypositions = [vect(-75.219, -159.958, 66.504), vect(269.763, 40.235, 160.02), vect(284.31, -12.295, -220.941)]
    mysterylocations = [vect(-75.893, -154.067, 59.979), vect(-108.742, -159.9, 54.728), vect(-57.933, -150.045, 80.982), vect(-41.631, -160.529, 60.089), vect(269.82, 39.78, 162.37), vect(242.94, 43.64, 167.18), vect(239.35, 47.71, 146.57), vect(237.69, 42.2, 141.79), vect(248.18, -8.97, -205.91), vect(316.02, -13.65, -211.45), vect(294.06, -13, -213.35), vect(301.48, -15, -242.3)]
    Mysterylocations2 = [vect(-89.795, -152.045, 60.109), vect(-91.901, -150.893, 136.878), vect(-47.564, -159.045, 48.031), vect(-59.178, -154.045, 83.014), vect(316.2, 42.75, 192.14), vect(253.6, 40.7, 152.92), vect(284.95, 40.71, 152.43), vect(224.79, 43.69, 144.07), vect(238.105, -10.411, -243.114), vect(259.8, -14.37, -199.45), vect(305.54, -15, -234.41), vect(273.98, -13, -213.67)]
    #maybe set global.roundnumber (the last index) to be a custom string with round
    romanN = ["0", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", roundnumber, "0", "00110001", "00110010", "00110011", "00110100", "00110101", "00110110", "00110111", "00111000", "00111001", roundnumber]
    tipstrings = ["melee to consume less ammo!", "reload only when your clip is empty to conserve ammo", "you lose your hero if not revived at end of the round", "after a playthrough, you keep all the heroes you bought", "beating the boss' is well worth the points if you are up to the challenge", "its cheaper to use the mystery box than buying a new hero", "followers stay with you till you're downed", "some custom items can be used by communicating \"i need healing)", "there is 3 zones to play in, each with its own boss", "perks and hero locations rotate randomly each playthrough on hard", "points depend on who gets the last hit!", "Every team can benefit from a good healer", "A tank is valuable for their durability to the team", "pack a punch gives new abilities!"]
    #Door array and radius list door 73 and 81 are the same spot
    doorradius = [6, 6, 6, 3, 3, 3, 3, 3, 3, 3, 3, 3, 6, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 7, 3, 3, 3, 3, 3, 3, 3, 3, 8, 7, 5, 8, 7, 5, 7, 7, 3, 3, 3, 3, 3, 3, 6, 9, 3, 8, 7, 5, 8, 7, 5, 7, 3, 3, 3, 3, 3, 8, 7, 5, 8, 7]
    #zone 1 = False, 23 zone 2 = 24, 41 zone 1a, 42, 65 zone 3 = 66, 84 tele = 85, 87
    Vectordoorpositions = [vect(-68.135, -153.41, -5.642), vect(-83.89, -153, -6.45), vect(-100.77, -153, -7.37), vect(-59.15, -150.49, 33.56), vect(-63.92, -150.44, 41.86), vect(-68.2, -154.38, 29.63), vect(-59.04, -154.46, 43.96), vect(-52.88, -154.5, 60.16), vect(-59.08, -154.44, 76.43), vect(-48.19, -160.95, 59.85), vect(-57.96, -160.5, 70.33), vect(-58.3, -160.44, 49.9), vect(-88.7, -160.7, 59.81), vect(-119.7, -152.4, 77.3), vect(-119.56, -152.4, 42.12), vect(-65.92, -154.46, 36.82), vect(-66.11, -154.46, 83.19), vect(-109.69, -152.48, 49.76), vect(-109.78, -152.48, 70.2), vect(-68.02, -154.38, 90.44), vect(-59.18, -150.49, 86.36), vect(-101.44, -157.46, 71.78), vect(-101.24, -157.46, 48.02), vect(-64.05, -150.46, 77.89), vect(319.43, 44.23, 154.09), vect(304.72, 42.24, 143.91), vect(281.4, 40.75, 144.89), vect(258.62, 40.75, 145.07), vect(235.57, 42.23, 144.25), vect(220.9, 44.17, 153.79), vect(311.46, 45.7, 173.08), vect(304.33, 45.7, 160.63), vect(308.93, 44.75, 186.83), vect(300.58, 44.69, 192.11), vect(239.05, 44.75, 192), vect(230.97, 44.75, 187.05), vect(228.66, 45.69, 173.31), vect(235.43, 45.69, 160.63), vect(304.93, 39.53, 181.68), vect(310.3, 45.69, 157.84), vect(235.03, 39.52, 181.87), vect(230.415, 46.104, 157.599), vect(-80.426, -153.714, 19.054), vect(-108.405, -155.872, 21.356), vect(-98.156, -155.167, 26.874), vect(-85.924, -153.984, 25.157), vect(-88.321, -159.371, 45.817), vect(-82.398, -154.231, 36.815), vect(-59.321, -151.391, 11.086), vect(-90.131, -153.936, 1.155), vect(-113.938, -150.884, 34.075), vect(289.085, 43.526, 168.905), vect(283.489, 43.332, 184.374), vect(281.421, 42.106, 199.315), vect(251.812, 43.192, 167.549), vect(254.773, 42.812, 183.097), vect(261.093, 42.57, 198.477), vect(270.104, 45.804, 181.986), vect(-87.799, -157.966, 74.058), vect(-81.755, -152.615, 83.508), vect(-99.049, -153.11, 91.801), vect(-83.279, -152.464, 101.417), vect(-68.396, -149.548, 126.573), vect(-83.058, -152.798, 127.52), vect(-100.577, -152.63, 125.97), vect(-106.246, -153.938, 97.092), vect(240.721, -9.364, -246.689), vect(243.472, -9.479, -224.549), vect(237.052, -7.76, -212.231), vect(271.212, -11.479, -229.939), vect(267.401, -13.167, -236.919), vect(263.422, -11.533, -249.64), vect(304.823, -11.372, -260.662), vect(284.365, -9.352, -254.631), vect(304.468, -10.965, -249.969), vect(264.181, -10.462, -260.443), vect(296.606, -12.026, -229.938), vect(300.944, -13.156, -238.779), vect(325.226, -9.724, -225.309), vect(330.605, -8.418, -212.63), vect(327.706, -9.479, -246.26), vect(284.365, -9.352, -254.631), vect(272.807, -12.803, -197.215), vect(273.812, -11.736, -204.956), vect(294.346, -11.468, -204.828), vect(-102.32, -152.5, 59.94), vect(270.024, 42.206, 198.262), vect(284.564, -10.531, -260.515)]
    buyheros = [vect(-75.015, -153.892, 11.314), vect(-64.108, -150.077, -12.435), vect(-77.968, -151.045, -19.799), vect(-90.394, -154.045, 22.857), vect(-109.583, -155.03, 18.466), vect(-111.055, -152.024, 40.829), vect(-73.026, -160.045, 49.38), vect(-101.916, -157.12, 84.941), vect(328.18, 44.09, 154.95), vect(307.83, 45.7, 166.88), vect(286.82, 41.01, 200.66), vect(262.04, 37.69, 178.93), vect(254.35, 40.7, 153.04), vect(222.8, 43.69, 149.27), vect(282.57, 40.69, 137.98), vect(317.71, 43.69, 149.2), vect(230.29, -7.84, -236.56), vect(261.54, -15, -240.03), vect(284.28, -11.02, -265.11), vect(313, -13.88, -250.27), vect(334.77, -11.88, -224.67), vect(307.37, -14.24, -198.17), vect(276.42, -14, -195.17), vect(297.94, -14, -209.91)]
    #set to: if difficulty is hard, then randomize
    herobuyrandomized = random.shuffle(buyheros)
    buyperks = [vect(-82.374, -159.2, 59.915), vect(-43.093, -159.045, 47.648), vect(-109.726, -154.997, 121.286), vect(304.56, 44.96, 194.94), vect(263.76, 43.69, 178.31), vect(285.83, 40.7, 158.77), vect(183.37, 45.46, 186.8), vect(293.47, -9, -248.13), vect(273.92, -9, -248.13), vect(270.41, -14, -209.94)]
    #need to set easy and normal difficulties to not randomize locations for buyables - hard will randomize (except pack a punch)
    perkbuyrandomized = random.shuffle(buyperks)
    diedphrase = ["Got rekt", "met their end", "took a dirt nap!", "got owned", "reflexes were lacking", "'git gud' skills were insufficient", "clutch' performance was... underwhelming", "skill issue' was tragically evident", "luck seemed to have run out", "demonstrated a profound lack of spatial awareness.", "experienced a severe case of target fixation"]
    diedtext = ["Got outplayed", "Needs a hug", "Not so MLG", "I'm THROWING"]
    #does this even need an array?
    heroradius = [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2]
    #add 1 to the number (accidently started at 1)
    Beameffectdoors = [vect(-73.088, -150.853, -6.025), vect(-63.827, -148.143, -4.766), vect(-63.827, -151.295, -4.766), vect(-72.485, -148.022, -3.371), vect(-79.498, -154.237, -6.587), vect(-88.809, -151.12, -7.165), vect(-88.809, -154.703, -7.165), vect(-79.501, -151.158, -7.338), vect(-95.811, -154.621, -6.493), vect(-105.837, -148.696, -6.963), vect(-105.265, -153.624, -7.482), vect(-95.589, -148.426, -6.795), vect(-57.245, -150.492, 33.947), vect(-60.593, -147.465, 33.883), vect(-60.704, -150.305, 33.938), vect(-57.496, -147.369, 34.038), vect(-62.976, -150.41, 43.319), vect(-65.395, -147.186, 40.737), vect(-65.365, -150.364, 40.845), vect(-62.896, -147.234, 43.096), vect(-69.985, -154.376, 29.778), vect(-65.869, -150.714, 29.538), vect(-65.869, -154.44, 29.538), vect(-70.279, -150.518, 29.681), vect(-56.663, -154.371, 43.867), vect(-60.647, -151.191, 43.972), vect(-60.647, -154.65, 43.972), vect(-56.793, -151.493, 43.503), vect(-52.379, -154.53, 57.994), vect(-52.564, -150.607, 62.277), vect(-52.564, -154.501, 62.277), vect(-52.382, -150.417, 57.939), vect(-57.325, -154.328, 76.487), vect(-60.587, -151.134, 76.318), vect(-60.587, -154.286, 76.318), vect(-57.364, -151.254, 76.264), vect(-49.181, -160.778, 56.615), vect(-49.23, -156.135, 62.891), vect(-49.23, -161.139, 62.891), vect(-49.19, -155.973, 57.652), vect(-56.462, -160.651, 70.045), vect(-59.154, -157.047, 70.198), vect(-59.516, -160.535, 70.103), vect(-56.314, -157.444, 69.898), vect(-59.692, -160.349, 50.073), vect(-56.384, -157.105, 50.055), vect(-56.384, -160.363, 50.055), vect(-59.728, -157.558, 50.054), vect(-89.271, -160.303, 64.397), vect(-87.625, -155.285, 56.467), vect(-87.625, -160.14, 56.467), vect(-88.272, -154.825, 63.668), vect(-118.394, -152.22, 76.038), vect(-119.649, -149.413, 80.533), vect(-119.649, -152.396, 80.533), vect(-118.443, -149.767, 75.004), vect(-119.24, -151.983, 39.219), vect(-118.12, -149.475, 44.35), vect(-118.266, -152.218, 44.339), vect(-119.168, -149.468, 39.418), vect(-65.799, -154.211, 35.069), vect(-66.094, -151.322, 38.78), vect(-66.094, -154.425, 38.78), vect(-66.018, -151.312, 35.273), vect(-65.727, -154.378, 85.048), vect(-65.484, -151.316, 81.068), vect(-65.484, -154.349, 81.068), vect(-65.955, -151.335, 84.901), vect(-112.648, -152.165, 49.815), vect(-106.727, -148.521, 49.921), vect(-106.727, -152.443, 49.921), vect(-113.218, -148.271, 49.977), vect(-106.052, -152.479, 70.394), vect(-112.862, -147.447, 70.126), vect(-112.862, -152.323, 70.126), vect(-106.302, -148.711, 69.963), vect(-65.853, -154.266, 90.272), vect(-70.3, -150.578, 90.314), vect(-70.3, -154.309, 90.314), vect(-65.533, -151.004, 90.226), vect(-60.798, -150.419, 85.997), vect(-57.351, -147.411, 86.261), vect(-57.351, -150.323, 86.261), vect(-60.809, -147.431, 86.179), vect(-102.776, -157.242, 71.573), vect(-99.272, -154.391, 71.657), vect(-99.272, -157.587, 71.657), vect(-102.565, -154.236, 71.398), vect(-103.044, -157.406, 48.424), vect(-99.291, -154.163, 48.459), vect(-99.291, -157.747, 48.459), vect(-103.164, -154.27, 48.768), vect(-62.965, -150.387, 76.638), vect(-65.577, -147.174, 79.253), vect(-65.577, -150.588, 79.253), vect(-62.812, -147.364, 76.674), vect(318.77, 44.089, 155.449), vect(319.97, 47.182, 152.436), vect(319.97, 44.087, 152.436), vect(318.696, 47.594, 155.546), vect(303.941, 42.66, 145.797), vect(305.354, 45.08, 142.346), vect(305.354, 42.185, 142.346), vect(304.011, 44.997, 145.619), vect(283.482, 41.037, 145.008), vect(279.709, 43.808, 145.068), vect(279.709, 40.624, 145.068), vect(283.408, 43.893, 145.077), vect(256.811, 40.981, 145.144), vect(260.091, 44.005, 145.202), vect(260.091, 40.973, 145.202), vect(256.577, 43.834, 145.071), vect(236.149, 42.238, 146.019), vect(234.71, 45.183, 142.324), vect(234.71, 41.986, 142.324), vect(236.097, 45.32, 145.469), vect(221.366, 44.346, 155.733), vect(219.972, 47.237, 152.535), vect(219.972, 44.446, 152.535), vect(221.285, 47.375, 155.356), vect(310.49, 45.933, 174.655), vect(311.944, 48.667, 171.504), vect(311.944, 45.479, 171.504), vect(310.515, 48.776, 174.734), vect(302.853, 46.271, 159.993), vect(306.38, 48.898, 160.793), vect(306.38, 45.746, 160.793), vect(303.173, 48.884, 159.571), vect(308.914, 44.874, 188.856), vect(309.17, 47.619, 185.423), vect(309.17, 44.833, 185.423), vect(309.068, 47.926, 188.962), vect(300.766, 44.839, 193.844), vect(301.092, 47.986, 190.175), vect(301.035, 44.871, 190.271), vect(300.985, 47.74, 193.53), vect(239.198, 44.712, 193.624), vect(239.049, 47.704, 189.822), vect(238.982, 44.781, 190.182), vect(239.078, 47.865, 193.742), vect(230.918, 45.002, 188.596), vect(231.237, 47.641, 185.148), vect(231.237, 44.795, 185.148), vect(230.927, 47.671, 188.585), vect(228.082, 46.052, 171.638), vect(229.257, 48.97, 174.763), vect(229.257, 45.796, 174.763), vect(227.983, 49.021, 171.455), vect(233.743, 45.832, 160.699), vect(236.942, 48.656, 159.476), vect(236.942, 45.614, 159.476), vect(233.785, 48.718, 160.653), vect(305.219, 40.076, 177.537), vect(304.537, 43.452, 186.384), vect(304.537, 40.06, 186.384), vect(303.639, 43.452, 176.536), vect(312.119, 45.898, 154.129), vect(307.908, 49.513, 161.629), vect(307.993, 46.143, 161.383), vect(312.013, 49.101, 154.117), vect(235.878, 39.463, 185.919), vect(236.146, 43.26, 177.266), vect(236.146, 39.485, 177.266), vect(235.865, 43.005, 186.078), vect(232.202, 45.793, 161.824), vect(229.461, 50.064, 154.25), vect(229.461, 45.734, 154.25), vect(232.726, 50.126, 161.283), vect(-78.521, -153.794, 23.488), vect(-81.686, -150.482, 13.91), vect(-81.686, -154.207, 13.91), vect(-78.249, -149.718, 23.458), vect(-106.77, -154.207, 26.605), vect(-106.893, -150.11, 16.618), vect(-106.893, -155.042, 16.618), vect(-107.362, -149.084, 27.599), vect(-105.105, -154.701, 27.482), vect(-91.225, -150.445, 26.462), vect(-91.653, -154.843, 27.153), vect(-104.595, -150.216, 28.23), vect(-83.534, -154.137, 25.964), vect(-89.67, -149.752, 26.437), vect(-89.67, -154.346, 26.437), vect(-83.929, -150.464, 26.279), vect(-88.479, -154.336, 41.935), vect(-89.783, -159.085, 49.471), vect(-88.944, -153.861, 48.999), vect(-88.231, -159.339, 42.651), vect(-82.109, -154.171, 39.502), vect(-81.734, -151.259, 33.798), vect(-81.734, -154.341, 33.798), vect(-81.842, -151.353, 39.489), vect(-55.458, -153.37, 11.17), vect(-62.439, -150.548, 10.779), vect(-62.439, -153.41, 10.779), vect(-55.515, -150.347, 11.229), vect(-88.833, -155.365, 4.708), vect(-90.233, -151.73, -2.408), vect(-90.233, -155.321, -2.408), vect(-89.578, -151.196, 3.979), vect(-111.066, -152.115, 32.607), vect(-117.909, -149.143, 36.667), vect(-117.909, -152.415, 36.667), vect(-110.692, -147.302, 32.578), vect(297.82, 45.041, 170.156), vect(288.967, 44.784, 161.501), vect(298.181, 45.704, 170.811), vect(288.834, 45.034, 174.41), vect(282.556, 41.252, 190.333), vect(285.799, 45.495, 177.556), vect(287.267, 40.446, 177.163), vect(280.403, 46.403, 190.382), vect(281.05, 41.288, 202.168), vect(279.188, 46.14, 194.684), vect(279.188, 42.899, 194.684), vect(281.023, 44.832, 202.868), vect(242.009, 46.479, 169.8), vect(251.408, 46.08, 161.734), vect(242.089, 47.104, 170.472), vect(251.766, 45.238, 174.647), vect(253.156, 40.422, 177.081), vect(259.614, 46.703, 190.677), vect(260.309, 42.205, 190.02), vect(253.341, 44.803, 178.024), vect(260.643, 46.074, 194.312), vect(258.651, 41.49, 202.41), vect(258.008, 45.414, 203.312), vect(260.038, 43.091, 194.771), vect(265.771, 47.592, 182.207), vect(274.523, 43.873, 181.819), vect(274.392, 47.574, 181.897), vect(265.373, 43.487, 181.354), vect(-88.476, -158.497, 70.859), vect(-88.066, -155.052, 77.914), vect(-88.066, -159.274, 77.914), vect(-88.725, -154.884, 70.664), vect(-81.799, -154.278, 80.547), vect(-83.029, -151.032, 86.653), vect(-83.029, -153.936, 86.653), vect(-82.479, -151.443, 80.042), vect(-104.238, -154.681, 92.161), vect(-91.499, -151.172, 92.909), vect(-91.559, -154.657, 92.633), vect(-107.366, -150.851, 92.729), vect(-83.214, -154.119, 96.558), vect(-83.645, -150.492, 106.693), vect(-83.645, -154.561, 106.693), vect(-82.936, -150.706, 96.837), vect(-64.028, -151.314, 127.214), vect(-73.411, -147.984, 126.034), vect(-73.411, -151.033, 126.034), vect(-63.258, -146.605, 126.256), vect(-79.482, -154.225, 126.745), vect(-88.68, -149.832, 126.41), vect(-88.68, -154.136, 126.41), vect(-79.202, -150.741, 126.623), vect(-95.613, -149.432, 127.771), vect(-105.972, -153.051, 126.922), vect(-105.972, -149.008, 126.922), vect(-95.418, -154.222, 126.978), vect(-106.988, -155.104, 93.289), vect(-106.35, -151.676, 103.051), vect(-106.35, -155.068, 103.051), vect(-107.563, -152.218, 93.568), vect(239.009, -11.663, -250.343), vect(242.752, -7.841, -243.207), vect(242.752, -11.403, -243.207), vect(239.191, -7.52, -250.269), vect(245.644, -6.442, -230.744), vect(241.295, -11.681, -219.03), vect(240.854, -8.572, -218.097), vect(244.134, -10.386, -231.273), vect(239.719, -6.772, -214.816), vect(238.306, -9.207, -209.643), vect(238.306, -7.235, -209.643), vect(239.706, -9.113, -215.032), vect(270.938, -10.761, -233.089), vect(270.556, -13.854, -226.851), vect(270.556, -10.582, -226.851), vect(270.452, -13.999, -233.169), vect(264.629, -11.534, -237.516), vect(269.336, -14.72, -237.523), vect(269.336, -11.567, -237.523), vect(264.812, -14.83, -237.634), vect(264, -10.02, -252.01), vect(264.01, -13.02, -248.01), vect(264, -13.02, -252.01), vect(264.01, -10.02, -248.01), vect(303.69, -9.35, -258.98), vect(303.78, -13.35, -262.98), vect(303.69, -13.35, -258.98), vect(303.78, -9.35, -262.98), vect(287.98, -7.02, -254.36), vect(279.99, -11.02, -254.73), vect(287.98, -11.02, -254.36), vect(279.99, -7.02, -254.73), vect(304.22, -9.97, -248.03), vect(304.17, -12.97, -252.03), vect(304.22, -12.97, -248.03), vect(304.17, -9.97, -252.03), vect(264.48, -9.02, -263.06), vect(264.41, -13.02, -259.06), vect(264.48, -13.02, -263.06), vect(264.41, -9.02, -259.06), vect(297.64, -10.2, -226.99), vect(297.83, -14.2, -232.98), vect(297.64, -14.2, -226.99), vect(297.83, -10.2, -232.98), vect(298.9, -12, -237.47), vect(302.9, -15, -237.46), vect(298.9, -15, -237.47), vect(302.9, -12, -237.46), vect(327.07, -7.24, -216.85), vect(322.74, -12.24, -232.26), vect(327.07, -12.24, -216.85), vect(322.74, -7.24, -232.26), vect(330.13, -7.13, -209.87), vect(328.85, -10.13, -215.73), vect(330.13, -10.13, -209.87), vect(328.85, -7.13, -215.73), vect(325.82, -7.91, -242.87), vect(329.45, -11.91, -250), vect(325.82, -11.91, -242.87), vect(329.45, -7.91, -250), vect(282.556, 41.252, 190.333), vect(285.799, 45.495, 177.556), vect(287.267, 40.446, 177.163), vect(280.403, 46.403, 190.382), vect(282.556, 41.252, 190.333), vect(285.799, 45.495, 177.556), vect(287.267, 40.446, 177.163), vect(280.403, 46.403, 190.382), vect(282.556, 41.252, 190.333), vect(285.799, 45.495, 177.556), vect(287.267, 40.446, 177.163), vect(280.403, 46.403, 190.382), vect(282.556, 41.252, 190.333), vect(285.799, 45.495, 177.556), vect(287.267, 40.446, 177.163), vect(280.403, 46.403, 190.382), vect(282.556, 41.252, 190.333), vect(285.799, 45.495, 177.556), vect(287.267, 40.446, 177.163), vect(280.403, 46.403, 190.382)]
    #does this even need an array?
    diedradius = [4, 4, 4, 4]


