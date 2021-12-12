require 'zeitwerk'
loader = Zeitwerk::Loader.new
loader.push_dir("src")
loader.setup

five_zeros_row = Array.new(5, 0)
six_zeros_row = Array.new(6, 0)
beacon_1 = [0,1,1,0,0,0]
beacon_2 = [0,0,0,1,1,0]
middle_row = [0,1,1,1,0]
blinker_board = [five_zeros_row,five_zeros_row,middle_row,five_zeros_row,five_zeros_row]
beacon_board = [six_zeros_row,beacon_1,beacon_1,beacon_2,beacon_2,six_zeros_row]

init_config = beacon_board

rules =  [
  ->( _ , neighbors_alive) { neighbors_alive < 2 ? false :false },
  ->( _ , neighbors_alive) { neighbors_alive > 3 ? false : false },
  ->(alive, neighbors_alive) { alive && neighbors_alive == 2 ? true : false },
  ->( _ , neighbors_alive) { neighbors_alive === 3 ? true : false }
]

evaluator = GameOfLife::RulesEvaluator2D.new rules: rules, current_gen: init_config, cell_class: GameOfLife::Cell
printer = GameOfLife::PrinterStdout2D.new init_config
manager = GameOfLife::Manager.new refresh_rate: 0.5, init_config: init_config, printer: printer

game = GameOfLife::Game.new manager: manager, evaluator: evaluator
game.start
