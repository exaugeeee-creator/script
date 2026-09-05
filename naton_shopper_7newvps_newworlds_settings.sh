#!/bin/bash
set -euo pipefail

# Naton Shopper - automatic setup for 7 VPS / 2 configs each
# New world list: 145 worlds, sorted ascending and split evenly across 14 configs.
# Uses short hostname for reliable VPS detection.

NATON_DIR="/root/.onlybot/naton-scripts/Naton Shopper/settings"
HOST="$(hostname -s 2>/dev/null || hostname)"

# ---------- World lists ----------
WORLD_1='302,303,304,306,307,309,310,311,312,313,315'
WORLD_2='317,320,323,324,325,327,328,331,332,333,334'
WORLD_3='336,338,339,340,341,342,343,344,347,348,350'
WORLD_4='351,352,355,356,357,358,359,360,365,367,368'
WORLD_5='371,374,375,376,378,395,405,406,407,408,409'
WORLD_6='410,411,421,422,438,439,440,441,442,443'
WORLD_7='444,445,446,457,458,459,461,462,463,464'
WORLD_8='465,466,500,501,503,504,505,506,507,508'
WORLD_9='509,510,511,512,513,514,515,516,517,518'
WORLD_10='519,520,521,522,523,524,525,538,541,542'
WORLD_11='543,544,545,546,547,550,551,556,557,559'
WORLD_12='562,563,564,566,567,582,599,600,601,602'
WORLD_13='603,604,609,619,620,621,622,624,625,626'
WORLD_14='661,662,663,664,668,693,694,695,699,700'

# ---------- Select lists from hostname ----------
case "$HOST" in
    ui0z)
        VPS_NAME="VPS 1"
        WORLDS_1="$WORLD_1"
        WORLDS_2="$WORLD_2"
        ;;
    sbk2)
        VPS_NAME="VPS 2"
        WORLDS_1="$WORLD_3"
        WORLDS_2="$WORLD_4"
        ;;
    uzmq)
        VPS_NAME="VPS 3"
        WORLDS_1="$WORLD_5"
        WORLDS_2="$WORLD_6"
        ;;
    ue4v)
        VPS_NAME="VPS 4"
        WORLDS_1="$WORLD_7"
        WORLDS_2="$WORLD_8"
        ;;
    uehp)
        VPS_NAME="VPS 5"
        WORLDS_1="$WORLD_9"
        WORLDS_2="$WORLD_10"
        ;;
    uq6q)
        VPS_NAME="VPS 6"
        WORLDS_1="$WORLD_11"
        WORLDS_2="$WORLD_12"
        ;;
    tl70)
        VPS_NAME="VPS 7"
        WORLDS_1="$WORLD_13"
        WORLDS_2="$WORLD_14"
        ;;
    *)
        echo "ERROR: Unknown hostname: $HOST"
        echo "Allowed: ui0z sbk2 uzmq ue4v uehp uq6q tl70"
        exit 1
        ;;
esac

mkdir -p "$NATON_DIR"

