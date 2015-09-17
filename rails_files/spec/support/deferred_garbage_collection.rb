class DeferredGarbageCollection
  @last_gc_run = Time.zone.now

  class << self
    DEFERRED_GC_THRESHOLD = (ENV['DEFER_GC'] || 15.0).to_f

    def start
      GC.disable if DEFERRED_GC_THRESHOLD > 0
    end

    def reconsider
      should_run = ->(x) { x > 0 && (Time.zone.now - @last_gc_run) >= x }
      return unless should_run.call DEFERRED_GC_THRESHOLD
      GC.enable
      GC.start
      GC.disable
    end
  end
end
