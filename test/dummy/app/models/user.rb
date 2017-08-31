class User < GreyscaleRecord::Base
  def as_json( _ )
    @attributes
  end
end