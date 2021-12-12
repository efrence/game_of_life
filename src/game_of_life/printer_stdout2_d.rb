require 'colorize'

module GameOfLife
  class PrinterStdout2D
    def initialize(serialization)
      @serialization = serialization
    end

    def update_serialization(serialization)
      @serialization = serialization
    end

    def render
      system "clear" or system "cls"
      @serialization.each do |row|
        puts "\n"
        row.each do |cell|
          print "x ".green if cell == 1
          print "o " if cell == 0
        end
      end
    end
  end
end
