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

function authWithServer(player, password)
  local table = {}
  table["name"] = player
  table["password"] = password
  local payload = json.encode(table)
  rednet.send(serverID, payload)
  waitForAuthResponse()
end

function waitForAuthResponse()
  authenticated = false
  while authenticated == false do
    local senderID, response = rednet.receive()
    if string.len(response) > 0 and senderID == serverID then
      if response == "Valid" then
        term.clear()
        term.setCursorPos(1,6)
        print("Success!")
        sleep(2)
        waitForStart()
        authenticated = true
      else
        term.clear()
        term.setCursorPos(1,6)
        print("AccessDenied you son of a sneaky bitch!")
        sleep(2)
        waitForStart()
        authenticated = true
      end
    end
  end
end

function getPassword(player)
  pwSet = false
  term.clear()
  term.setCursorPos(1,1)
  print("Hello, "..player.."!")
  print("Please enter your Password!")
  term.setCursorPos(1,5)
  print("Password: ")
  while pwSet == false do
    password = read("*")
    if string.len(password) > 0 then
      authWithServer(player, password)
      pwSet = true
    end
  end
end

function waitForStart()
  local waiting = true
  while waiting == true do
    term.clear()
    print("Waiting for player..")
    a, b = os.pullEvent(player)
    
    local isPlayerEvent = checkPlayerEvent(a)

    if isPlayerEvent == 1 then
      playerDetected(b)
      sleep(2)
      getPassword(b)
      waiting = false
    end
  end
end

waitForStart()
