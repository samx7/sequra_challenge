if Rails.env.test?
  require 'fakeredis'
  FakeRedis.enable
end
