class TokenSerializer
  def initialize(context)
    @access = context.access_token
    @refresh = context.refresh_token
  end

  def as_json(*)
    {
      access: @access,
      refresh: @refresh
    }
  end
end
