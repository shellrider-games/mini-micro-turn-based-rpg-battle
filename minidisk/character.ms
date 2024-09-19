import "qa"

Character = {}
Character.hitpoints = 10

Character.takeDamage = function(amount)
    self.hitpoints -= amount
end function

runUnitTests = function
    print "Running character tests"
    testCharacter = new Character
    print "Characters have hitpoints which are a number"
    qa.assert(testCharacter.hitpoints isa number)
    print "Characters can take damage and it decreases hitpoints"
    currentHitpointValue = testCharacter.hitpoints
    testCharacter.takeDamage 3
    qa.assertEqual (currentHitpointValue-testCharacter.hitpoints), 3
    print "Tests complete"
end function

if locals == globals then runUnitTests
