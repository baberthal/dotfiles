require "colorize"
# require 'active_support/core_ext/string'
Pry.config.theme = "solarized"

def prompt_setup(options = {})
  options[:line_nr_color] ||= :white
  options[:tgt_self_pc] ||= :light_red
  options[:obj_color] ||= :yellow
  options[:tail_color] ||= :green
  options[:nest_color] ||= :cyan
  options[:pry_color] ||= :light_magenta

  tail = "->".colorize options[:tail_color]
  need_input_tail = "...".colorize(options[:tail_color])
  linob = "[".colorize(options[:line_nr_color])
  lincb = "]".colorize(options[:line_nr_color])
  tsop = "(".colorize(options[:tgt_self_pc])
  tscp = ")".colorize(options[:tgt_self_pc])

  target_self_proc = proc do |tgt_self|
    "#{tsop}#{colorize_object(Pry.view_clip(tgt_self), options[:obj_color])}#{tscp}"
  end

  nest_lvl_proc = proc do |nest_lvl|
    ":#{colorize_object(nest_lvl, options[:nest_color])}" unless nest_lvl.zero?
  end

  pry_proc = proc do |pry_obj|
    "#{linob}#{colorize_object(pry_obj.input_ring.size, options[:pry_color])}#{lincb}"
  end

  main_prompt = proc do |target_self, nest_level, pry|
    "#{pry_proc.call(pry)}#{target_self_proc.call(target_self)}#{nest_lvl_proc.call(nest_level)}#{tail} "
  end

  secondary_prompt = proc do |target_self, nest_level, pry|
    "#{pry_proc.call(pry)}#{target_self_proc.call(target_self)}#{nest_lvl_proc.call(nest_level)}#{need_input_tail} "
  end

  [main_prompt, secondary_prompt]
end

def colorize_object(object, color)
  object.to_s.colorize(color)
end

Pry.config.prompt = prompt_setup

#  vim: set ts=8 sw=2 tw=0 ft=ruby et :
