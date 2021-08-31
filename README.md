This builds an ACC server. All you need to do to use this is point the container to where you have the ACC dedicated server binary.



None of the variables are required as sane defaults have been applied. The defaults have been taken from the server admin manual.

## configuration.json

-e SERVER_UDP_PORT - Server UDP port, must unique on the system.

-e SERVER_TCP_PORT - Server TCP port, must be unique on the system.

-e MAX_CONNECTION - Max number of connections. Includes drivers and spectaters 

-e REGISTER_LOBBY - Register with the lobby backend. If set to '0' it would be a private multiplayer server.



## settings.json
-e ACC_SERVER_NAME - This is the name of the server.

-e ADMIN_PASS - The admin password

-e CAR_GROUP - This can be: 
                FreeForAll - Any driver can join with any car
                GT3 - Just GT3 Cars
                GT4 - Just GT4 Cars
                Cup - Just Porsche cup car
                ST - Just Lambo Supertrofeo car

-e TRACK_MEDALS_REQ - Defines the amount of track medals that a user has to have for the given track (values 0, 1, 2, 3)

-e SAFETY_RATE_REQ - Defines the Safety Rating (SA) that a user must have to join this server (values -1, 0, …. 99)

-e RCRAFT_RATE_REQ - Defines the Safety Rating (RC) that a user must have to join this server (values -1, 0, …. 99)

-e JOIN_PASS - Password required to enter this server. If a password is set, the server is declared “Private Multiplayer”.

-e SPEC_PASS - Password to enter the server as spectator. Must be different to “password” if both is set. NEED TO MAKE THIS OPTIONAL

-e MAX_CAR_SLOTS - Replaces “maxClientsOverride” and “spectatorSlots”. Defines the amount of car slots the server can occupy; this value is overridden if the pit count of the track is lower, or with 30 for public MP. The gap between maxCarSlots and maxConnections defines how many spectators or other irregular connections (ie entry list entries) can be on the server.

-e IS_RACE_LOCKED - If set to 0, the server will allow joining during a race session. Is not useful in “Public Multiplayer”, as the user-server matching will ignore ongoing race sessions.

-e RANDOM_TRACK_WHEN_EMPTY - If set to 1, the server will change to a random track when the last drivers leaves (which causes a reset to FP1). The “track” property will only define the default state for the first session.

-e AUTO_DQ - If set to 0, the server won’t automatically disqualify drivers, and instead hand out Stop&Go (30s) penalties. This way a server admin / race director has 3 laps time to review the incident, and either use /dq or /clear based on his judgement.

-e SHORT_FORM_LAP - Toggles the short and long formation lap. Long formation is only usable on private servers.

-e FORM_LAP_TYPE - Toggles the formation lap type that is permanently used on this server:
    3 – default formation lap with position control and UI
    0 – old limiter lap
    1 – free (replaces /manual start), only usable for private servers

-e PREM_DISCONNECT - *THIS MUST BE DISABLED WHEN THROUGH WINE* Removes a (very good) fix where users can randomly lose the connection. There is no sane reason to turn this off.
    1 – default: less arbitrary connections lost
    0 – more timeouts, but strict disconnection of anyone who
        appears inactive for 5 seconds. Can be useful on unsupported
        platforms where TCP sockets act differently


## event.json

-e TRACK - Sets the track - see TRACKS.md

-e PRE_RACE_WAIT - Preparation time before a race. Cannot be less than 30s.

-e SESSION_OVER_TIME - Time after that a session is forcibly closing after the timer reached 0:00. Something like 107% of the expected laptime is recommended (careful: default 2 minutes does not properly cover tracks like Spa or Silverstone).

-e AMBIENT_TEMP - Sets the baseline ambient temperature in °C, see “Raceweekend simulation” in serveradmin PDF

-e CLOUD_LEVEL - Sets the baseline cloud level, see “Race weekend simulation”. Has large impact on the cloud levels and rain chances. Values (0.0, 0.1, …. 1.0)

-e RAIN - If weather randomness is off, defines the static rain level. With dynamic weather, it defines the expected rain level, dependent on weatherRandomness. Values (0.0, 0.1, …. 1.0)

-e WEATHER_RANDOMNESS - Sets the dynamic weather level, see “Race weekend simulation”. 0 = static weather; 1-4 fairly realistic weather; 5-7 more sensational

-e POST_QUAL_SECONDS - The time after the last driver is finished (or the sessionOverTimeSeconds passed) in Q sessions and the race start. Should not be set to 0, otherwise grid spawning is not secure.

-e POST_RACE_SECONDS - Additional time after the race ended for everyone, before the next race weekend starts.

-e P_HOUR_OF_DAY - PRACTICE Session starting hour of the day (values 0 - 23)

-e P_DAY_OF_WEEK - PRACTICE Race day (1 = Friday, 2 = Saturday, 3 = Sunday) – relevant to the grip and weather simulation.

-e P_TIME_MULTIPLIER - PRACTICE Rate at which the session time advances in realtime. Values 0, 1, … 24

-e P_DURATION - PRACTICE Session duration in minutes

-e Q_HOUR_OF_DAY - QUALY Session starting hour of the day (values 0 - 23)

-e Q_DAY_OF_WEEK - QUALY Race day (1 = Friday, 2 = Saturday, 3 = Sunday) – relevant to the grip and weather simulation.

-e Q_TIME_MULTIPLIER - QUALY Rate at which the session time advances in realtime. Values 0, 1, … 24

-e Q_DURATION - QUALY Session duration in minutes

