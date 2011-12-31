# A do-nothing cache implementation just used for testing
class BlackHoleStore
  def logger
    Rails.logger
  end

  def fetch( *args )
    yield
  end

  def read( *args )
  end

  def write( *args )
  end

  def delete( *args )
  end

  def increment( *args )
  end

  def decrement( *args )
  end
end