enchant()

# total は敵を倒した数　vx はごんご丸のスピード e_timeは敵の間隔
py = 0
vx = 1
total = 0
player = null
e_time = 70

class Tsuyama extends Game
  constructor: ->
    super 320, 320
    @fps = 30
    Tsuyama.game = @
    @preload "kappa.png", "combat.png", "bg.png", "fb.png"
    @time = 0
    py = 0
    @onload = ->
      @background = new Sprite 320, 320
      @background.image = this.assets['bg.png']
      @rootScene.addChild @background

      player = new Player(60, 0)
      @rootScene.addChild player

      @rootScene.ontouchstart = (e) ->
        py = e.y - 16

      @onenterframe = ->
        @time++
        if @time % e_time == 0
          @rootScene.addChild new Kappa(288, Math.random()*288)


    @start()

class Player extends Sprite
  constructor: (x, y) ->
    super 32, 32
    @x = x
    @y = y
    @game = Tsuyama.game
    @image = @game.assets['combat.png']
    @frameList = [1, 1, 1, 2, 2, 2]
    @frameIndex=0

  onenterframe: ->
    @y = py

class Shot extends Sprite
  constructor: ->
    super 32, 32
    @x = player.x
    @y = player.y
    @game = Tsuyama.game
    @image = @game.assets['fb.png']

  onenterframe: ->
    @x += 2


class Kappa extends Sprite
  constructor: (x, y) ->
    super 32, 32
    @x = x
    @y = y
    @game = Tsuyama.game
    @image = @game.assets['kappa.png']
    @frameIndex = 0
    @frameList = [1, 2]

  onenterframe: ->
    @x -= vx

    @frameIndex++
    @frame = 1 if @frameIndex == 5
    @frame = 2 if @frameIndex == 10
    @frameIndex = 0 if @frameIndex == 10

    if this.intersect(player)
      this.parentNode.removeChild(this)
      total++

    vx = 2 if 3 < total
    e_time = 50 if 6 < total
    vx = 4 if 9 < total
    e_time = 20 if 12 < total
    vx = 6 if 15 < total
    e_time = 15 if 20 < total
    vx = 7 if 25 < total
    e_time = 13 if 30 < total
    vx = 8 if 35 < total
    e_time = 11 if 40 < total
    vx = 9 if 45 < total
    e_time = 10 if 50 < total

    if @x <= 8
      @msg = "ごんご丸に津山を占領されてしまったー\n         " + total + "匹やっつけた！"
      alert @msg
      game.end
              
window.onload = ->
  new Tsuyama()
