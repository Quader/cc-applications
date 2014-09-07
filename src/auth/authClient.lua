rednet.open("top")
os.pullEvent = os.pullEventRaw
os.loadAPI("json")
local serverID = 1087

function playerDetected(player)
  term.clear()
  term.setCursorPos(1,1)
  print("Player Detected: "..player)
end

function checkPlayerEvent(e)
  local event = e
  if event == "player" then
    print("PlayerEvent detected!")
    return 1
  else 
    print("No PlayerEvent detected!")
    return 0
  end
end

while true do
  print("Waiting for player..")
  a, b = os.pullEvent(player)
  
  local isPlayerEvent = checkPlayerEvent(a)

  if isPlayerEvent == 1 then
    playerDetected(b)
    sleep(2)
    getPassword(b)
  end
end

function authWithServer(player, password)
  local table = {}
  table["name"] = player
  table["password"] = password
  local payload = json.encode(table)
  rednet.send(serverID, payload)
end

function getPassword(player)
  pwSet = false
  term.clear()
  term.setCursorPos(1,1)
  print("Hello, "..player.."! /n")
  print("Please enter your Password")
  term.setCursorPos(5,1)
  while pwSet == true do
    local password = term.read()

  end
end

