module GameOfLife
  class Manager
    attr_reader :next_gen
    def initialize(refresh_rate:, init_config:, printer:)
      @next_gen = init_config
      @refresh_rate = refresh_rate
      @printer = printer
    end

    def iterate(evaluator)
      @printer.render
      @next_gen = evaluator.evaluate @next_gen
      sleep @refresh_rate
      @printer.update_serialization @next_gen
      @next_gen
    end
  end
end
