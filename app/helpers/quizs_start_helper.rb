module QuizsStartHelper
  class QuizsStart
    def self.convert_Input input
      blocks = input.split(/\n(?=\d+\.\s*)/)
      quizzes = blocks.map do |block|
        lines = block.lines.map(&:strip)
        # Extract question text (remove leading "1. ", "2. ", etc.)
        question = lines.shift.sub(/^\d+\.\s*/, "")
        # Collect options A–D
        options = lines
          .select { |l| l.match?(/^[A-D]\)/) }
          .map   { |l| l.sub(/^[A-D]\)\s*/, "") }
        # Find the answer line (handles both "correntAnswer" typo and correctAnswer)
        answer_line = lines.find { |l| l.downcase.include?("correct") }
        correct_answer = answer_line.sub(/^[^:]+:\s*/, "")
        {
          question:       question,
          options:        options,
          correctAnswer:  correct_answer
        }
      end
      quizzes
    end
  end
end
