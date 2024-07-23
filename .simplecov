# frozen_string_literal: true

SimpleCov.start do
  minimum_coverage 100
  enable_coverage :branch
  add_filter '/spec/'
  add_filter '/examples/'
end
