#Global variables

globalvar forindex 40
globalvar Beameffectdoors 65
globalvar AllPos 83
globalvar AllDir 84
globalvar firstpos 85
globalvar secondpos 86
globalvar firstpoint2 87
globalvar secondpoint2 88
globalvar second 89
globalvar z 90
globalvar Wall_ID 91
globalvar is_Grounded 93
globalvar g_beamType 94


#Player variables

playervar filterpos 69
playervar lastsavedpos 70
playervar closestbodypos 71
playervar fullbodypos 72
playervar prevpos_intersection 73
playervar active_wall 74
playervar closestwall 75
playervar x_ 76
playervar intersection_length 77
playervar thickness 78


rule "Initial Global":
    AllPos = []
    AllDir = []
    firstpos = []
    secondpos = []
    firstpoint2 = []
    secondpoint2 = []
    second = []
    z = []
    Wall_ID = []
    g_beamType = []


rule "Initial Player":
    @Event eachPlayer
    
    eventPlayer.filterpos = false
    eventPlayer.lastsavedpos = false
    eventPlayer.closestbodypos = false
    eventPlayer.fullbodypos = false
    eventPlayer.prevpos_intersection = false
    eventPlayer.active_wall = []
    eventPlayer.closestwall = []


rule "Collision Logic":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.hasSpawned() == true
    
    eventPlayer.lastsavedpos = (eventPlayer.getEyePosition() + eventPlayer.getPosition()) / 2
    wait(getAverageServerLoad() / 255 * (0.34 - 0.032) + 0.032)
    eventPlayer.closestwall = [player for player, i in AllPos if distance(AllPos[i], eventPlayer) <= distance(AllPos[i], firstpos[i]) or eventPlayer.active_wall[i] == 1 or dotProduct(directionTowards(player, eventPlayer.lastsavedpos), AllDir[i]) > 0 != (dotProduct(directionTowards(player, eventPlayer), AllDir[i]) > 0)]
    for eventPlayer.x_ in range(len(eventPlayer.closestwall)):
        z = AllPos.index(eventPlayer.closestwall[eventPlayer.x_])
        if Wall_ID[z] == 1 or Wall_ID[z] == 3 or Wall_ID[z] == 5:
            if firstpos[z].y >= eventPlayer.getPosition().y and firstpos[z].y <= (eventPlayer.getEyePosition() + vect([], 0.2, [])).y:
                eventPlayer.closestbodypos = firstpos[z]
            elif secondpos[z].y >= eventPlayer.getPosition().y and secondpos[z].y <= (eventPlayer.getEyePosition() + vect([], 0.2, [])).y:
                eventPlayer.closestbodypos = secondpos[z]
            else:
                eventPlayer.closestbodypos = eventPlayer.getPosition()
            eventPlayer.fullbodypos = vect(eventPlayer.getEyePosition().x, eventPlayer.closestbodypos.y, eventPlayer.getEyePosition().z)
            eventPlayer.filterpos = eventPlayer.fullbodypos + ((AllDir[z] * (dotProduct(AllPos[z] - eventPlayer.fullbodypos, AllDir[z]))) / dotProduct(AllDir[z], AllDir[z]))
            if Wall_ID[z] == 1 or Wall_ID[z] == 3:
                if dotProduct(directionTowards(AllPos[z], eventPlayer.lastsavedpos), AllDir[z]) > 0 != (dotProduct(directionTowards(AllPos[z], eventPlayer.fullbodypos), AllDir[z]) > 0):
                    eventPlayer.intersection_length = (dotProduct(AllPos[z] - eventPlayer.fullbodypos, AllDir[z])) / dotProduct(directionTowards(eventPlayer.lastsavedpos, eventPlayer.fullbodypos), AllDir[z])
                    eventPlayer.prevpos_intersection = eventPlayer.fullbodypos + directionTowards(eventPlayer.lastsavedpos, eventPlayer.fullbodypos) * vect(1, [], 1) * eventPlayer.intersection_length
                    if dotProduct(directionTowards(firstpos[z], vect(secondpos[z].x, firstpos[z].y, secondpos[z].z)), directionTowards(firstpos[z], eventPlayer.prevpos_intersection)) >= 0 and dotProduct(directionTowards(firstpos[z], vect(firstpos[z].x, secondpos[z].y, firstpos[z].z)), directionTowards(firstpos[z], eventPlayer.prevpos_intersection)) >= 0 and dotProduct(directionTowards(secondpos[z], vect(secondpos[z].x, firstpos[z].y, secondpos[z].z)), directionTowards(secondpos[z], eventPlayer.prevpos_intersection)) >= 0 and dotProduct(directionTowards(secondpos[z], vect(firstpos[z].x, secondpos[z].y, firstpos[z].z)), directionTowards(secondpos[z], eventPlayer.prevpos_intersection)) >= 0:
                        eventPlayer.cancelPrimaryAction()
                        eventPlayer.teleport(eventPlayer.prevpos_intersection + directionTowards(eventPlayer.prevpos_intersection, eventPlayer.lastsavedpos) * vect(1, [], 1) * 2)
            eventPlayer.thickness = 0
            if Wall_ID[z] == 5:
                eventPlayer.thickness = 8
            else:
                eventPlayer.thickness = 4
            if distance(eventPlayer.fullbodypos, eventPlayer.filterpos) <= eventPlayer.thickness and dotProduct(directionTowards(firstpos[z], vect(secondpos[z].x, firstpos[z].y, secondpos[z].z)), directionTowards(firstpos[z], eventPlayer.filterpos)) >= 0 and dotProduct(directionTowards(firstpos[z], vect(firstpos[z].x, secondpos[z].y, firstpos[z].z)), directionTowards(firstpos[z], eventPlayer.filterpos)) >= 0 and dotProduct(directionTowards(secondpos[z], vect(secondpos[z].x, firstpos[z].y, secondpos[z].z)), directionTowards(secondpos[z], eventPlayer.filterpos)) >= 0 and dotProduct(directionTowards(secondpos[z], vect(firstpos[z].x, secondpos[z].y, firstpos[z].z)), directionTowards(secondpos[z], eventPlayer.filterpos)) >= 0:
                if eventPlayer.active_wall[z] == false:
                    eventPlayer.active_wall[z] = 1
                    if (Wall_ID[z] == 1 or Wall_ID[z] == 3) and is_Grounded == false:
                        eventPlayer.setGravity(100)
                    elif Wall_ID[z] == 5:
                        eventPlayer.disableEnvironmentCollision(false)
                if Wall_ID[z] == 1:
                    eventPlayer.applyImpulse(directionTowards(eventPlayer.filterpos, eventPlayer.fullbodypos) * vect(1, [], 1), 1, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
                    eventPlayer.setMoveSpeed(100 - ((dotProduct(directionTowards(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(eventPlayer.getThrottle(), eventPlayer, Transform.ROTATION)), directionTowards(eventPlayer.filterpos, eventPlayer.fullbodypos) * -1)) * 100))
                elif Wall_ID[z] == 3:
                    eventPlayer.applyImpulse(directionTowards(eventPlayer.filterpos, eventPlayer.fullbodypos), eventPlayer.getSpeed() + eventPlayer.getSpeed(), Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            else:
                eventPlayer.active_wall[z] = 0
                eventPlayer.setMoveSpeed(100)
    loop()


rule "Reset":
    @Event eachPlayer
    @Condition len([player for player in eventPlayer.active_wall if player != 0]) == 0
    
    eventPlayer.enableEnvironmentCollision()


rule "Rule 6":
    Wall_ID = []
    wait(0.032)
    #AllPos = [vect(-68.399, -142.469, -4.721), vect(-83.908, -149.871, -7.15), vect(-113.802, -141.123, -7.23), vect(-59.005, -149.03, 33.906), vect(-64.063, -149.031, 42.033), vect(-68.098, -152.506, 29.691), vect(-58.919, -153.048, 43.894), vect(-52.614, -152.334, 59.998), vect(-58.899, -152.969, 76.232), vect(-49.338, -158.052, 59.948), vect(-58, -159.006, 69.951), vect(-57.995, -159.035, 49.963), vect(-88.515, -157.096, 60.141), vect(-119.161, -137.823, 78.43), vect(-118.822, -137.515, 41.529), vect(-65.905, -153.003, 36.982), vect(-65.81, -153.032, 83.003), vect(-109.76, -146.025, 49.964), vect(-109.797, -145.8, 70.192), vect(-68.086, -152.458, 90.235), vect(-58.967, -149.007, 86.062), vect(-100.992, -155.974, 71.602), vect(-101.101, -156.074, 48.335), vect(-64.118, -149.036, 77.955), vect(319.402, 45.651, 153.953), vect(304.797, 43.696, 144.066), vect(281.467, 42.174, 144.977), vect(258.523, 42.164, 145.098), vect(235.392, 43.603, 144.061), vect(220.577, 45.627, 153.978), vect(311.228, 47.173, 173.017), vect(304.622, 47.176, 160.122), vect(309.076, 46.169, 186.934), vect(300.946, 46.21, 191.985), vect(239.112, 46.146, 191.971), vect(231.078, 46.246, 187.033), vect(228.805, 47.184, 173.04), vect(235.363, 47.169, 160.032), vect(304.819, 41.645, 181.725), vect(310.065, 61.439, 157.893), vect(235.966, 41.762, 181.722), vect(230.692, 59.558, 157.922), vect(-80.031, -148.591, 18.812), vect(-106.539, -140.923, 21.237), vect(-98.316, -141.879, 27.365), vect(-86.662, -146.147, 26.087), vect(-88.781, -148.169, 44.427), vect(-81.993, -147.304, 36.828), vect(-59, -146.521, 11.071), vect(-89.58, -146.031, 1.41), vect(-114.743, -132.932, 34.9), vect(293.212, 56.037, 165.909), vect(284.264, 57.238, 183.906), vect(284.917, 57.659, 215.064), vect(246.685, 60.198, 165.641), vect(256.809, 61.025, 184.126), vect(257.654, 53.187, 208.158), vect(269.951, 45.836, 181.572), vect(-88.548, -148.066, 75.55), vect(-82.249, -145.659, 82.982), vect(-97.979, -142.592, 92.272), vect(-83.426, -145.527, 101.313), vect(-68.31, -145.634, 126.418), vect(-84.032, -148.543, 126.459), vect(-112.964, -139.017, 125.988), vect(-106.796, -141.692, 97.956), vect(240.768, 4.635, -246.807), vect(242.603, 1.732, -225.628), vect(238.989, -7.469, -212.653), vect(270.505, -12.171, -230), vect(266.989, -13.165, -237.629), vect(263.833, -11.426, -250.002), vect(303.602, -10.829, -260.988), vect(304.211, -11.5, -250.048), vect(264.523, -10.7, -260.977), vect(297.759, -12.25, -230), vect(300.999, -13.157, -237.511), vect(324.178, 0.848, -224.63), vect(329.619, -7.576, -212.584), vect(327.949, -0.501, -246.461)]
    #AllDir = [vect(0.006, 0, -1), vect(0.059, 0, -0.998), vect(0.025, 0, -1), vect(0.001, 0, -1), vect(0.675, 0, -0.738), vect(0.015, 0, 1), vect(-0.003, 0, -1), vect(-1, 0, -0.012), vect(0.008, 0, -1), vect(-1, 0, -0.011), vect(-0.029, 0, -1), vect(0.014, 0, 1), vect(0.986, 0, 0.167), vect(-0.962, 0, -0.272), vect(-0.984, 0, 0.18), vect(-0.998, 0, -0.064), vect(-0.999, 0, 0.042), vect(-0.022, 0, 1), vect(-0.009, 0, -1), vect(-0.01, 0, -1), vect(-0.01, 0, 1), vect(-0.009, 0, 1), vect(-0.058, 0, 0.998), vect(-0.682, 0, -0.731), vect(0.917, 0, 0.399), vect(0.921, 0, 0.391), vect(-0.028, 0, -1), vect(-0.018, 0, 1), vect(0.92, 0, -0.392), vect(0.947, 0, -0.322), vect(-0.899, 0, -0.437), vect(-0.36, 0, 0.933), vect(-0.999, 0, -0.037), vect(0.999, 0, 0.035), vect(1, 0, 0.004), vect(0.999, 0, -0.037), vect(0.939, 0, -0.344), vect(-0.354, 0, -0.935), vect(-0.995, 0, -0.104), vect(-0.881, 0, -0.472), vect(0.999, 0, 0.048), vect(0.949, 0, -0.316), vect(0.949, 0, -0.315), vect(0.997, 0, -0.073), vect(-0.011, 0, -1), vect(-0.005, 0, -1), vect(0.981, 0, 0.196), vect(-0.998, 0, -0.056), vect(-0.048, 0, 0.999), vect(0.986, 0, -0.165), vect(-0.472, 0, -0.882), vect(-0.7, 0, 0.714), vect(-0.916, 0, -0.401), vect(-0.965, 0, 0.26), vect(-0.732, 0, -0.681), vect(-0.881, 0, 0.473), vect(-0.989, 0, -0.15), vect(-0.066, 0, 0.998), vect(1, 0, 0.002), vect(0.986, 0, 0.166), vect(0.05, 0, -0.999), vect(-0.999, 0, -0.042), vect(0.113, 0, -0.994), vect(0.057, 0, -0.998), vect(0.06, 0, -0.998), vect(0.998, 0, -0.057), vect(-0.891, 0, 0.454), vect(-0.969, 0, -0.247), vect(-0.985, 0, -0.17), vect(-1, 0, 0.005), vect(0.041, 0, 0.999), vect(1, 0, 0.017), vect(1, 0, -0.013), vect(-1, 0, -0.022), vect(0.999, 0, 0.052), vect(-1, 0, -0.025), vect(-0.02, 0, 1), vect(0.936, 0, -0.351), vect(0.982, 0, -0.19), vect(0.895, 0, 0.446)]
    #firstpos = [vect(-64.782, -151.5, -4.7), vect(-80.139, -154.261, -6.926), vect(-97.052, -154.891, -6.809), vect(-57.572, -150.421, 33.907), vect(-63.019, -150.42, 42.989), vect(-69.947, -154.385, 29.72), vect(-57.545, -154.458, 43.89), vect(-52.592, -154.253, 58.112), vect(-57.482, -154.417, 76.243), vect(-49.299, -160.548, 56.457), vect(-56.562, -160.373, 69.91), vect(-59.373, -160.42, 49.982), vect(-89.212, -160.419, 64.262), vect(-118.567, -152.098, 76.328), vect(-119.183, -152.4, 39.559), vect(-65.811, -154.408, 35.522), vect(-65.869, -154.452, 81.569), vect(-112.382, -152.429, 49.906), vect(-107.191, -152.47, 70.169), vect(-66.25, -154.298, 90.216), vect(-60.359, -150.42, 86.049), vect(-102.454, -157.43, 71.588), vect(-102.568, -157.441, 48.25), vect(-63.062, -150.443, 76.97), vect(318.834, 44.251, 155.257), vect(304.246, 42.349, 145.365), vect(282.872, 40.773, 144.938), vect(257.155, 40.773, 145.073), vect(235.926, 42.251, 145.315), vect(221.032, 44.202, 155.317), vect(311.844, 45.822, 171.749), vect(303.294, 45.742, 159.609), vect(309.127, 44.79, 185.561), vect(300.896, 44.776, 193.41), vect(239.107, 44.744, 193.348), vect(231.13, 44.943, 188.436), vect(229.284, 45.773, 174.345), vect(236.611, 45.773, 159.559), vect(305.225, 39.904, 177.847), vect(311.903, 45.693, 154.464), vect(235.782, 40.137, 185.574), vect(231.827, 45.729, 161.327), vect(-78.64, -154.221, 23), vect(-106.224, -155.389, 25.528), vect(-92.858, -155.191, 27.303), vect(-84.072, -154.329, 26.075), vect(-89.609, -159.373, 48.582), vect(-81.853, -154.147, 34.32), vect(-62, -153.484, 10.925), vect(-89.141, -155.5, 4.039), vect(-111.694, -152.655, 33.267), vect(288.825, 41.764, 161.606), vect(286.787, 39.977, 178.139), vect(279.72, 41.437, 195.797), vect(251.137, 42.113, 160.858), vect(253.501, 40.106, 177.957), vect(259.546, 41.684, 195.692), vect(265.902, 43.618, 181.303), vect(-88.556, -159.078, 79.691), vect(-82.693, -154.377, 85.625), vect(-92.225, -155.334, 92.561), vect(-83.244, -154.23, 97), vect(-64.623, -151.188, 126.837), vect(-80.064, -154.126, 126.684), vect(-96.232, -154.537, 126.996), vect(-106.557, -154.879, 102.114), vect(239.511, -11.354, -249.274), vect(244.101, -10.24, -231.512), vect(239.364, -9.132, -214.828), vect(270.49, -14.082, -232.74), vect(265.522, -14.691, -237.57), vect(263.81, -12.716, -248.635), vect(303.629, -12.429, -258.841), vect(304.24, -12.865, -251.353), vect(264.411, -12.429, -258.819), vect(297.828, -14.239, -232.74), vect(299.526, -14.676, -237.541), vect(326.184, -11.501, -219.274), vect(330.029, -9.691, -210.462), vect(326.661, -11.383, -243.875)]
    #secondpos = [vect(-72.015, -133.438, -4.742), vect(-87.676, -145.482, -7.374), vect(-130.552, -127.356, -7.651), vect(-60.437, -147.638, 33.904), vect(-65.108, -147.642, 41.078), vect(-66.25, -150.626, 29.663), vect(-60.293, -151.638, 43.898), vect(-52.636, -150.415, 61.884), vect(-60.317, -151.52, 76.221), vect(-49.377, -155.556, 63.44), vect(-59.437, -157.639, 69.992), vect(-56.617, -157.649, 49.943), vect(-87.817, -153.773, 56.02), vect(-119.756, -123.549, 80.532), vect(-118.46, -122.63, 43.499), vect(-65.999, -151.599, 38.441), vect(-65.75, -151.611, 84.438), vect(-107.138, -139.62, 50.022), vect(-112.403, -139.129, 70.214), vect(-69.921, -150.618, 90.254), vect(-57.574, -147.593, 86.076), vect(-99.53, -154.518, 71.616), vect(-99.635, -154.706, 48.421), vect(-65.174, -147.629, 78.941), vect(319.97, 47.052, 152.649), vect(305.349, 45.042, 142.767), vect(280.063, 43.576, 145.016), vect(259.892, 43.555, 145.123), vect(234.857, 44.955, 142.808), vect(220.121, 47.052, 152.638), vect(310.611, 48.525, 174.285), vect(305.949, 48.611, 160.634), vect(309.025, 47.548, 188.308), vect(300.996, 47.643, 190.561), vect(239.117, 47.548, 190.595), vect(231.025, 47.549, 185.629), vect(228.327, 48.594, 171.736), vect(234.116, 48.565, 160.505), vect(304.413, 43.386, 185.604), vect(308.227, 77.185, 161.323), vect(236.15, 43.386, 177.87), vect(229.557, 73.388, 154.516), vect(-81.421, -142.961, 14.625), vect(-106.854, -126.457, 16.946), vect(-103.774, -128.568, 27.426), vect(-89.252, -137.965, 26.099), vect(-87.952, -136.965, 40.273), vect(-82.132, -140.46, 39.335), vect(-56, -139.557, 11.217), vect(-90.02, -136.562, -1.219), vect(-117.792, -113.21, 36.532), vect(297.6, 70.31, 170.211), vect(281.74, 74.499, 189.673), vect(290.115, 73.882, 234.331), vect(242.232, 78.283, 170.424), vect(260.117, 81.944, 190.294), vect(255.763, 64.69, 220.624), vect(274, 48.053, 181.842), vect(-88.539, -137.055, 71.409), vect(-81.805, -136.942, 80.339), vect(-103.733, -129.85, 91.983), vect(-83.608, -136.825, 105.625), vect(-71.996, -140.081, 126), vect(-88, -142.959, 126.235), vect(-129.696, -123.496, 124.979), vect(-107.035, -128.504, 93.797), vect(242.025, 20.623, -244.34), vect(241.104, 13.704, -219.743), vect(238.614, -5.805, -210.477), vect(270.52, -10.26, -227.26), vect(268.456, -11.638, -237.689), vect(263.855, -10.135, -251.368), vect(303.574, -9.229, -263.135), vect(304.182, -10.135, -248.743), vect(264.635, -8.972, -263.135), vect(297.69, -10.26, -227.26), vect(302.472, -11.638, -237.481), vect(322.172, 13.197, -229.986), vect(329.21, -5.461, -214.705), vect(329.238, 10.382, -249.046)]
    #firstpoint2 = [vect(-64.782, -133.438, -4.7), vect(-80.139, -145.482, -6.926), vect(-97.052, -127.356, -6.809), vect(-57.572, -147.638, 33.907), vect(-63.019, -147.642, 42.989), vect(-69.947, -150.626, 29.72), vect(-57.545, -151.638, 43.89), vect(-52.592, -150.415, 58.112), vect(-57.482, -151.52, 76.243), vect(-49.299, -155.556, 56.457), vect(-56.562, -157.639, 69.91), vect(-59.373, -157.649, 49.982), vect(-89.212, -153.773, 64.262), vect(-118.567, -123.549, 76.328), vect(-119.183, -122.63, 39.559), vect(-65.811, -151.599, 35.522), vect(-65.869, -151.611, 81.569), vect(-112.382, -139.62, 49.906), vect(-107.191, -139.129, 70.169), vect(-66.25, -150.618, 90.216), vect(-60.359, -147.593, 86.049), vect(-102.454, -154.518, 71.588), vect(-102.568, -154.706, 48.25), vect(-63.062, -147.629, 76.97), vect(318.834, 47.052, 155.257), vect(304.246, 45.042, 145.365), vect(282.872, 43.576, 144.938), vect(257.155, 43.555, 145.073), vect(235.926, 44.955, 145.315), vect(221.032, 47.052, 155.317), vect(311.844, 48.525, 171.749), vect(303.294, 48.611, 159.609), vect(309.127, 47.548, 185.561), vect(300.896, 47.643, 193.41), vect(239.107, 47.548, 193.348), vect(231.13, 47.549, 188.436), vect(229.284, 48.594, 174.345), vect(236.611, 48.565, 159.559), vect(305.225, 43.386, 177.847), vect(311.903, 77.185, 154.464), vect(235.782, 43.386, 185.574), vect(231.827, 73.388, 161.327), vect(-78.64, -142.961, 23), vect(-106.224, -126.457, 25.528), vect(-92.858, -128.568, 27.303), vect(-84.072, -137.965, 26.075), vect(-89.609, -136.965, 48.582), vect(-81.853, -140.46, 34.32), vect(-62, -139.557, 10.925), vect(-89.141, -136.562, 4.039), vect(-111.694, -113.21, 33.267), vect(288.825, 70.31, 161.606), vect(286.787, 74.499, 178.139), vect(279.72, 73.882, 195.797), vect(251.137, 78.283, 160.858), vect(253.501, 81.944, 177.957), vect(259.546, 64.69, 195.692), vect(265.902, 48.053, 181.303), vect(-88.556, -137.055, 79.691), vect(-82.693, -136.942, 85.625), vect(-92.225, -129.85, 92.561), vect(-83.244, -136.825, 97), vect(-64.623, -140.081, 126.837), vect(-80.064, -142.959, 126.684), vect(-96.232, -123.496, 126.996), vect(-106.557, -128.504, 102.114), vect(239.511, 20.623, -249.274), vect(244.101, 13.704, -231.512), vect(239.364, -5.805, -214.828), vect(270.49, -10.26, -232.74), vect(265.522, -11.638, -237.57), vect(263.81, -10.135, -248.635), vect(303.629, -9.229, -258.841), vect(304.24, -10.135, -251.353), vect(264.411, -8.972, -258.819), vect(297.828, -10.26, -232.74), vect(299.526, -11.638, -237.541), vect(326.184, 13.197, -219.274), vect(330.029, -5.461, -210.462), vect(326.661, 10.382, -243.875)]
    #secondpoint2 = [vect(-72.015, -151.5, -4.742), vect(-87.676, -154.261, -7.374), vect(-130.552, -154.891, -7.651), vect(-60.437, -150.421, 33.904), vect(-65.108, -150.42, 41.078), vect(-66.25, -154.385, 29.663), vect(-60.293, -154.458, 43.898), vect(-52.636, -154.253, 61.884), vect(-60.317, -154.417, 76.221), vect(-49.377, -160.548, 63.44), vect(-59.437, -160.373, 69.992), vect(-56.617, -160.42, 49.943), vect(-87.817, -160.419, 56.02), vect(-119.756, -152.098, 80.532), vect(-118.46, -152.4, 43.499), vect(-65.999, -154.408, 38.441), vect(-65.75, -154.452, 84.438), vect(-107.138, -152.429, 50.022), vect(-112.403, -152.47, 70.214), vect(-69.921, -154.298, 90.254), vect(-57.574, -150.42, 86.076), vect(-99.53, -157.43, 71.616), vect(-99.635, -157.441, 48.421), vect(-65.174, -150.443, 78.941), vect(319.97, 44.251, 152.649), vect(305.349, 42.349, 142.767), vect(280.063, 40.773, 145.016), vect(259.892, 40.773, 145.123), vect(234.857, 42.251, 142.808), vect(220.121, 44.202, 152.638), vect(310.611, 45.822, 174.285), vect(305.949, 45.742, 160.634), vect(309.025, 44.79, 188.308), vect(300.996, 44.776, 190.561), vect(239.117, 44.744, 190.595), vect(231.025, 44.943, 185.629), vect(228.327, 45.773, 171.736), vect(234.116, 45.773, 160.505), vect(304.413, 39.904, 185.604), vect(308.227, 45.693, 161.323), vect(236.15, 40.137, 177.87), vect(229.557, 45.729, 154.516), vect(-81.421, -154.221, 14.625), vect(-106.854, -155.389, 16.946), vect(-103.774, -155.191, 27.426), vect(-89.252, -154.329, 26.099), vect(-87.952, -159.373, 40.273), vect(-82.132, -154.147, 39.335), vect(-56, -153.484, 11.217), vect(-90.02, -155.5, -1.219), vect(-117.792, -152.655, 36.532), vect(297.6, 41.764, 170.211), vect(281.74, 39.977, 189.673), vect(290.115, 41.437, 234.331), vect(242.232, 42.113, 170.424), vect(260.117, 40.106, 190.294), vect(255.763, 41.684, 220.624), vect(274, 43.618, 181.842), vect(-88.539, -159.078, 71.409), vect(-81.805, -154.377, 80.339), vect(-103.733, -155.334, 91.983), vect(-83.608, -154.23, 105.625), vect(-71.996, -151.188, 126), vect(-88, -154.126, 126.235), vect(-129.696, -154.537, 124.979), vect(-107.035, -154.879, 93.797), vect(242.025, -11.354, -244.34), vect(241.104, -10.24, -219.743), vect(238.614, -9.132, -210.477), vect(270.52, -14.082, -227.26), vect(268.456, -14.691, -237.689), vect(263.855, -12.716, -251.368), vect(303.574, -12.429, -263.135), vect(304.182, -12.865, -248.743), vect(264.635, -12.429, -263.135), vect(297.69, -14.239, -227.26), vect(302.472, -14.676, -237.481), vect(322.172, -11.501, -229.986), vect(329.21, -9.691, -214.705), vect(329.238, -11.383, -249.046)]
    #for forindex in range(80):
    #Wall_ID[forindex] = 1
    #wait()
    Wall_ID = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    #__end__()
    AllPos = vect(-3.11, 2.5, -0.27)
    firstpos = vect(-0.11, 0, -0.25)
    secondpos = vect(-6.11, 5, -0.29)
    firstpoint2 = vect(-0.11, 5, -0.25)
    secondpoint2 = vect(-6.11, 0, 0.29)
    AllDir = directionFromAngles(0, 0)
    Beameffectdoors[0] = vect(-0.11, 0, -0.25)
    Beameffectdoors[1] = vect(-6.11, 5, -0.29)
    Beameffectdoors[2] = vect(-0.11, 5, -0.25)
    Beameffectdoors[3] = vect(-6.11, 0, -0.29)


