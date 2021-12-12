module GameOfLife
  class Game
    def initialize(manager:, evaluator:)
      @manager = manager
      @evaluator = evaluator
    end

    def start
      while true do
        next_gen = @manager.iterate(@evaluator)
        @evaluator = @evaluator.class.new rules: @evaluator.rules, current_gen: next_gen, cell_class: @evaluator.cell_class
      end
    end
  end
end
