rednet.open("top")
os.pullEvent = os.pullEventRaw

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
    end
end
