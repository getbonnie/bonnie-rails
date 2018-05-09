#
class VariantLib
  def self.inside(size)
    { gravity: 'center', resize: "#{size}x#{size}", crop: "#{size}x#{size}+0+0" }
  end

  def self.cover(size)
    { gravity: 'center', resize: "#{size}x#{size}^", crop: "#{size}x#{size}+0+0" }
  end
end
