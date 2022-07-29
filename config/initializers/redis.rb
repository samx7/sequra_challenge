# frozen_string_literal: true

if Rails.env.test?
  require 'fakeredis'
  FakeRedis.enable
end
