class Slogan
  VERBS = %w{Creating Developing Mandating Building Usurping}
  WHEN  = %w{tomorrow today yesterday}
  WHAT  = %w{technology solutions genetics}
  ADJS  = %w{brighter sunnier happier dominant}

  def madlibs
    verb, what, time1, time2, time3, adj = [VERBS, WHAT, WHEN, WHEN, WHEN, ADJS].map(&:sample)
    "#{verb} #{time1}'s #{what} #{time2}, for a #{adj} #{time3}"
  end
end
