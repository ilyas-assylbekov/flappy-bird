PauseState = Class{ __includes = BaseState }

function PauseState:enter( params )
    self.bird = params.bird
    self.pipePairs = params.pipePairs
    self.timer = params.timer
    self.score = params.score
    self.lastY = params.lastY
end

function PauseState:update( dt )
    if love.keyboard.wasPressed( "p" ) then
        sounds[ "music" ]:play()
        gStateMachine:change( "play", {
            bird = self.bird,
            pipePairs = self.pipePairs,
            timer = self.timer,
            score = self.score,
            lastY = self.lastY
        } )
    end
end

function PauseState:render()
    love.graphics.setFont( hugeFont )
    love.graphics.printf( "Pause", 0, 20, VIRTUAL_WIDTH, "center" )
    love.graphics.rectangle( "fill", VIRTUAL_WIDTH / 2 - 55, VIRTUAL_HEIGHT / 2 - 50, 50, 100 )
    love.graphics.rectangle( "fill", VIRTUAL_WIDTH / 2 + 5, VIRTUAL_HEIGHT / 2 - 50, 50, 100 )
end