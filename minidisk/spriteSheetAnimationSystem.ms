import "qa"

Animation = {}
Animation.frames = []
Animation.initialised = false

Animation.resetNextFrameTimer = function
    self.nextFrameTimer = 1/self.fps
end function

Animation.addToTimer = function
    self.nextFrameTimer = self.nextFrameTimer + 1/self.fps
end function

Animation.init = function(frames,fps = 1, currentFrame = 0)
    self.frames = frames
    self.fps = fps
    self.currentFrame = currentFrame
    self.resetNextFrameTimer
    self.initialised = true
end function

Animation.update = function(delta)
    self.nextFrameTimer = self.nextFrameTimer - delta
    if self.nextFrameTimer <= 0 then
        self.currentFrame = (self.currentFrame + 1) % self.frames.len
        self.addToTimer
    end if
end function

Animation.getFrame = function
    return self.frames[self.currentFrame]
end function

SpriteSheetAnimationSystem = {}
SpriteSheetAnimationSystem.initialised = false

SpriteSheetAnimationSystem.init = function(path, cols, rows)
    self.spriteSheet = file.loadImage(path)
    self.cols = cols
    self.rows = rows
    self.frameWidth = self.spriteSheet.width / self.cols
    qa.assert self.frameWidth % 1 == 0, "Width of frames is not a whole number, check your cols parameter!"
    self.frameHeight = self.spriteSheet.height / self.rows
    qa.assert self.frameHeight % 1 == 0, "Height of frames is not a whole number, check your rows parameter!"
    self.animations = {}
    self.currentAnimation = null
    self.initialised = true
end function

SpriteSheetAnimationSystem.imageAt = function(col, row)
    return self.spriteSheet.getImage(col*self.frameWidth,self.spriteSheet.height-self.frameHeight*(1+row),self.frameWidth, self.frameHeight)
end function

SpriteSheetAnimationSystem.addAnimation = function(name, frames, fps=1, frame=0)
    images = []
    for location in frames
        images.push self.imageAt(location[0],location[1])
    end for
    anim = new Animation
    anim.init images, fps, frame
    self.animations[name] = anim
end function

SpriteSheetAnimationSystem.switchAnimation = function(name, frame=0)
    if not self.currentAnimation == name then
        self.currentAnimation = name
        self.animations[name].currentFrame = frame
        self.animations[name].resetNextFrameTimer
    end if
end function

SpriteSheetAnimationSystem.update = function(delta)
    if self.currentAnimation != null then self.animations[self.currentAnimation].update delta
end function

SpriteSheetAnimationSystem.getFrame = function
    if self.currentAnimation != null then 
        frame = self.animations[self.currentAnimation].getFrame()
    end if
    return frame
end function

runUnitTests = function
    testSystem = new SpriteSheetAnimationSystem
    qa.assertEqual testSystem.initialised, false
    testSystem.init "/sys/pics/SimplePlatformTiles.png", 12, 8
    qa.assertEqual testSystem.initialised, true
end function

if globals == locals then runUnitTests