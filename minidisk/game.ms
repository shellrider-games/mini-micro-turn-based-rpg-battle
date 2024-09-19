import "character"
import "spriteSheetAnimationSystem"

clear

heroAnimationSystem = new spriteSheetAnimationSystem.SpriteSheetAnimationSystem
heroAnimationSystem.init "spritesheets/adventurer-Sheet.png", 7, 11
heroAnimationSystem.addAnimation "idle", [[3,5],[4,5],[5,5],[6,5]], 6
heroAnimationSystem.switchAnimation "idle"

slimeAnimationSystem = new spriteSheetAnimationSystem.SpriteSheetAnimationSystem
slimeAnimationSystem.init "spritesheets/slime-Sheet.png", 8, 3
slimeAnimationSystem.addAnimation "idle", [[0,0],[1,0],[2,0],[3,0]], 6
slimeAnimationSystem.switchAnimation "idle"

heroSprite = new Sprite
heroSprite.image = heroAnimationSystem.getFrame
heroSprite.x = 240
heroSprite.y = 260
heroSprite.scale = 4
display(4).sprites.push heroSprite

slimeSprite = new Sprite
slimeSprite.image = slimeAnimationSystem.getFrame
slimeSprite.x = 700
slimeSprite.y = 236
slimeSprite.scale = 4
display(4).sprites.push slimeSprite

lastTimestamp = time
while 1
    currentTimestamp = time
    delta = currentTimestamp - lastTimestamp
    lastTimestamp = currentTimestamp
    heroAnimationSystem.update delta
    slimeAnimationSystem.update delta
    heroSprite.image = heroAnimationSystem.getFrame
    slimeSprite.image = slimeAnimationSystem.getFrame
end while