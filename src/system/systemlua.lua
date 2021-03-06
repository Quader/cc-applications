local iPageHandler_Active_page = 1
local tPageHandler_Functions = {}
local tLog_data = {}
local iLog_scroll = 1
local bEventManager = true
local tEventManager_Functions = {}

local monitor = peripherals.force("monitor")
local iW, iH = monitor.getSize()

Page = {}
Page.__index = Page

function Page:add( _iId, _sName, _tFunctions )
	if type( _iId ) ~= "number" or type( _sName ) ~= "string" or ( type( _tFunctions ) ~= "table" and type ( _tFuncitons ) ~= "nil" ) then
		--TODO Error ausgeben!
		term.clear()
		term.setCursorPos( 1, 1 )
		print(_iId .. " - " .. _sName .. " - " .. tostring(_tFunctions))
		print( "Type error! Expected number, string, table/nil got " .. tostring( type( _iId )) .. " , " ..  tostring( type( _sName )) .. " , " .. tostring( type( _tFunctions )))
		return
	else
		tPageHandler_Functions[_iId] = {}
		tPageHandler_Functions[_iId].name = _sName
		if type( _tFunctions ) == nil then
			tPageHandler_Functions[_iId].functions = nil
		else
			tPageHandler_Functions[_iId].functions = _tFunctions
		end
	end
end

function Page:remove( ... )
	if #... ~= 1 then
		--Error ausgeben!
		term.clear()
		term.setCursorPos( 1, 1 )
		print( "Argument Error! Expected 1 got " .. #... )
		return
	else
		if type( ... )  == "string" then
			for i, tPage in ipairs( tPageHandler_Functions ) do
				if tPage.name == ... then
					table.remove( tPageHandler_Functions, i )
					next = next - 1
				end
			end
		elseif type( ... ) == "number" then
			table.remove( tPageHandler_Functions, ... )
		else
			--Error ausgeben!
			term.clear()
			term.setCursorPos( 1, 1 )
			print( "Type Error! Expected string or number got " .. tostring( type( ... )))
			return
		end
	end
end

function Page:Handler()
	for iI = 1, iW do
		monitor.setCursorPos(iI, iH)
		monitor.write(" ")
	end

	local iXcounter = 1
	for i, tPage in ipairs( tPageHandler_Functions ) do
		for iI = 1, string.len( tPage.name ) do
			monitor.setCursorPos( iXcounter + iI, iH )
			monitor.write(string.sub( tPage.name, iI, iI ))
		end
		iXcounter = iXcounter + string.len( tPage.name ) + 1
	end

	if type( tPageHandler_Functions[iPageHandler_Active_page].functions ) ~= "nil"  then
		for i, tFunc in pairs( tPageHandler_Functions[iPageHandler_Active_page].functions ) do
			TFunc()
		end
	end
end

Log = {}
Log.__index = Log

function Log:draw()
	monitor.setCursorPos( 1, 1 )
	for iI = iLog_scroll, iLog_scroll + iH - 1 do
		monitor.setTextColor( tLog_data[iI].color )
		monitor.write( tLog_data[iI].text )
		local x, y = monitor.getCusorPos()
		monitor.setCursorPos( 1, y + 1 )
	end
end

function Log:add( _cFontcolor, _sText )
	if type( _cFontcolor ) ~= "number" or type( _sText ) ~= "string" then
		--Error ausgeben
		term.clear()
		term.setCursorPos( 1, 1 )
		term.write( "Type error! Expected number, string got " ..  type( _cFontcolor ) ", " .. type( _sText ))
		return
	else
		table.insert( tLog_data, {["color"] = _cFontcolor, ["text"] = _sText})
	end
end

eventManager = {}
eventManager.__index = eventManager

function eventManager:start()
	bEventManager = true
	while bEventManager do 
		local args = { os.pullEventRaw() }

		for iI, fFunctions in pairs( tEventManager_Functions ) do
			fFunctions( args )
		end
	end
end

function eventManager:add( _sFunction )
	if type( _sFunciton ) ~= "string" then
		--Error ausgeben
		term.clear()
		term.setCursorPos( 1, 1 )
		print( "Type error! Expected string got " .. tostring( type( _sFunction )))
		return
	else
		table.insert( tEventManager_Functions, _sFunction )
	end
end

function eventManager:remove( _sFunction )
	if type( _sFunciton ) ~= "string" then
		--Error ausgeben
		term.clear()
		term.setCursorPos( 1, 1 )
		print( "Type error! Expected string got " .. tostring( type( _sFunction )))
		return
	else
		for iI, sName in pairs( tEventManager_Functions ) do
			if sName == _sFunction then
				table.remove( tEventManager_Functions, iI)
				next = next - 1
			end
		end
	end
end

function eventManager:hold()
	bEventManager = false
end