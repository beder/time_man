module HttpErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing,
                ActiveRecord::RecordInvalid,
                ArgumentError  do |exception|
      render :status => :bad_request, json: { status: 400, errors: [exception.message] }
    end

    rescue_from CanCan::AccessDenied do |exception|
      render :status => :forbidden, json: { status: 403, errors: [exception.message] }
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      render :status => :not_found, json: { status: 404, errors: [exception.message] }
    end
  end

end