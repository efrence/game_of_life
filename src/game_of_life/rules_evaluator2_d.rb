require 'matrix'

module GameOfLife
  class RulesEvaluator2D
    attr_reader :rules, :cell_class
    def initialize(rules:, current_gen:, cell_class:)
      @rules = rules
      @current_gen = current_gen
      @cell_class = cell_class
    end

    def evaluate(current_gen)
      new_gen = []

      (0..num_cols-1).each do |i|
        (0..num_rows-1).each do |j|
          cell = @cell_class.new(@rules, @current_gen[i][j], alive_counts[i][j])
          if new_gen[i] == nil
            new_gen[i] = []
          end
          new_gen[i][j] = cell.next_state
        end
      end
      new_gen
    end

    private

    def alive_positions
      @alive_positions = []
      (0..(num_rows - 1)).each do |i|
        (0..(num_cols - 1)).each do |j|
          @alive_positions.push([i,j]) if @current_gen[i][j] == 1
        end
      end
      @alive_positions
    end

    def num_cols
      @current_gen.first.size
    end

    def num_rows
      @current_gen.size
    end

    def alive_counts
      @alive_counts ||= false

      return @alive_counts if @alive_counts

      @alive_counts = Matrix.zero(num_cols, num_rows).to_a
      alive_positions.each do |pos|
        row_i = pos[0]
        col_i = pos[1]
        ((row_i - 1)..(row_i + 1)).each do |i|
          ((col_i - 1)..(col_i + 1)).each do |j|
            if i >= 0 && i < num_rows && j >= 0 && j < num_cols
              @alive_counts[i][j] += 1
            end
          end
        end
        @alive_counts[row_i][col_i] -= @current_gen[row_i][col_i]
      end
      @alive_counts
    end
  end
end
