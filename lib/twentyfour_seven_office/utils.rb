module TwentyfourSevenOffice
  module Utils
    extend self

    def camelcase(snake_cased_str_or_sym, downcase_first = false)
      r = snake_cased_str_or_sym.to_s.split('_').map { |s| s.capitalize }.join('')

      if downcase_first
        r[0] = r[0].downcase
      end

      snake_cased_str_or_sym.is_a?(String) ? r : r.to_sym
    end
  end
end
