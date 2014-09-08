function get ( _sType )
	local tResults = {}
	for i, sSide in ipairs( rs.getSides() ) do
		if peripheral.getType( sSide ) == _sType then
			table.insert( tResults, sSide )
		end
	end
	if #tResults == 0 then
		return nil
	else
		return tResults
	end
end

function force ( _sType )
	local tResults = {}
	for i, sSide in ipairs( rs.getSides() ) do
		if peripheral.getType( sSide ) == _sType then
			table.insert( tResults, sSide )
		end
	end

	if #tResults == 0 then
		term.clear()
		print( "Es wurde kein ".. tostring( _sType ) .. " gefunden!" )
		return nil
	elseif #tResults == 1 then
		return peripheral.wrap( tResults[1] )
	else
		repeat
			local bool = false
			term.clear()
			print( "Es wurden mehrere " .. tostring( _sType ) .. " gefunden!" )
			for i, sSide in pairs( tResults ) do
				local x, y = term.getCursorPos()
				term.setCursorPos( 1, y + 1 )
				term.write("F" .. tostring( i ) .. ": " .. tostring( sSide ))
			end
			local event, keycode = os.pullEvent( "key" )
			for i, sSide in pairs( tResults ) do
				if keycode == ( 58 + i ) then
					bool = true
					term.clear()
					term.setCursorPos( 1, 1 )
					return peripheral.wrap( sSide )
				end
			end
		until bool
	end
end