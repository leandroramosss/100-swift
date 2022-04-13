import SpriteKit

class GameScene: SKScene {
    private let slotBaseGood: String = "slotBaseGood"
    private let slotBaseGlowGood: String = "slotGlowGood"

    private let slotBaseBad: String = "slotBaseBad"
    private let slotBaseGlowBad: String = "slotGlowBad"

    private let slotBaseGoodName: String = "good"
    private let slotBaseBadName: String = "bad"

    private let ball: String = "ball"

    private let background: SKSpriteNode = {
        let backg = SKSpriteNode(imageNamed: "background.jpg")
        backg.position = CGPoint(x: 512, y: 384)
        //blend mode just show the backgroud, disconsidering apha values and transparency
        backg.blendMode = .replace
        // draws the background behind everything
        backg.zPosition = -1
        return backg
    }()

    private let scoreLabel: SKLabelNode = {
        let label = SKLabelNode()
        label.fontName = "ChalkDuster"
        label.text = "Score: 0"
        label.horizontalAlignmentMode = .right
        label.position = CGPoint(x: 980, y: 700)
        return label
    }()

    private let editLabel: SKLabelNode = {
        let label = SKLabelNode()
        label.fontName = "ChalkDuster"
        label.text = "Edit"
        label.position = CGPoint(x: 80, y: 700)
        return label
    }()

    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }

    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    override func didMove(to view: SKView) {
        makeBackground()
        setupScoreLabel()
        setupEditLabel()

        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        setupDelegate()

        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)

        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
    }

    private func makeBackground()
    {
        addChild(background)
    }

    private func setupScoreLabel()
    {
        addChild(scoreLabel)
    }

    private func setupEditLabel()
    {
        addChild(editLabel)
    }

    private func setupDelegate()
    {
        physicsWorld.contactDelegate = self
    }

    func makeSlot(at position: CGPoint, isGood: Bool)
    {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode

        if isGood {
            slotBase = SKSpriteNode(imageNamed: slotBaseGood)
            slotGlow = SKSpriteNode(imageNamed: slotBaseGlowGood)
            //Setting these names for collision purpose
            slotBase.name = slotBaseGoodName
        } else {
            slotBase = SKSpriteNode(imageNamed: slotBaseBad)
            slotGlow = SKSpriteNode(imageNamed: slotBaseGlowBad)
            //Setting these names for collision purpose
            slotBase.name = slotBaseBadName
        }

        slotBase.position = position
        slotGlow.position = position

        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false

        slotBaseCollision(slotBase: slotBase)

        addChild(slotBase)
        addChild(slotGlow)

        spinsSlotGlows(slotGlow: slotGlow)
    }

    private func slotBaseCollision(slotBase: SKSpriteNode)
    {
        //shall no move when is hited
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
    }

    private func spinsSlotGlows(slotGlow: SKSpriteNode)
    {
        //spin half of circle for 10 seconds
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }

    private func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer.jpg")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        //move based gravity an collisions
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }

    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        guard let touch = touches.first else { return }
        //finds where the user touches
        let location = touch.location(in: self)
        //the nodes method see every chield in the screen, that way i can know wich is typed.
        let objects = nodes(at: location)

        if objects.contains(editLabel) {
            editingMode.toggle()
        } else {
            if editingMode {
                // create box
                let size = CGSize(width: Int.random(in: 16...128), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                box.zRotation = CGFloat.random(in: 0...3)
                box.position = location

                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.isDynamic = false

                addChild(box)
            } else {
                makeBall(name: "ballRed",
                         location: location)
            }
        }
    }

    private func makeBall(name: String,
                          location: CGPoint) {
        let ball = SKSpriteNode(imageNamed: name)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        //bouncing level
        ball.physicsBody?.restitution = 0.4
        //add a ball to touched position
        ball.position = location
        //tel me whre the ball bouces in everything
        ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
        //Setting these names for collision purpose
        //everything is a ball becaus we assign a name, them we know that is a balltype.
        ball.name = "ball"
        addChild(ball)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func collisionBetween(ball: SKNode, object: SKNode)
    {
        if object.name == slotBaseGoodName {
            score += 1
            destroy(ball: ball)
        } else if object.name == slotBaseBadName {
            score -= 1
            destroy(ball: ball)
        }
    }

    func destroy(ball: SKNode)
    {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        ball.removeFromParent()
    }

    func didBegin(_ contact: SKPhysicsContact)
    {
        guard let nodeA = contact.bodyA.node,
              let nodeB = contact.bodyB.node
        else {
            return
        }

        if contact.bodyA.node?.name == ball {
            //bodyA first body of contact
            collisionBetween(ball: contact.bodyA.node!, object: nodeB)
        } else if contact.bodyB.node?.name == ball {
            collisionBetween(ball: contact.bodyB.node!, object: nodeA)
        }
    }
}
