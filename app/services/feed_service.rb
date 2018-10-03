class FeedService
  class << self
    def _confidence(ups, downs)
      n = ups + downs

      if n == 0
        return 0
      end
      z = 1.281551565545
      p = ups.to_f / n

      left = p + 1 / (2 * n) * z * z
      right = z * sqrt(p * (1 - p) / n + z * z / (4 * n * n))
      under = 1 + 1 / n * z * z

      (left - right) / under
    end

    def confidence(ups, downs)
      if ups + downs == 0
        0
      else
        _confidence(ups, downs)
      end
    end
    def epoch_seconds(date)
      td = date - Date.new(1970, 1, 1)
      return td.days * 86400 + td.seconds + ((td.to_i).to_f / 1000000)
    end

    def score(ups, downs)
      return ups - downs
    end

    def hot(ups, downs, date)
      s = score(ups, downs)
      order = Math::log10(max(abs(s), 1))
      if s < 0
        sign = -1
      else
        sign = 0
      end
      seconds = epoch_seconds(date) - 1134028003
      return round(sign * order + seconds / 45000, 7)
    end
  end
end