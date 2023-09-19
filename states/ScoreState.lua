--[[
	ScoreState Class
	Author: Colton Ogden
	cogden@cs50.harvard.edu

	A simple state used to display the player's score before they
	transition back into the play state. Transitioned to from the
	PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

love.graphics.setDefaultFilter("nearest", "nearest")

--[[
	Store the different medal images in a table, have a string referencing the
	given medal as to not keep on checking each frame.
]]
local medals = {
	bronce = love.graphics.newImage("Bronce.png"),
	silver = love.graphics.newImage("Silver.png"),
	gold = love.graphics.newImage("Gold.png")
}
local achievedMedal

--[[
	When we enter the score state, we expect to receive the score
	from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
	self.score = params.score
	if self.score <= 1 then
		achievedMedal = "none"
	elseif self.score <= 3 then
		achievedMedal = "bronce"
	elseif self.score <= 6 then
		achievedMedal = "silver"
	elseif self.score > 6 then
		achievedMedal = "gold"
	end
end

function ScoreState:update(dt)
	-- go back to play if enter is pressed
	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		gStateMachine:change('countdown')
	end
end

function ScoreState:render()
	-- simply render the score to the middle of the screen
	love.graphics.setFont(flappyFont)
	love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

	love.graphics.setFont(mediumFont)
	love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

	if achievedMedal ~= "none" then
		love.graphics.draw(medals[achievedMedal], VIRTUAL_WIDTH / 2 - 17, VIRTUAL_HEIGHT / 2 - 32)
	end

	love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end
