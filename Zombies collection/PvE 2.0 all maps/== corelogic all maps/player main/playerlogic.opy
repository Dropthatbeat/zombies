rule "23 Initiate Health, Damage, and Healing Variables":
    @Event eachPlayer
    @Team 1
    #outdated rule need new variable names and more variables here for all perks
    @Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer.healthmax == false
    
    eventPlayer.healthmax = 50
    eventPlayer.damagevariable = 100
    eventPlayer.healvariable = 100


rule "55  starting hero set":
    @Event playerJoined
    
    eventPlayer.startForcingHero(Hero.WINSTON)
    


rule "56  points loss for high roller":
    @Event playerDied
    @Team 1
    @Condition eventPlayer.points >= 3000
    
    eventPlayer.points -= eventPlayer.points * 0.2
    eventPlayer.points = ceil(eventPlayer.points)


rule "57  death points loss":
    @Event playerDied
    @Team 1
    @Condition eventPlayer.points >= 1000
    
    eventPlayer.points -= 200 * eventPlayer.H
    eventPlayer.points = ceil(eventPlayer.points)


rule "58  Single player lives mechanic":
    @Event playerDied
    @Team 1
    @Condition getNumberOfPlayers(Team.1) == 1
    @Condition eventPlayer.singlelives < 3
    
    eventPlayer.resurrect()
    wait(0.05)
    eventPlayer.setStatusEffect(null, Status.KNOCKED_DOWN, 2)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 10)
    eventPlayer.singlelives = eventPlayer.singlelives + 1


rule "59 DAMAGE Melee does more damage":
    @Event playerDealtDamage
    @Team 1
    @Condition eventPlayer.isMeleeing() == true
    
    damage(victim, eventPlayer, 150)


rule "67 solo play mode effect":
    @Event playerJoined
    @Team 1
    @Condition getNumberOfPlayers(Team.1) < 2
    @Condition start == 1
    
    #might make this a perk that the player can buy, instead of just having
    wait(15)
    if not ruleCondition:
        return
    bigMessage(getAllPlayers(), "SOLO MODE: YOU NOW HAVE 3 LIVES TOTAL")


rule "switch between 2 heros (needs ultimates, followers, ammo, systems working)":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    @Condition eventPlayer.isAlive() == true
    
    if getAverageServerLoad() < 220:
        playEffect(getAllPlayers(), DynamicEffect.MOIRA_FADE_DISAPPEAR_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.removeAllHealthPools()
        if eventPlayer.currentswap == false:
            eventPlayer.swapvar = [1, 0, 0, 1, 2]
            wait()
            heroswap()
        elif eventPlayer.currentswap == 1:
            eventPlayer.swapvar = [0, 1, 3, 4, 5]
            wait()
            heroswap()
        eventPlayer.startForcingHero(eventPlayer.heroswap[eventPlayer.currentswap])
        eventPlayer.setHealth(eventPlayer.herohp[eventPlayer.swap[0]])
        eventPlayer.setAbilityCooldown(Button.ABILITY_1, eventPlayer.abilitycooldown[eventPlayer.swap[2]])
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, eventPlayer.abilitycooldown[eventPlayer.swap[3]])
        eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, eventPlayer.abilitycooldown[eventPlayer.swap[4]])
        eventPlayer.setUltCharge(eventPlayer.currentultcharge)
        wait()
        (getPlayersInSlot(eventPlayer.getSlot() + 4, Team.1)).attachTo(eventPlayer, vect(-0.5, 1.8, -0.2))
        wait(0.1)
        playEffect(getAllPlayers(), DynamicEffect.MOIRA_FADE_DISAPPEAR, Color.WHITE, eventPlayer, 1)
        wait(1)
    elif getAverageServerLoad() >= 220:
        smallMessage(getAllPlayers(), "{0} Error: {1} Not on my watch! (--anticrashsys--)".format(heroIcon(Hero.RAMATTRA), random.randint(10, 1000)))
        wait(6)


rule "18 Get out of Spawn":
    @Event eachPlayer
    @Team 1
    #need to make sure this doesnt conflict with soft restart
    @Condition eventPlayer.isInSpawnRoom() == true
    @Condition outofpsawn == 1
    
    #should be able to make this a subroutine
    wait(1)
    if setspawn == false:
        eventPlayer.teleport(vect(-63.355, -148.766, -17.141))
        botspawnzone = false
        startForcingSpawn(Team.ALL, 1)
        telespot = 101
    elif setspawn == 1:
        eventPlayer.teleport(vect(-65.701, -150.372, 136.652))
        botspawnzone = false
        startForcingSpawn(Team.ALL, 1)
        telespot = 101
    elif setspawn == 2:
        eventPlayer.teleport(vect(354.63, 46.375, 181.943))
        botspawnzone = 1
        startForcingSpawn(Team.ALL, 0)
        telespot = 102
    elif setspawn == 3:
        eventPlayer.teleport(vect(185.152, 46.154, 185.661))
        botspawnzone = 1
        startForcingSpawn(Team.ALL, 0)
        telespot = 102
    elif setspawn == 4:
        eventPlayer.teleport(vect(367.509, -8.358, -241.533))
        botspawnzone = 2
        startForcingSpawn(Team.ALL, 2)
        telespot = 103
    elif setspawn == 5:
        eventPlayer.teleport(vect(200.42, -8.412, -242.411))
        botspawnzone = 2
        startForcingSpawn(Team.ALL, 2)
        telespot = 103


