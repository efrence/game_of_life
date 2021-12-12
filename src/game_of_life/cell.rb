module GameOfLife
  class Cell
    attr_reader :state, :neighbors_alive
    def initialize(rules, state, neighbors_alive)
      @state = state.to_i
      @neighbors_alive = neighbors_alive.to_i
      @rules = rules
    end

    def evaluate_rules
      @next_gen_state = false
      @rules.each do |rule|
        @next_gen_state = @next_gen_state || rule.call(!@state.zero?, @neighbors_alive)
      end
      @next_gen_state
    end

    def next_state
      evaluate_rules
      case @next_gen_state
      when true
        1
      when false
        0
      end
    end
  end
end
