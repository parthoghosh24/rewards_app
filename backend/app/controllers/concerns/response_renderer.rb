module ResponseRenderer
  def render_success(data:, message: '', meta: {}, status: :ok)
    render json: {
      status: 'success',
      data: data,
      meta: meta,
      message: message
    }, status: status
  end

  def render_error(message:, code:, status:)
    render json: {
      status: 'error',
      error: {
        code: code,
        message: message
      }
    }, status: status
  end
end