rule "80 player died without maniac":
    @Event playerDied
    @Team 1
    @Condition eventPlayer.Maniac == false #doesnt need 2 rules just for maniac
    
    Died[eventPlayer.getSlot()] = nearestWalkablePosition(eventPlayer)
    bigMessage(getAllPlayers(), l"{0} {1}".format(eventPlayer, l"{0}!".format(l"Down")))
    eventPlayer.setMaxHealth(100)
    E[eventPlayer.getSlot()] = true
    eventPlayer.stopForcingCurrentHero()
    wait(0.1)
    eventPlayer.Jugg = false
    wait(0.1)
    eventPlayer.healthmax = 50
    wait(0.1)
    eventPlayer.healvariable = 100
    wait(0.1)
    eventPlayer.setHealingDealt(100)
    eventPlayer.doublemag = false
    wait(0.1)
    eventPlayer.sprintburstperk = false
    destroyDummy(Team.1, eventPlayer.getSlot() + 4)
    eventPlayer.setAllowedHeroes(eventPlayer.allowedheroes)


rule "81 Died Low points Bonus":
    @Event playerDied
    @Team 1
    @Condition eventPlayer.points < 1500
    @Condition roundnumber > 5
    
    eventPlayer.points = 1500


rule "99  hero ultimate adjustments":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isUsingUltimate() == true
    
    if eventPlayer.getHero() == Hero.ASHE:
        eventPlayer.setDamageDealt(300)
        wait(10)
        eventPlayer.setDamageDealt(100)
    elif eventPlayer.getHero() == Hero.WIDOWMAKER:
        getPlayers(Team.1).setDamageDealt(300)
        wait(12.5)
        getPlayers(Team.1).setDamageDealt(100)
    elif eventPlayer.getHero() == Hero.SYMMETRA:
        getLivingPlayers(Team.1).addHealthPool(Health.NORMAL, 200, false)
        wait(12.5)
        removeHealthPool(getLastCreatedHealthPool())
    elif eventPlayer.getHero() == Hero.JUNKRAT:
        eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 10)
    elif eventPlayer.getHero() == Hero.MERCY:
        getDeadPlayers(Team.1).resurrect()
    elif eventPlayer.getHero() == Hero.ZENYATTA:
        eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 6)
    elif eventPlayer.getHero() == Hero.CASSIDY:
        eventPlayer.setGravity(0)
        waitUntil(false, 7)
        eventPlayer.setGravity(100)
    elif eventPlayer.getHero() == Hero.LUCIO:
        getLivingPlayers(Team.1).addHealthPool(Health.NORMAL, 500, false, false)
        wait(10)
        getLivingPlayers(Team.1).removeAllHealthPools()


rule "110 player hit speed boost default":
    @Event playerTookDamage
    @Team 1
    @Condition eventDamage == true
    @Condition eventPlayer.sprintburstperk == false
    #change this and many other features to be dependant on difficulty
    @Condition createWorkshopSettingBool("difficulty", "speed boost when hit", true) == true
    
    eventPlayer.setMoveSpeed(150)
    wait(1)
    eventPlayer.setMoveSpeed(100)


rule "set allowed heros (wip)":
    @Event playerJoined
    @Disabled
    
    #this needs to store what heroes the player has purchased through their playthrough
    


rule "126 healing dealt points":
    @Event playerReceivedHealing
    @Team 1
    @Condition healee != healer
    
    healer.points += 20
    wait(0.25)


rule "158 melee stun":
    @Event playerTookDamage
    @Team 2
    @Condition createWorkshopSettingBool("difficulty", "melee stun", true) == true
    @Condition attacker.isMeleeing() == true
    @Condition distance(attacker, victim) <= 3
    
    eventPlayer.setStatusEffect(null, Status.STUNNED, 1)


