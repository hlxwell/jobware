# -*- encoding : utf-8 -*-
class Hash
  # h = {:a => 1, :b => { :c => 2, :d => {:e => 'e'} }}
  # h.get(:b, :d, :e) => 'e'
  # h.get(:a, :b) => nil
  def get(*args)
    temp_values = self
    args.each do |key|
      return nil if temp_values[key].nil? or (args.last != key and !temp_values[key].is_a?(Hash))
      temp_values = temp_values[key]
    end
    temp_values
  end
end
