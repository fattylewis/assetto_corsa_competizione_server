#!/bin/bash
set -e

create_configuration() {
    echo ">>>> Creating configuration.json <<<<"
    cd /opt/server/cfg
    cat <<EOF >> configuration.json
{
    "udpPort": ${SERVER_UDP_PORT:-9600},
    "tcpPort": ${SERVER_TCP_PORT:-9601},
    "maxConnections": ${MAX_CONNECTION:-85},
    "registerToLobby": ${REGISTER_LOBBY:-1},
    "configVersion": 1
}
EOF
}

configure_acc() {
    echo ">>>> Configuring your server <<<<"
    cd /opt/server/cfg
    cat <<EOF >> settings.json
{
    "serverName": "${ACC_SERVER_NAME:-ACC-Docker-Server}",
    "adminPassword": "${ADMIN_PASS}",
    "carGroup": "${CAR_GROUP:-FreeForAll}",
    "trackMedalsRequirement": ${TRACK_MEDALS_REQ:-3},
    "safetyRatingRequirement": ${SAFETY_RATE_REQ:-75},
    "racecraftRatingRequirement": ${RCRAFT_RATE_REQ:-75},
    "password": "${JOIN_PASS}",
    "maxCarSlots": ${MAX_CAR_SLOTS:-30},
    "spectatorPassword": "${SPEC_PASS}",
    "isRaceLocked": ${IS_RACE_LOCKED:-1},
    "randomizeTrackWhenEmpty": ${RANDOM_TRACK_WHEN_EMPTY:-0},
    "allowAutoDQ": ${AUTO_DQ:-0},
    "shortFormationLap": ${SHORT_FORM_LAP:-1},
    "formationLapType": ${FORM_LAP_TYPE:-3},
    "ignorePrematureDisconnects": ${PREM_DISCONNECT:-0},
    "configVersion": 1
}
EOF
}

configure_event() {
    echo ">>>> Configuring your event <<<<"
    cd /opt/server/cfg
    cat <<EOF >> event.json
{
    "track": "${TRACK:-monza}",
    "preRaceWaitingTimeSeconds": ${PRE_RACE_WAIT:-60},
    "sessionOverTimeSeconds": ${SESSION_OVER_TIME:-120},
    "ambientTemp": ${AMBIENT_TEMP:-26},
    "cloudLevel": ${CLOUD_LEVEL:-0.3},
    "rain": ${RAIN:-0.0},
    "weatherRandomness": ${WEATHER_RANDOMNESS:-3},
    "postQualySeconds": ${POST_QUAL_SECONDS:-30},
    "postRaceSeconds": ${POST_RACE_SECONDS:-30},
    "sessions": [
        {
            "hourOfDay": ${P_HOUR_OF_DAY:-10},
            "dayOfWeekend": ${P_DAY_OF_WEEK:-1},
            "timeMultiplier": ${P_TIME_MULTIPLIER:-1},
            "sessionType": "P",
            "sessionDurationMinutes": ${P_DURATION:-20}
        },
		{
            "hourOfDay": ${Q_HOUR_OF_DAY:-17},
            "dayOfWeekend": ${Q_DAY_OF_WEEK:-2},
            "timeMultiplier": ${Q_TIME_MULTIPLIER:-8},
            "sessionType": "Q",
            "sessionDurationMinutes": ${Q_DURATION:-10}
        },
        {
            "hourOfDay": ${R_HOUR_OF_DAY:-16},
            "dayOfWeekend": ${R_DAY_OF_WEEK:-3},
            "timeMultiplier": ${R_TIME_MULTIPLIER:-3},
            "sessionType": "R",
            "sessionDurationMinutes": ${R_DURATION:-20}
        }
    ],    
	"configVersion": 1
}
EOF
}

configure_rules() {
    echo ">>>> Setting Event Rules <<<<<"
    cd /opt/server/cfg
    cat <<EOF >> eventRules.json
    {
        "qualifyStandingType": ${QUALY_STANDING_TYPE:-1},
        "pitWindowLengthSec": ${PIT_WINDOW_LENGTH_S:--1},
        "driverStintTimeSec": ${DRIVER_STINT_TIME_S:--1},
        "mandatoryPitstopCount": ${MANDATORY_PIT_STOP_COUNT:-0},
        "maxTotalDrivingTime": ${MAX_TOT_DRIVER_TIME:--1},
        "maxDriversCount": ${MAX_DRIVER_COUNT:-1},
        "isRefuellingAllowedInRace": ${REFUEL_ALLOWED_IN_RACE:-true},
        "isRefuellingTimeFixed": ${REFUEL_TIME_FIXED:-false},
        "isMandatoryPitstopRefuellingRequired": ${MANDATORY_PIT_REFUEL_REQ:-false},
        "isMandatoryPitstopTyreChangeRequired": ${MANDATORY_PIT_TYRE_REQ:-false},
        "isMandatoryPitstopSwapDriverRequired": ${MANDATORY_PIT_DRIVER_SWAP:-false}
    }
EOF
}

configure_assists() {
    echo ">>>> Configuring Assists <<<<"
    cd /opt/server/cfg
    cat <<EOF >> assistRules.json
    {
        "stabilityControlLevelMax": ${STABILITY_CONTROL_LEVEL_MAX:-26},
        "disableAutosteer": ${DISABLE_AUTOSTEER:-1},
        "disableAutoLights": ${DISABLE_AUTO_HEADLIGHTS:-0},
        "disableAutoWiper": ${DISABLE_AUTO_WIPER:-0},
        "disableAutoEngineStart": ${DISABLE_AUTO_ENGINE_START:-0},
        "disableAutoPitLimiter": ${DISABLE_AUTO_PIT_LIMITER:-0},
        "disableAutoGear": ${DISABLE_AUTO_GEAR:-0},
        "disableAutoClutch": ${DISABLE_AUTO_CLUTCH:-0},
        "disableIdealLine": ${DISABLE_IDEAL_LINE:-0}
    }
EOF
}

create_configuration
configure_acc
configure_event
configure_rules
configure_assists
