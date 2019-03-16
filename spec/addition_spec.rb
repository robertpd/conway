class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
end

class Cell
  attr_reader :is_on

  def initialize(point = nil)
    @coordinate = point
    @is_on = false
  end

  def turn_on
    @is_on = true
  end

  def turn_off
    @is_on = false
  end

  def x
    @coordinate.x
  end

  def y
    @coordinate.y
  end
end

RSpec.describe Cell do
  it 'is off by default' do
    cell = Cell.new

    expect(cell.is_on).to eq(false)
  end

  it 'can be turned on' do
    cell = Cell.new

    cell.turn_on

    expect(cell.is_on).to eq(true)
  end

  it 'can set coordinates' do
    cell = Cell.new(Point.new(1, 1))

    expect(cell.x).to eq(1)
    expect(cell.y).to eq(1)
  end
end

class Board
  attr_reader :cells

  def initialize(cell)
    @cells = cell
  end

  def _add_cell(cell)

  end
end

class Game
  def initialize(board)
    @board = board
  end

  def tick
    @board.cells.each do |coord, cell|
      score = cell_score(coord)
      cell.turn_off if score < 2
    end
  end

  private

  def cell_score(coord)
    top = @board.cells[Point.new(coord.x, coord.y + 1)]&.is_on == false ? 1 : 0
    bottom = @board.cells[Point.new(coord.x, coord.y + -1)]&.is_on == false ? 1 : 0
    left = @board.cells[Point.new(coord.x + 1, coord.y)]&.is_on == false ? 1 : 0
    right = @board.cells[Point.new(coord.x + 1, coord.y)]&.is_on == false ? 1 : 0

    top + bottom + left + right
  end
end

RSpec.describe Board do
  it 'cell turns off after tick' do
    coordinate = Point.new(1, 1)
    cell = Cell.new()
    cell.turn_on
    hash = Hash.new
    hash[coordinate] = cell
    board = Board.new(hash)
    game = Game.new(board)

    game.tick

    expect(cell.is_on).to eq(false)
  end
end