rule "163 heal over time effect solo":
    @Event playerTookDamage
    @Team 1
    @Condition getLivingPlayers(Team.1) == true
    @Condition getNumberOfPlayers(Team.1) == 1
    
    if getNumberOfPlayers(Team.1) == 1:
        #need to disable built in health regen as well
        stopHealingOverTime(eventPlayer.healovertime)
        wait(5, Wait.RESTART_WHEN_TRUE)
        eventPlayer.startHealingOverTime(eventPlayer, 3, 4 * eventPlayer.healvariable)
        eventPlayer.healovertime = getLastHealingOverTimeId()
    elif getNumberOfPlayers(Team.1) > 1:
        stopHealingOverTime(eventPlayer.healovertime)
        wait(5, Wait.RESTART_WHEN_TRUE)
        eventPlayer.startHealingOverTime(eventPlayer, 3, 4 * eventPlayer.healvariable)
        eventPlayer.healovertime = getLastHealingOverTimeId()


rule "245 Rule 388 tank sheild":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    
    if eventPlayer.getHero() == Hero.SIGMA:
        eventPlayer.addHealthPool(Health.NORMAL, 100, false, false)
        wait(10)
        eventPlayer.removeAllHealthPools()
    elif eventPlayer.getHero() == Hero.REINHARDT:
        eventPlayer.addHealthPool(Health.NORMAL, 100, false, false)
        wait(10)
        eventPlayer.removeAllHealthPools()
    elif eventPlayer.getHero() == Hero.DVA:
        eventPlayer.addHealthPool(Health.NORMAL, 100, false, false)
        wait(10)
        eventPlayer.removeAllHealthPools()
    elif eventPlayer.getHero() == Hero.RAMATTRA:
        eventPlayer.addHealthPool(Health.NORMAL, 100, false, false)
        wait(10)
        eventPlayer.removeAllHealthPools()


rule "393 POINTS Omnic kill (final hit (could probably make this one rule))":
    @Event playerDealtFinalBlow
    @Team 1
    
    if eventPlayer.isMeleeing() == false:
        if eventWasCriticalHit == false:
            eventPlayer.points += 50 + eventPlayer.heropoints * eventPlayer.H
            chaseAtRate(eventPlayer.points2, (evalOnce(eventPlayer.points) + 0) * eventPlayer.H, 1000)
            if eventPlayer.H != 1:
                goto lbl_0
            if eventPlayer.H == 1:
                goto lbl_1
            lbl_0:
            R += 100 * eventPlayer.H
            lbl_1:
            eventPlayer.xp[eventPlayer.currentheroxp] += 5
        elif eventWasCriticalHit == true:
            eventPlayer.points += 100 + eventPlayer.heropoints * eventPlayer.H
            chaseAtRate(eventPlayer.points2, (evalOnce(eventPlayer.points) + 0) * eventPlayer.H, 1000)
            if eventPlayer.H != 1:
                goto lbl_2
            if eventPlayer.H == 1:
                goto lbl_3
            lbl_2:
            R += 200 * eventPlayer.H
            lbl_3:
            eventPlayer.xp[eventPlayer.currentheroxp] += 10
    elif eventPlayer.isMeleeing() == true:
        eventPlayer.points += 130 + eventPlayer.heropoints * eventPlayer.H
        chaseAtRate(eventPlayer.points2, (evalOnce(eventPlayer.points) + 0) * eventPlayer.H, 250)
        if eventPlayer.H != 1:
            goto lbl_4
        if eventPlayer.H == 1:
            goto lbl_5
        lbl_4:
        R += 260 * eventPlayer.H
        lbl_5:
        eventPlayer.xp[eventPlayer.currentheroxp] += 15


rule "396 POINTS Omnic kill (elimination)":
    @Event playerEarnedElimination
    @Team 1
    @Condition eventWasCriticalHit == false
    @Condition eventPlayer.isMeleeing() == false
    
    if eventWasCriticalHit == false:
        if eventPlayer.getHero() in getDamageHeroes() == true:
            eventPlayer.heropoints = 15
        elif eventPlayer.getHero() in getSupportHeroes() == true:
            eventPlayer.heropoints = 5
        elif eventPlayer.getHero() in getTankHeroes() == true:
            eventPlayer.heropoints = 10
        eventPlayer.points += 40 + eventPlayer.heropoints * eventPlayer.H
        if eventPlayer.H != 1:
            goto lbl_0
        if eventPlayer.H == 1:
            goto lbl_1
        lbl_0:
        R += 80 * eventPlayer.H
        lbl_1:
        eventPlayer.xp[eventPlayer.currentheroxp] += 5
    elif eventWasCriticalHit == true:
        if eventPlayer.getHero() in getDamageHeroes() == true:
            eventPlayer.heropoints = 30
        elif eventPlayer.getHero() in getSupportHeroes() == true:
            eventPlayer.heropoints = 10
        elif eventPlayer.getHero() in getTankHeroes() == true:
            eventPlayer.heropoints = 20
        eventPlayer.points += 80 + eventPlayer.heropoints * eventPlayer.H
        if eventPlayer.H != 1:
            goto lbl_2
        if eventPlayer.H == 1:
            goto lbl_3
        lbl_2:
        R += 160 * eventPlayer.H
        lbl_3:
        eventPlayer.xp[eventPlayer.currentheroxp] += 10