create_config() {
    local file="$1"
    local worlds="$2"

    if [[ -f "$file" ]]; then
        cp -a "$file" "${file}.backup.$(date +%Y%m%d-%H%M%S)"
        echo "Backup created for $file"
    fi

    cat > "$file" <<EOF
#Naton Shopper Settings
#Sat Sep 05 13:11:52 EEST 2026
AcceptAidConfig={"disableAcceptAid"\:false,"configureAcceptAid"\:false}
AutoBondConfig={"price"\:{"useArrowkeyPrice"\:true,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:false,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:2,"staticPrice"\:0,"relistPolicy"\:{"nextPrice"\:{"useArrowkeyPrice"\:true,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:false,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:3,"staticPrice"\:0,"relistPolicy"\:{"nextPrice"\:{"useArrowkeyPrice"\:true,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:false,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:4,"staticPrice"\:0},"range"\:{"max"\:10,"min"\:5,"type"\:"UNIFORM","upperPlayerRandomization"\:20.0,"lowerPlayerRandomization"\:-20.0},"timeUnit"\:"MINUTES"}},"range"\:{"max"\:10,"min"\:5,"type"\:"UNIFORM","upperPlayerRandomization"\:20.0,"lowerPlayerRandomization"\:-20.0},"timeUnit"\:"MINUTES"}},"obtainGoldFromMuleIfOut"\:false,"rebondDays"\:2,"cancelPendingBuyOffersForGold"\:false,"use"\:true}
BankScrollConfig={"scrollMethod"\:"DEFAULT"}
CameraAngleConfig={"keepCameraAngleInRange"\:false,"cameraAngleMin"\:70,"cameraAngleMax"\:100}
CameraRotationConfig={"cameraRotationMax"\:100,"keepCameraRotationInRange"\:false,"cameraRotationMin"\:360}
CameraZoomConfig={"frequencyTimeUnit"\:"MINUTES","frequency"\:{"max"\:40,"min"\:15,"type"\:"UNIFORM"},"zoom"\:{"min"\:50,"max"\:80,"sd"\:8,"avg"\:70,"type"\:"NORMAL"},"enabled"\:false}
ChatHandlerConfig={"holdSpace"\:false,"keyContinue"\:true,"loopSleep"\:{"max"\:125,"min"\:100,"type"\:"UNIFORM","upperPlayerRandomization"\:20.0,"lowerPlayerRandomization"\:-20.0},"beforeOption"\:{"min"\:180,"max"\:5000,"sd"\:192,"avg"\:550,"type"\:"NORMAL","upperPlayerRandomization"\:20.0,"lowerPlayerRandomization"\:-20.0},"keyOptions"\:true,"beforeContinue"\:{"min"\:100,"max"\:5000,"sd"\:182,"avg"\:420,"type"\:"NORMAL","upperPlayerRandomization"\:20.0,"lowerPlayerRandomization"\:-20.0}}
ChatModeConfig={"tradeChatMode"\:"ON","configurePrivateChat"\:false,"configureTradeChat"\:false,"gameChatMode"\:"ALL","configureChannelChat"\:false,"channelChatMode"\:"ON","configureGameChat"\:false,"configureClanChat"\:false,"clanChatMode"\:"ON","privateChatMode"\:"ALL","configurePublicChat"\:false,"publicChatMode"\:"ON"}
DaxWalkerConfig={"enableSeed"\:false,"useDentistWalker"\:false,"enableTeleporting"\:true}
DiscordWebhookConfig={"sendOnDeath"\:false,"sendOnEnd"\:false,"sendOnAntiPk"\:false,"sendOnLevel"\:false,"sendOnFrequencyMinutes"\:60,"sendOnFrequency"\:false,"webhookUrl"\:"","sendOnStart"\:false,"sendOnInaccessible"\:false,"useWebooks"\:false}
DiscordWebhookOnAntiPkMessageConfig={"customMessage"\:"Anti-PK triggered in world  at \!","includeImage"\:true}
DiscordWebhookOnDeathMessageConfig={"customMessage"\:" has died\!","includeImage"\:true}
DiscordWebhookOnEndMessageConfig={"customMessage"\:"Script Ending name\\nRuntime\: runtime\\nStop Reason\: reason","includeImage"\:true}
DiscordWebhookOnFrequencyMessageConfig={"customMessage"\:"Script Running name\\nRuntime\: runtime","includeImage"\:true}
DiscordWebhookOnInaccessibleMessageConfig={"customMessage"\:"Account Inaccessible\:  is type","includeImage"\:true}
DiscordWebhookOnLevelMessageConfig={"customMessage"\:" has leveled skill-type to skill-level","includeImage"\:true}
DiscordWebhookOnStartMessageConfig={"customMessage"\:"Script Starting name","includeImage"\:true}
DynamicAntibanConfig={"alwaysHover"\:false,"timedActions"\:["CHECK_EXP","RANDOM_RIGHT_CLICK","MOVE_MOUSE","ROTATE_CAMERA","PICK_UP_MOUSE","MOUSE_LEAVE_GAME","EXAMINE_ENTITY","CHECK_TABS"],"reactionTimeScale"\:20.0,"useReactionTimes"\:false}
DynamicClientStateConfig={"openOnEnd"\:false,"hideOnStart"\:false}
DynamicControlsConfig={"cameraType"\:"CLIENT_CAMERA_ANTIBAN","mouseSpeedMax"\:100,"mouseSpeedMin"\:100,"customMouseSpeed"\:false}
DynamicOptionalFailsafeConfig={"adjustCameraZoom"\:false,"removeRoofs"\:false}
DynamicPrefZoomConfig={"maxPrefZoom"\:50,"usePrefZoom"\:false,"minPrefZoom"\:50}
DynamicSoundMuteConfig={"disableSoundsLoginScreen"\:false,"disableSoundsInGame"\:false}
DynamicStuckFailsafeConfig={"enabled"\:true}
DynamicTimeBasedHoppingConfig={"max"\:0,"min"\:0,"sd"\:0,"timeBasedHopping"\:false,"average"\:0}
DynamicWorldHopPlayersConfig={"maxPlayersInRange"\:0,"hopPlayersInRange"\:false,"hopPlayerTalks"\:false,"playerSearchRange"\:0,"onlyHopAtWorkArea"\:true}
DynamicWorldListConfig={"excludeListedWorlds"\:false,"minSecondsPerWorld"\:0,"hopRandom"\:false,"hopSequential"\:false,"worlds"\:[$worlds]}
FkeyConfig={"overrideFkeySetting"\:false,"useFkeys"\:false}
LogoutOnEndConfig={"logoutOnEnd"\:false}
LogoutThumbsUpConfig={"thumbsDownChance"\:50,"thumbsUpChance"\:50,"onlyClickIfXHoursSince"\:false,"enableClickingThumbsOnLogout"\:false,"xHoursSince"\:6}
LoopSleepConfig={"overrideLoopSleep"\:false,"loopSleepRange"\:{"max"\:65,"min"\:45,"type"\:"UNIFORM","upperPlayerRandomization"\:20.0,"lowerPlayerRandomization"\:-20.0}}
MaxExchangeActionLengthConfig={"timeUnit"\:"MINUTES","range"\:{"max"\:60,"min"\:20,"type"\:"UNIFORM","upperPlayerRandomization"\:20.0,"lowerPlayerRandomization"\:-20.0}}
ResizableConfig={"configureResizable"\:false,"resizableType"\:"RESIZABLE_MODERN"}
ScreenshotOnEndConfig={"onlyAfterXMinutes"\:false,"xMinutes"\:60,"screenshot"\:false}
SleepModifierConfig={"enable"\:false,"modifier"\:{"max"\:105,"min"\:95,"type"\:"UNIFORM"}}
cashIn=false
cashInAmount=0
customBuyPrices={"21352"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:800},"1517"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:25},"21326"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:200},"1393"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:9050},"851"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:320},"11093"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:2080},"1397"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:9050},"2358"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:110},"1654"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:190},"1399"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:9050},"855"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:600},"1656"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:530},"1658"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:750},"859"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:1250},"19580"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:500},"9244"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:460},"892"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:150},"1660"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:1200},"9245"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:8750},"19582"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:1000},"830"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:195},"62"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:120},"28991"\:{"useArrowkeyPrice"\:false,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"staticPrice"\:195}}
customSellPrices={}
defaultBuyPrice={"useArrowkeyPrice"\:true,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:false,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:2,"staticPrice"\:0}
defaultSellPrice={"useArrowkeyPrice"\:true,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:false,"gpToAdd"\:0,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:-2,"staticPrice"\:0}
enableGERestocking=true
equipBankTeleport=false
equipShopTeleport=false
fastOpenPacks=false
hopWhenEmpty=true
items=[{"itemId"\:9245,"transactionType"\:"SELL","quantity"\:1000,"shopStockLimit"\:1},{"itemId"\:1399,"transactionType"\:"SELL","quantity"\:1000,"shopStockLimit"\:1},{"itemId"\:1393,"transactionType"\:"SELL","quantity"\:1000,"shopStockLimit"\:1},{"itemId"\:1397,"transactionType"\:"SELL","quantity"\:1000,"shopStockLimit"\:1},{"itemId"\:859,"transactionType"\:"SELL","quantity"\:5000,"shopStockLimit"\:5},{"itemId"\:19582,"transactionType"\:"SELL","quantity"\:5000,"shopStockLimit"\:5},{"itemId"\:19580,"transactionType"\:"SELL","quantity"\:5000,"shopStockLimit"\:5},{"itemId"\:21352,"transactionType"\:"SELL","quantity"\:5000,"shopStockLimit"\:5},{"itemId"\:31973,"transactionType"\:"SELL","quantity"\:4000,"shopStockLimit"\:4},{"itemId"\:9244,"transactionType"\:"SELL","quantity"\:7000,"shopStockLimit"\:7},{"itemId"\:62,"transactionType"\:"SELL","quantity"\:7000,"shopStockLimit"\:7},{"itemId"\:21326,"transactionType"\:"SELL","quantity"\:7000,"shopStockLimit"\:7},{"itemId"\:31004,"transactionType"\:"SELL","quantity"\:7000,"shopStockLimit"\:7},{"itemId"\:28991,"transactionType"\:"SELL","quantity"\:10000,"shopStockLimit"\:7},{"itemId"\:830,"transactionType"\:"SELL","quantity"\:5000,"shopStockLimit"\:5},{"itemId"\:2357,"transactionType"\:"SELL","quantity"\:5000,"shopStockLimit"\:5},{"itemId"\:1654,"transactionType"\:"SELL","quantity"\:7000,"shopStockLimit"\:7},{"itemId"\:892,"transactionType"\:"SELL","quantity"\:10000,"shopStockLimit"\:10},{"itemId"\:1517,"transactionType"\:"SELL","quantity"\:10000,"shopStockLimit"\:10},{"itemId"\:855,"transactionType"\:"SELL","quantity"\:5000,"shopStockLimit"\:5},{"itemId"\:851,"transactionType"\:"SELL","quantity"\:5000,"shopStockLimit"\:5},{"itemId"\:1656,"transactionType"\:"SELL","quantity"\:3000,"shopStockLimit"\:3},{"itemId"\:1660,"transactionType"\:"SELL","quantity"\:3000,"shopStockLimit"\:3},{"itemId"\:1658,"transactionType"\:"SELL","quantity"\:3000,"shopStockLimit"\:3},{"itemId"\:11092,"transactionType"\:"SELL","quantity"\:2000,"shopStockLimit"\:2}]
mule=false
muleAddress=127.0.0.1
muleForCoinsOnRestock=false
muleGPToKeep=500000
muleGoldTargetOnRestock=0
muleID=1
muleIfOver=1000000
muleThreshold=false
napiMiniBreak={"miniBreaking"\:false,"breakFrequencyRange"\:{"min"\:744,"max"\:2882,"sd"\:531,"avg"\:2655,"type"\:"NORMAL","upperPlayerRandomization"\:20.0,"lowerPlayerRandomization"\:-20.0},"breakLengthRange"\:{"min"\:59,"max"\:277,"sd"\:29,"avg"\:116,"type"\:"NORMAL","upperPlayerRandomization"\:20.0,"lowerPlayerRandomization"\:-20.0}}
napiRandomAfk={"frequencyRange"\:{"min"\:362,"max"\:2409,"sd"\:237,"avg"\:1189,"type"\:"NORMAL","upperPlayerRandomization"\:20.0,"lowerPlayerRandomization"\:-20.0},"afkLengthRange"\:{"min"\:195,"max"\:308,"sd"\:68,"avg"\:274,"type"\:"NORMAL","upperPlayerRandomization"\:20.0,"lowerPlayerRandomization"\:-20.0},"mouseOffScreenChance"\:"ALWAYS","randomAfking"\:false}
progressionEntries=[]
repeatProgression=false
repeatWhenDone=false
restockOnStart=true
selectedShopTile={"x"\:2905,"y"\:3148,"z"\:0}
settingsVersion=0
shopNpcName=shop keeper
stopConditionExp={"allMatch"\:false,"conditions"\:[]}
useProgressiveMode=false
EOF
    chmod 644 "$file"
}

create_config "$NATON_DIR/1.ini" "$WORLDS_1"
create_config "$NATON_DIR/2.ini" "$WORLDS_2"

echo "=========================================="
echo " Naton setup completed"
echo " Host: $HOST"
echo " VPS:  $VPS_NAME"
echo "=========================================="

echo "1.ini:"
grep '^DynamicWorldListConfig=' "$NATON_DIR/1.ini"

echo "2.ini:"
grep '^DynamicWorldListConfig=' "$NATON_DIR/2.ini"

echo "Files:"
ls -lh "$NATON_DIR/1.ini" "$NATON_DIR/2.ini"
