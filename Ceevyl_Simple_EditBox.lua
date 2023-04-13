--[[

 ______      # ______      # ______      # __   __     # __  __    # __          ### ______      # _______      # _______      # ______      #
/_____/\     #/_____/\     #/_____/\     #/_/\ /_/\    #/_/\/_/\   #/_/\         # #/_____/\     #/______/\     #/______/\     #/_____/\     #
\:::__\/     #\::::_\/_    #\::::_\/_    #\:\ \\ \ \   #\ \ \ \ \  #\:\ \        # #\:::_:\ \    #\__::::\ \    #\__::::\ \    #\:::__\/     #
 \:\ \  __   # \:\/___/\   # \:\/___/\   # \:\ \\ \ \  # \:\_\ \ \ # \:\ \       # # \:\_\:\ \   #     \::\ \   #     \::\ \   # \:\ \____   #
  \:\ \/_/\  #  \::___\/_  #  \::___\/_  #  \:\_/.:\ \ #  \::::_\/ #  \:\ \____  # #  \::__:\ \  #      \::\ \  #      \::\ \  #  \::__::/\  #
   \:\_\ \ \ #   \:\____/\ #   \:\____/\ #   \ ..::/ / #    \::\ \ #   \:\/___/\ # #       \ \ \ #       \: \ \ #       \: \ \ #   \:\_\:\ \ #
    \_____\/ #    \_____\/ #    \_____\/ #    \___/_(  #     \__\/ #    \_____\/ # #        \_\/ #        \:_\/ #        \:_\/ #    \_____\/ #
             ##             ##             ##             ##           ##             ## ##             ##              ##              ##     

]]--



local index = {}

function NewEditBox(...)
	local self = setmetatable({}, { __index = index, 
	__call = function(self)

		if ( not self ) then

	 		return false;

		end

		removeEventHandler("onClientRender", root, self.EventRender)
		removeEventHandler("onClientClick", root, self.EventClick)
		removeEventHandler("onClientCharacter", root, self.EventWrite)
		removeEventHandler("onClientKey", root, self.EventDell)

		for i,v in pairs(self) do

		 	self[i] = nil

		end

		collectgarbage()

		return;

	end } )

	self.TableValues = {...}

	self.Save = self.TableValues[1]

	self.Select = false;

	self.EventRender = function()
		dxDrawText(self.TableValues[1], self.TableValues[2], self.TableValues[3], self.TableValues[4], self.TableValues[5], self.TableValues[7])
	end

	self.EventClick = function( b , s )
		if not b == 'left' and not s == 'down' then
			return false;
		end

		if not self.Verify(self.TableValues[2], self.TableValues[3], self.TableValues[4], self.TableValues[5]) then
			self.Select = false;
			return false;
		end

		self.Select = true;

		return;
	end

	self.EventWrite = function( key )
		if not isCursorShowing() then
			return false;
		end

		if not self.Select then
			return false;
		end

		if not ( self.TableValues[1]:len() + 1 <= self.TableValues[6] ) then
			return false;
		end

		self.TableValues[1] = self.TableValues[1]..key

		return;
	end

	self.EventDell = function( k, p )
		if not (self.Select) then
			return false;
		end

		if not ( p ) then
			return false
		end

		if not ( k == 'backspace' ) then
			return false;
		end

		if not ( self.TableValues[1]:len() >= 1  ) then

			self.TableValues[1] = self.Save
			return; 

		end

		self.TableValues[1] = string.sub( self.TableValues[1], 1, ( self.TableValues[1]:len() - 1 ) )

		return;
	end


	self.Verify = function( x, y, width, height )
		if ( not isCursorShowing( ) ) then
			return false;
		end

		local sx, sy = guiGetScreenSize ( )
		local cx, cy = getCursorPosition ( )
		local cx, cy = ( cx * sx ), ( cy * sy )	

		return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) );
	end

	addEventHandler("onClientRender", root, self.EventRender, true, 'low-5')
	addEventHandler("onClientClick", root, self.EventClick, true, 'low-5')
	addEventHandler("onClientCharacter", root, self.EventWrite, true, 'low-5')
	addEventHandler("onClientKey", root, self.EventDell, true, 'low-5')

	return self;
end

function index:SetValueToBox( value )
	if not value then
		return false;
	end

	if not ( value:len() < self.TableValues[6] ) then
		return false, 'Limite Ultrapassado, o Limite Definido é : '..self.TableValues[6];
	end

	self.TableValues[1] = value;

	return;
end

function index:GetValueFromBox()
	return self.TableValues[1];
end


--local Ceevyl_EditBox = NewEditBox("Digite o Texto", 1366/2  , (768/2)  , 90, 90, 30 ) // Criando Editbox
 
--Ceevyl_EditBox:GetValueFromBox() -- Obtendo Valor da Box

--Ceevyl_EditBox:SetValueToBox("Testando ai") -- Setando Valor Para a Box

--Ceevyl_EditBox = Ceevyl_EditBox() -- Destruindo Box

--iprint(Ceevyl_EditBox) -- Verificando...