-e R_HOUR_OF_DAY - RACE Session starting hour of the day (values 0 - 23)

-e R_DAY_OF_WEEK - RACE Race day (1 = Friday, 2 = Saturday, 3 = Sunday) – relevant to the grip and weather simulation.

-e R_TIME_MULTIPLIER - RACE Rate at which the session time advances in realtime. Values 0, 1, … 24

-e R_DURATION - RACE Session duration in minutes

## eventRules.json

-e QUALY_STANDING_TYPE - 1 = fastest lap, 2 = average lap (running Endurance mode for multiple Q sessions) . Use 1, averaging Qualy is not yet officially supported.

-e PIT_WINDOW_LENGTH_S - Defines a pit window at the middle of the race. Obviously covers the Sprint series format. -1 will disable the pit window. Use this combined with a mandatoryPitstopCount = 1.

-e DRIVER_STINT_TIME_S - Defines the maximum time a driver can stay out without getting a penalty. Can be used to balance fuel efficient cars in endurance races. The stint time resets in the pitlane, no real stop is required.

-1 will disable the stint times. driverStintTimeSec and maxTotalDrivingTime are interdependent features, make sure both are set or off.

-e MANDATORY_PIT_STOP_COUNT - Defines the basic mandatory pit stops. If the value is greater zero, any car that did not execute the mandatory pitstops will be disqualified at the end of the race. The necessary actions can be further configured using the “isMandatoryPitstopXYRequired” properties. A value of zero disables the feature.

-e MAX_TOT_DRIVER_TIME - Restricts the maximum driving time for a single driver. Is only useful for driver swap situations and allows to enforce a minimum driving time for each driver (IRL this is used to make sure mixed teams like Pro/Am have a fair distributions of the slowerdrivers). -1 disables the feature.
driverStintTimeSec and maxTotalDrivingTime are interdependent features, make sure both are set or off.

Will set the maximum driving time for the team size defined by “maxDriversCount”, always make sure both are set.

-e MAX_DRIVER_COUNT - In driver swap situations, set this to the maximum number of drivers on a car. When an entry has fewer drivers than maxDriversCount, maxTotalDrivingTime is automatically
compensated so that those "smaller" entries are also able to complete the race Example: 3H race length, 65 minutes driverStintTimeSec and 65 minutes maxTotalDrivingTime will result in 65 minutes of maxTotalDrivingTime for entries of 3 and 105 (!) minutes for entries of 2.

-e REFUEL_ALLOWED_IN_RACE - Defines if refuelling is allowed during the race pitstops.

-e REFUEL_TIME_FIXED - If set to true, any refuelling will take the same amount of time. If turned off, refuelling will consume time linear to the amount refuelled. Very useful setting to balance fuel efficient cars, especially if combined with other features.

-e MANDATORY_PIT_REFUEL_REQ - Defines if a mandatory pitstop requires refuelling.

-e MANDATORY_PIT_TYRE_REQ - Defines if a mandatory pitstop requires changing tyres.

-e MANDATORY_PIT_DRIVER_SWAP - Defines if a mandatory pitstop requires a driver swap. Will only be effective for cars in driver swap situations; even in a mixed field this will be skipped for cars with a team size of 1 driver.



## assistRules.json

-e STABILITY_CONTROL_LEVEL_MAX - Set’s the maximum % of SC that can be used. In case a client has a higher SC set than allowed by the server, he will only run what is allowed (25% in this example). Obviously setting this property to0 removes all SC, including mouse and keyboard users.
The Stability Control is an artificial driving aid that allows the car to act out of the physics boundaries, and highly recommended to overcome input methods like Keyboards, Gamepads and Mouse steering. However, there is a built-in effect that makes the SC performance inferior, so in theory using (and relying) on SC is already more than enough penalty, and the way to improve performance is to practice driving without.
Default: 100

-e DISABLE_AUTOSTEER - Disables the steering aid that is only available for gamepad controllers. Unlike SC, this works inside the physics and does not allow  unrealistic driving behaviour – except that this is a very strong aid with superhuman feeling for grip and high reaction speed. There is a built-in penalty that should balance the driving performance in most cases, and give an incentive to learn not to use the drivingaid.
Default: 0

-e DISABLE_AUTO_HEADLIGHTS - Forces the equivalent assist option to “off”

-e DISABLE_AUTO_WIPER - Forces the equivalent assist option to “off”

-e DISABLE_AUTO_ENGINE_START - Forces the equivalent assist option to “off”

-e DISABLE_AUTO_PIT_LIMITER - Forces the equivalent assist option to “off”

-e DISABLE_AUTO_GEAR - Forces the equivalent assist option to “off”

-e DISABLE_AUTO_CLUTCH - Forces the equivalent assist option to “off”

-e DISABLE_IDEAL_LINE - Forces the equivalent assist option to “off”





```
docker run --name acc-standalone \
-e ACC_SERVER_NAME="ACC Docker Server" \
-e TRACK=monza -e PREM_DISCONNECT=0 \
-v /opt/server:/opt/server \
fattylewis/assetto_corsa_competizione_server
```



CURRENTLY NOT IMPLEMENTED SETTINGS:

settings.json  
    dumpLeaderboards  
    centralEntryListPath  
    dumpEntryList  

event.json  
    simracerWeatherConditions - EXPERIMENTAL  
    isFixedConditionQualification - EXPERIMENTAL  

eventRules.json - Config generated, but with just defaults, not variables.  
    tyreSetCount - EXPERIMENTAL  

