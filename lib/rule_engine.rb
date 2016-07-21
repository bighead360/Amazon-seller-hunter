module RuleEngine
  class RuleEngineError < StandardError
  end

  def RuleEngine.pick_best(getsellers)
   
     @@getsellers = getsellers
     
    fail RuleEngineError, 'I can\'t do anything if you give me a empty array of sellers.' if @@getsellers.empty?
   
    @@getsellers.delete_if { |getseller| Rule.filter(getseller)}

    @@getsellers.each do |getseller|
      getseller.score *= Rule.score(getseller)
    end
    fail RuleEngineError, 'All the sellers have been filtered. Consider loose the rules.' if @@getsellers.empty?
    @@getsellers.min_by(&:score)
  end


end
