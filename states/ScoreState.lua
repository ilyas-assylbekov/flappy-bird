ScoreState = Class{ __includes = BaseState }

function ScoreState:enter( params )
    self.score = params.score
end

function ScoreState:update( dt )
    if love.keyboard.wasPressed( "enter" ) or love.keyboard.wasPressed( "return" ) then
        gStateMachine:change( "countdown" )
    end
end

function ScoreState:render()
    love.graphics.setFont( flappyFont )
    if self.score < 3 then
        love.graphics.printf( "Oh, brother... You Lost!", 0, 64, VIRTUAL_WIDTH, "center" )
    elseif self.score < 5 then
        love.graphics.printf( "You can do better!", 0, 64, VIRTUAL_WIDTH, "center" )
        love.graphics.draw( love.graphics.newImage( "bronze.png" ), VIRTUAL_WIDTH - 100, VIRTUAL_HEIGHT - 150 )
    elseif self.score < 7 then
        love.graphics.printf( "Not bad, kid!", 0, 64, VIRTUAL_WIDTH, "center" )
        love.graphics.draw( love.graphics.newImage( "silver.png" ), VIRTUAL_WIDTH - 100, VIRTUAL_HEIGHT - 150 )
    else
        love.graphics.printf( "Legend!", 0, 64, VIRTUAL_WIDTH, "center" )
        love.graphics.draw( love.graphics.newImage( "gold.png" ), VIRTUAL_WIDTH - 100, VIRTUAL_HEIGHT -150 )
    end

    love.graphics.setFont( mediumFont )
    love.graphics.printf( "Score: " .. tostring( self.score ), 0, 100, VIRTUAL_WIDTH, "center" )

    love.graphics.printf( "Press Enter to Play Again!", 0, 160, VIRTUAL_WIDTH, "center" )
end