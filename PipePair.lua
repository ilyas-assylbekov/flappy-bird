PipePair = Class{}

GAP_HEIGHT = 90 + math.random( -25, 25 )

function PipePair:init( y )
    self.x = VIRTUAL_WIDTH
    self.y = y

    self.pipes = {
        [ "upper" ] = Pipe( "top", self.y ),
        [ "lower" ] = Pipe( "bottom", self.y + PIPE_HEIGHT + GAP_HEIGHT )
    }

    self.remove = false
    self.scored = false
end

function PipePair:update( dt )
    if self.x > -1 * PIPE_WIDTH then
        self.x = self.x + (-1) * PIPE_SPEED * dt
        self.pipes[ "lower" ].x = self.x
        self.pipes[ "upper" ].x = self.x
    else
        self.remove = true
    end
end

function PipePair:render()
    for key, pipe in pairs( self.pipes ) do
        pipe:render()
    end
end