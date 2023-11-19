PlayState = Class{ __includes = BaseState }

PIPE_SPEED = 60
PIPE_HEIGHT = 288
PIPE_WIDTH = 70

BIRD_WIDTH = 38
BIRD_HEIGHT = 24

function PlayState:init( )
    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0

    self.score = 0

    self.lastY = -1 * PIPE_HEIGHT + math.random( 80 ) + 20
end

function PlayState:enter( params )
    if params then
        self.bird = params.bird
        self.pipePairs = params.pipePairs
        self.timer = params.timer
        self.score = params.score
        self.lastY = params.lastY 
    end
end

function PlayState:update( dt )
    if love.keyboard.wasPressed( "p" ) then
        sounds[ "music" ]:pause()
        sounds[ "pause" ]:play()
        gStateMachine:change( "pause", {
            bird = self.bird,
            pipePairs = self.pipePairs,
            timer = self.timer,
            score = self.score,
            lastY = self.lastY
        } )
    end

    self.timer = self.timer + dt
    
    local timerRandom = math.random( 2, 10 )
    if self.timer > timerRandom then
        local y = math.max( -1 * PIPE_HEIGHT + 10,
            math.min( self.lastY + math.random( -20, 20 ), VIRTUAL_HEIGHT - GAP_HEIGHT - PIPE_HEIGHT ) )
        self.lastY = y
        
        table.insert( self.pipePairs, PipePair( y ) )
        self.timer = 0
    end

    for key, pair in pairs( self.pipePairs ) do

        if not pair.scored then
            if pair.x + PIPE_WIDTH < self.bird.x then
                self.score = self.score + 1
                pair.scored = true
                sounds[ "score" ]:play()
            end
        end

        pair:update( dt )
    end

    for key, pair in pairs( self.pipePairs ) do
        if pair.remove then
            table.remove( self.pipePairs, key )
        end
    end

    self.bird:update( dt )

    for key, pair in pairs( self.pipePairs ) do
        for l, pipe in pairs( pair.pipes ) do
            if self.bird:collides( pipe ) then
                sounds[ "explosion" ]:play()
                sounds[ "hurt" ]:play()

                gStateMachine:change( "score", {
                    score = self.score
                } )
            end
        end
    end

    if self.bird.y > VIRTUAL_HEIGHT - 15 then
        sounds[ "explosion" ]:play()
        sounds[ "hurt" ]:play()
        
        gStateMachine:change( "score", {
            score = self.score
        } )
    end
end

function PlayState:render()
    for key, pair in pairs( self.pipePairs ) do
        pair:render()
    end

    love.graphics.setFont( flappyFont )
    love.graphics.print( "Score: " .. tostring( self.score ), 8, 8 )

    self.bird:render()
end