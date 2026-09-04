#!/bin/bash
set -e

NATON_DIR="/root/.onlybot/naton-scripts/Naton Shopper/settings"
HOST="$(hostname -f 2>/dev/null || hostname)"
HOST="$(echo "$HOST" | tr '[:upper:]' '[:lower:]' | sed 's/[[:space:]]*$//')"

WORLD_1='302,320,336,352,371,406,444,472,487,505,519,547,582,614,693'
WORLD_2='303,321,337,354,374,407,445,473,488,506,520,550,596,615,694'
WORLD_3='304,322,338,355,375,408,446,474,489,507,521,551,597,619,695'
WORLD_4='305,323,339,356,376,409,457,475,490,508,522,556,599,620,699'
WORLD_5='306,324,340,357,377,410,458,476,491,509,523,557,600,621,700'
WORLD_6='307,325,341,358,378,411,459,477,492,510,524,559,601,622'
WORLD_7='309,327,342,359,385,421,461,478,493,511,525,562,602,624'
WORLD_8='310,328,343,360,386,422,462,479,494,512,538,563,603,625'
WORLD_9='311,329,344,362,394,438,463,480,495,513,541,564,604,626'
WORLD_10='312,330,346,365,395,439,464,481,496,514,542,566,609,661'
WORLD_11='313,331,347,367,402,440,465,482,500,515,543,567,610,662'
WORLD_12='314,332,348,368,403,441,466,484,501,516,544,573,611,663'
WORLD_13='315,333,350,369,404,442,470,485,503,517,545,574,612,664'
WORLD_14='317,334,351,370,405,443,471,486,504,518,546,575,613,668'

if [ "$HOST" = "rucx.c.dedikuoti.lt" ]; then
  WORLDS_1="$WORLD_1"
  WORLDS_2="$WORLD_2"
  PREFIX="vps1"
fi
if [ "$HOST" = "svwr.c.dedikuoti.lt" ]; then
  WORLDS_1="$WORLD_3"
  WORLDS_2="$WORLD_4"
  PREFIX="vps2"
fi
if [ "$HOST" = "un13c.c.dedikuoti.lt" ]; then
  WORLDS_1="$WORLD_5"
  WORLDS_2="$WORLD_6"
  PREFIX="vps3"
fi
if [ "$HOST" = "rsvb.c.dedikuoti.lt" ]; then
  WORLDS_1="$WORLD_7"
  WORLDS_2="$WORLD_8"
  PREFIX="vps4"
fi
if [ "$HOST" = "un11.c.dedikuoti.lt" ]; then
  WORLDS_1="$WORLD_9"
  WORLDS_2="$WORLD_10"
  PREFIX="vps5"
fi
if [ "$HOST" = "sxyr.c.dedikuoti.lt" ]; then
  WORLDS_1="$WORLD_11"
  WORLDS_2="$WORLD_12"
  PREFIX="vps6"
fi
if [ "$HOST" = "sxyt.c.dedikuoti.lt" ]; then
  WORLDS_1="$WORLD_13"
  WORLDS_2="$WORLD_14"
  PREFIX="vps7"
fi

if [ -z "${PREFIX:-}" ]; then
  echo "ERROR: Unknown VPS hostname: $HOST"
  exit 1
fi

