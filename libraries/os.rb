module OS
  def OS.windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def OS.unix?
    !OS.windows?
  end
end
class String
  def to_hex
    "0x" + self.to_i.to_s(16)
  end
end