rule "Set starting heros (hero needs to be a variable, and also need to set up a way to go through hero selection twice)":
    @Event eachPlayer
    @Team 1
    
    eventPlayer.heroswap[0] = Hero.CASSIDY
    eventPlayer.heroswap[1] = Hero.DVA
    eventPlayer.heroiconswap[0] = heroIcon(Hero.CASSIDY)
    eventPlayer.heroiconswap[1] = heroIcon(Hero.DVA)


rule "245  tank sheild 2":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true
    
    if eventPlayer.getHero() == Hero.WINSTON:
        eventPlayer.addHealthPool(Health.NORMAL, 100, false, false)
        wait(10)
        #will create future conflicts with other sheilds need patch
        eventPlayer.removeAllHealthPools()
    elif eventPlayer.getHero() == Hero.DOOMFIST:
        eventPlayer.addHealthPool(Health.NORMAL, 100, false, false)
        wait(10)
        eventPlayer.removeAllHealthPools()


rule "ultimate use check":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.currentultcharge = false


rule "soldier explosive rounds (could make this one rule)":
    @Event eachPlayer
    @Team 1
    @Hero soldier
    @Condition eventPlayer.isFiringPrimaryFire() == true
    @Condition eventPlayer.isUsingUltimate() == true
    
    #higher than .11 due to lag
    wait(0.22)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.BLUE, raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, getPlayers(Team.2), eventPlayer, true).getHitPosition(), 5)
    if ruleCondition:
        loop()


rule "third person camera accurate":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.cameratoggle == 1
    
    eventPlayer.cameravar1 = vect(0, 0, 0)
    eventPlayer.startCamera(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(eventPlayer.cameravar1, eventPlayer, Transform.ROTATION) + eventPlayer.getFacingDirection() * eventPlayer.cameravar2, getPlayers(Team.2), eventPlayer, false).getHitPosition(), raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * eventPlayer.C, getPlayers(Team.2), eventPlayer, false).getHitPosition(), 40)

rule "Camera 3rd person static":
    @Event eachPlayer
    @Condition eventPlayer.cameratoggle == 2
    
    eventPlayer.startCamera(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(vect(-1, 0.55, -3), eventPlayer, Transform.ROTATION) + eventPlayer.getFacingDirection() * -4 * CameraDistanceFactor, null, eventPlayer, false).getHitPosition(), eventPlayer + eventPlayer.getFacingDirection() * 1000, 300)


rule "third person accurate initialize":
    @Event eachPlayer
    @Condition eventPlayer.cameratoggle == 1
    
    eventPlayer.C = 200
    chaseOverTime(eventPlayer.cameravar1, vect(0, 0.5, 0), 0.05, ChaseTimeReeval.NONE)
    chaseOverTime(eventPlayer.cameravar2, -1.25, 0.1, ChaseTimeReeval.NONE)


rule "toggle camera toggle":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true
    
    if eventPlayer.cameratoggle == 2:
        wait(1, Wait.ABORT_WHEN_FALSE)
        eventPlayer.cameratoggle = false
        eventPlayer.stopCamera()
    elif eventPlayer.cameratoggle == false:
        wait(1, Wait.ABORT_WHEN_FALSE)
        eventPlayer.cameratoggle = 1
    elif eventPlayer.cameratoggle == 1:
        wait(1, Wait.ABORT_WHEN_FALSE)
        eventPlayer.cameratoggle = 2

rule "Camera 3rd person static crosshair":
    createInWorldText(localPlayer if localPlayer.extraPlayerVar[17] == 2 else null, "+", raycast(localPlayer.getEyePosition(), localPlayer.getEyePosition() + localPlayer.getFacingDirection() * 999, getAllPlayers(), localPlayer, true).getHitPosition(), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING)


rule "Fix dva health":
    @Event eachPlayer
    @Condition eventPlayer.getHero() == Hero.DVA
    
    if eventPlayer.isInAlternateForm() == true:
        eventPlayer.setMaxHealth(220)
    elif eventPlayer.isInAlternateForm() == false:
        eventPlayer.setMaxHealth(eventPlayer.healthmax)
    waitUntil(eventPlayer.getHero() != Hero.DVA, 99999)
    eventPlayer.setMaxHealth(100)
    heal(eventPlayer, null, 1000)

rule "mercy overheal mechanic":
    @Event playerReceivedHealing
    @Condition healer.getHero() == Hero.MERCY
    @Condition healee != healer

    waitUntil(healee.getHealth() == healee.getMaxHealth(), 99999)
    healee.addHealthPool(Health.NORMAL, healee.getMaxHealth() * 0.5, false, false)
    healer.points += 50