create_config() {
  local cfg="$1"
  local worlds="$2"
  local target="$NATON_DIR/$cfg"

  mkdir -p "$NATON_DIR"

  if [ -f "$target" ]; then
    cp "$target" "$target.bak.$(date +%Y%m%d_%H%M%S)"
  fi

  cat > "$target" <<EOF
AcceptAidConfig={"configureAcceptAid"\:false,"disableAcceptAid"\:false}
AutoBondConfig={"price"\:{"gpToAdd"\:0,"staticPrice"\:0,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:false,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:2,"useArrowkeyPrice"\:true,"relistPolicy"\:{"nextPrice"\:{"gpToAdd"\:0,"staticPrice"\:0,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:false,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:3,"useArrowkeyPrice"\:true,"relistPolicy"\:{"nextPrice"\:{"gpToAdd"\:0,"staticPrice"\:0,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:false,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:4,"useArrowkeyPrice"\:true},"timeUnit"\:"MINUTES","range"\:{"max"\:10,"min"\:5,"lowerPlayerRandomization"\:-20.0,"type"\:"UNIFORM","upperPlayerRandomization"\:20.0}}},"timeUnit"\:"MINUTES","range"\:{"max"\:10,"min"\:5,"lowerPlayerRandomization"\:-20.0,"type"\:"UNIFORM","upperPlayerRandomization"\:20.0}}},"rebondDays"\:2,"cancelPendingBuyOffersForGold"\:false,"use"\:true,"obtainGoldFromMuleIfOut"\:false}
BankScrollConfig={"scrollMethod"\:"DEFAULT"}
CameraAngleConfig={"cameraAngleMin"\:70,"cameraAngleMax"\:100,"keepCameraAngleInRange"\:false}
CameraRotationConfig={"keepCameraRotationInRange"\:false,"cameraRotationMin"\:360,"cameraRotationMax"\:100}
CameraZoomConfig={"frequency"\:{"max"\:40,"min"\:15,"type"\:"UNIFORM"},"zoom"\:{"max"\:80,"avg"\:70,"min"\:50,"sd"\:8,"type"\:"NORMAL"},"enabled"\:false,"frequencyTimeUnit"\:"MINUTES"}
ChatHandlerConfig={"keyOptions"\:true,"loopSleep"\:{"max"\:125,"min"\:100,"lowerPlayerRandomization"\:-20.0,"type"\:"UNIFORM","upperPlayerRandomization"\:20.0},"keyContinue"\:true,"holdSpace"\:false,"beforeOption"\:{"max"\:5000,"avg"\:550,"min"\:180,"sd"\:192,"lowerPlayerRandomization"\:-20.0,"type"\:"NORMAL","upperPlayerRandomization"\:20.0},"beforeContinue"\:{"max"\:5000,"avg"\:420,"min"\:100,"sd"\:182,"lowerPlayerRandomization"\:-20.0,"type"\:"NORMAL","upperPlayerRandomization"\:20.0}}
ChatModeConfig={"clanChatMode"\:"ON","configureTradeChat"\:false,"tradeChatMode"\:"ON","configureGameChat"\:false,"publicChatMode"\:"ON","privateChatMode"\:"ALL","configureChannelChat"\:false,"channelChatMode"\:"ON","configureClanChat"\:false,"gameChatMode"\:"ALL","configurePrivateChat"\:false,"configurePublicChat"\:false}
DaxWalkerConfig={"enableSeed"\:false,"enableTeleporting"\:true,"useDentistWalker"\:false}
DiscordWebhookConfig={"sendOnFrequencyMinutes"\:60,"useWebooks"\:false,"sendOnDeath"\:false,"sendOnStart"\:false,"sendOnEnd"\:false,"sendOnInaccessible"\:false,"webhookUrl"\:"","sendOnLevel"\:false,"sendOnAntiPk"\:false,"sendOnFrequency"\:false}
DiscordWebhookOnAntiPkMessageConfig={"includeImage"\:true,"customMessage"\:"Anti-PK triggered in world ${world} at ${position}\!"}
DiscordWebhookOnDeathMessageConfig={"includeImage"\:true,"customMessage"\:"${username} has died\!"}
DiscordWebhookOnEndMessageConfig={"includeImage"\:true,"customMessage"\:"Script Ending ${script-name}\\nRuntime\: ${script-runtime}\\nStop Reason\: ${stop-reason}"}
DiscordWebhookOnFrequencyMessageConfig={"includeImage"\:true,"customMessage"\:"Script Running ${script-name}\\nRuntime\: ${script-runtime}"}
DiscordWebhookOnInaccessibleMessageConfig={"includeImage"\:true,"customMessage"\:"Account Inaccessible\: ${username} is ${inaccessible-type}"}
DiscordWebhookOnLevelMessageConfig={"includeImage"\:true,"customMessage"\:"${username} has leveled ${gained-skill-type} to ${gained-skill-level}"}
DiscordWebhookOnStartMessageConfig={"includeImage"\:true,"customMessage"\:"Script Starting ${script-name}"}
DynamicAntibanConfig={"alwaysHover"\:false,"timedActions"\:["CHECK_EXP","RANDOM_RIGHT_CLICK","MOVE_MOUSE","ROTATE_CAMERA","PICK_UP_MOUSE","MOUSE_LEAVE_GAME","EXAMINE_ENTITY","CHECK_TABS"],"reactionTimeScale"\:20.0,"useReactionTimes"\:false}
DynamicClientStateConfig={"openOnEnd"\:false,"hideOnStart"\:false}
DynamicControlsConfig={"mouseSpeedMin"\:100,"mouseSpeedMax"\:100,"cameraType"\:"CLIENT_CAMERA_ANTIBAN","customMouseSpeed"\:false}
DynamicOptionalFailsafeConfig={"adjustCameraZoom"\:false,"removeRoofs"\:false}
DynamicPrefZoomConfig={"usePrefZoom"\:false,"maxPrefZoom"\:50,"minPrefZoom"\:50}
DynamicSoundMuteConfig={"disableSoundsInGame"\:false,"disableSoundsLoginScreen"\:false}
DynamicStuckFailsafeConfig={"enabled"\:true}
DynamicTimeBasedHoppingConfig={"min"\:0,"max"\:0,"timeBasedHopping"\:false,"sd"\:0,"average"\:0}
DynamicWorldHopPlayersConfig={"maxPlayersInRange"\:0,"hopPlayerTalks"\:false,"onlyHopAtWorkArea"\:true,"playerSearchRange"\:0,"hopPlayersInRange"\:false}
FkeyConfig={"useFkeys"\:false,"overrideFkeySetting"\:false}
LogoutOnEndConfig={"logoutOnEnd"\:false}
LogoutThumbsUpConfig={"thumbsUpChance"\:50,"enableClickingThumbsOnLogout"\:false,"onlyClickIfXHoursSince"\:false,"xHoursSince"\:6,"thumbsDownChance"\:50}
LoopSleepConfig={"overrideLoopSleep"\:false,"loopSleepRange"\:{"max"\:65,"min"\:45,"lowerPlayerRandomization"\:-20.0,"type"\:"UNIFORM","upperPlayerRandomization"\:20.0}}
MaxExchangeActionLengthConfig={"timeUnit"\:"MINUTES","range"\:{"max"\:2,"min"\:1,"lowerPlayerRandomization"\:-20.0,"type"\:"UNIFORM","upperPlayerRandomization"\:20.0}}
ResizableConfig={"resizableType"\:"RESIZABLE_MODERN","configureResizable"\:false}
ScreenshotOnEndConfig={"onlyAfterXMinutes"\:false,"screenshot"\:false,"xMinutes"\:60}
SleepModifierConfig={"modifier"\:{"max"\:105,"min"\:95,"type"\:"UNIFORM"},"enable"\:false}
cashIn=false
cashInAmount=0
customBuyPrices={"21352"\:{"gpToAdd"\:0,"staticPrice"\:800,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"1517"\:{"gpToAdd"\:0,"staticPrice"\:25,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"21326"\:{"gpToAdd"\:0,"staticPrice"\:200,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"1393"\:{"gpToAdd"\:0,"staticPrice"\:9050,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"851"\:{"gpToAdd"\:0,"staticPrice"\:320,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"11093"\:{"gpToAdd"\:0,"staticPrice"\:2080,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"1397"\:{"gpToAdd"\:0,"staticPrice"\:9050,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"2358"\:{"gpToAdd"\:0,"staticPrice"\:110,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"1654"\:{"gpToAdd"\:0,"staticPrice"\:190,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"1399"\:{"gpToAdd"\:0,"staticPrice"\:9050,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"855"\:{"gpToAdd"\:0,"staticPrice"\:600,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"1656"\:{"gpToAdd"\:0,"staticPrice"\:530,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"1658"\:{"gpToAdd"\:0,"staticPrice"\:750,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"859"\:{"gpToAdd"\:0,"staticPrice"\:1250,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"19580"\:{"gpToAdd"\:0,"staticPrice"\:500,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"9244"\:{"gpToAdd"\:0,"staticPrice"\:460,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"892"\:{"gpToAdd"\:0,"staticPrice"\:150,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"1660"\:{"gpToAdd"\:0,"staticPrice"\:1200,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"9245"\:{"gpToAdd"\:0,"staticPrice"\:8750,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"19582"\:{"gpToAdd"\:0,"staticPrice"\:1000,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"830"\:{"gpToAdd"\:0,"staticPrice"\:195,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"62"\:{"gpToAdd"\:0,"staticPrice"\:120,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false},"28991"\:{"gpToAdd"\:0,"staticPrice"\:195,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:true,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:0,"useArrowkeyPrice"\:false}}
customSellPrices={}
defaultBuyPrice={"gpToAdd"\:0,"staticPrice"\:0,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:false,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:2,"useArrowkeyPrice"\:true}
defaultSellPrice={"gpToAdd"\:0,"staticPrice"\:0,"percentToAdd"\:0.0,"osbuddy"\:false,"runelite"\:false,"useStaticPrice"\:false,"runelitePriceType"\:"AVERAGE","arrowKeyAdjustment"\:-2,"useArrowkeyPrice"\:true}
enableGERestocking=true
equipBankTeleport=false
equipShopTeleport=false
fastOpenPacks=false
hopWhenEmpty=true
items=[{"itemId"\:9245,"quantity"\:1000,"shopStockLimit"\:1,"transactionType"\:"SELL"},{"itemId"\:1399,"quantity"\:1000,"shopStockLimit"\:1,"transactionType"\:"SELL"},{"itemId"\:1393,"quantity"\:1000,"shopStockLimit"\:1,"transactionType"\:"SELL"},{"itemId"\:1397,"quantity"\:1000,"shopStockLimit"\:1,"transactionType"\:"SELL"},{"itemId"\:859,"quantity"\:5000,"shopStockLimit"\:5,"transactionType"\:"SELL"},{"itemId"\:19582,"quantity"\:5000,"shopStockLimit"\:5,"transactionType"\:"SELL"},{"itemId"\:19580,"quantity"\:5000,"shopStockLimit"\:5,"transactionType"\:"SELL"},{"itemId"\:21352,"quantity"\:5000,"shopStockLimit"\:5,"transactionType"\:"SELL"},{"itemId"\:31973,"quantity"\:4000,"shopStockLimit"\:4,"transactionType"\:"SELL"},{"itemId"\:9244,"quantity"\:7000,"shopStockLimit"\:7,"transactionType"\:"SELL"},{"itemId"\:62,"quantity"\:7000,"shopStockLimit"\:7,"transactionType"\:"SELL"},{"itemId"\:21326,"quantity"\:7000,"shopStockLimit"\:7,"transactionType"\:"SELL"},{"itemId"\:31004,"quantity"\:7000,"shopStockLimit"\:7,"transactionType"\:"SELL"},{"itemId"\:28991,"quantity"\:10000,"shopStockLimit"\:7,"transactionType"\:"SELL"},{"itemId"\:830,"quantity"\:5000,"shopStockLimit"\:5,"transactionType"\:"SELL"},{"itemId"\:2357,"quantity"\:5000,"shopStockLimit"\:5,"transactionType"\:"SELL"},{"itemId"\:1654,"quantity"\:7000,"shopStockLimit"\:7,"transactionType"\:"SELL"},{"itemId"\:892,"quantity"\:10000,"shopStockLimit"\:10,"transactionType"\:"SELL"},{"itemId"\:1517,"quantity"\:10000,"shopStockLimit"\:10,"transactionType"\:"SELL"},{"itemId"\:855,"quantity"\:5000,"shopStockLimit"\:5,"transactionType"\:"SELL"},{"itemId"\:851,"quantity"\:5000,"shopStockLimit"\:5,"transactionType"\:"SELL"},{"itemId"\:1656,"quantity"\:3000,"shopStockLimit"\:3,"transactionType"\:"SELL"},{"itemId"\:1660,"quantity"\:3000,"shopStockLimit"\:3,"transactionType"\:"SELL"},{"itemId"\:1658,"quantity"\:3000,"shopStockLimit"\:3,"transactionType"\:"SELL"},{"itemId"\:11092,"quantity"\:2000,"shopStockLimit"\:2,"transactionType"\:"SELL"}]
mule=false
muleAddress=127.0.0.1
muleForCoinsOnRestock=false
muleGPToKeep=500000
muleGoldTargetOnRestock=0
muleID=1
muleIfOver=1000000
muleThreshold=false
napiMiniBreak={"breakLengthRange"\:{"max"\:277,"avg"\:116,"min"\:59,"sd"\:29,"lowerPlayerRandomization"\:-20.0,"type"\:"NORMAL","upperPlayerRandomization"\:20.0},"miniBreaking"\:false,"breakFrequencyRange"\:{"max"\:2882,"avg"\:2655,"min"\:744,"sd"\:531,"lowerPlayerRandomization"\:-20.0,"type"\:"NORMAL","upperPlayerRandomization"\:20.0}}
napiRandomAfk={"frequencyRange"\:{"max"\:2409,"avg"\:1189,"min"\:362,"sd"\:237,"lowerPlayerRandomization"\:-20.0,"type"\:"NORMAL","upperPlayerRandomization"\:20.0},"afkLengthRange"\:{"max"\:308,"avg"\:274,"min"\:195,"sd"\:68,"lowerPlayerRandomization"\:-20.0,"type"\:"NORMAL","upperPlayerRandomization"\:20.0},"mouseOffScreenChance"\:"ALWAYS","randomAfking"\:false}
progressionEntries=[]
repeatProgression=false
repeatWhenDone=true
selectedShopTile={"y"\:3148,"z"\:0,"x"\:2905}
settingsVersion=0
shopNpcName=shop keeper
stopConditionExp={"allMatch"\:false,"conditions"\:[]}
useProgressiveMode=false
DynamicWorldListConfig={"excludeListedWorlds"\:false,"hopSequential"\:false,"worlds"\:[$worlds]}
EOF
}

create_config "${PREFIX}_1.ini" "$WORLDS_1"
create_config "${PREFIX}_2.ini" "$WORLDS_2"

echo "Done: $HOST"
echo "Created: ${PREFIX}_1.ini and ${PREFIX}_2.ini"
