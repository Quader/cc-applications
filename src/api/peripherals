function get(per)
    local sides = peripheral.getNames()
    local p = {}

    if #sides > 0 then
        for i, side in pairs(sides) do
            if peripheral.getType(side) == per then
                table.insert(p, side)
            end
        end

        if #p == 0 then
            return nil
        else
            return p
        end
    else
        return nil
    end
end

function force(per)
    local sides = peripheral.getNames()
    local p = {}

    if #sides > 0 then
        for i, side in pairs(sides) do
            if peripheral.getType(side) == per then
                table.insert(p, side)
            end
        end

        if #p == 0 then
            term.clear()
            term.setCursorPos(1, 1)
            term.write("Es wurde kein ".. tostring(per) .. " gefunden!")
            return nil
        elseif #p == 1 then
            return peripheral.wrap(p[1])
        else
            repeat
            local bool = false
            term.clear()
            term.setCursorPos(1, 1)
            term.write("Es wurden mehrere " .. tostring(per) .. " gefunden!")
            for i, side in pairs(p) do
                local x, y = term.getCursorPos()
                term.setCursorPos(1, y + 1)
                term.write("F" .. tostring(i) .. ": " .. tostring(side))
            end
            local event, keycode = os.pullEvent("key")
            for i, side in pairs(p) do
                if keycode == (58 + i) then
                    bool = true
                    term.clear()
                    term.setCursorPos(1,1)
                    return peripheral.wrap(side)
                end
            end
            until bool 
        end
    else
        term.clear()
            term.setCursorPos(1, 1)
            term.write("Es wurde kein Peripheral gefunden!")
        return nil
    end
end