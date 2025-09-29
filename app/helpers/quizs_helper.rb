module QuizsHelper
  def question_extrator(str)
    questionStart = false
    question = ""
    str.each_char do | st |
      if st.to_i != 0
        questionStart = true
      elsif questionStart
        question += st
      end
    end
    question
  end
  def option_extrator(str)
    option = str.downcase.sub(/^options:\s*/i, "")
    options = option.split(",").map do | opt |
      opt.strip.sub(/^[a-z]\)\s*/i, "")
    end
    options
  end

  def answer_extrator(str)
    answer = str.downcase.gsub(/\s+/, "")
    final = answer.sub(/correctanswer:\s*[a-z]\)\s*/i, "")
    final
  end
  def progress_width(current_quiz, total_quiz)
    percentage = (current_quiz.to_f / total_quiz.to_f) * 100
    clamped_percentage = [ [ percentage, 0 ].max, 100 ].min
    clamped_percentage
  end
end
