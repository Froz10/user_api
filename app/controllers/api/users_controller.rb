class Api::UsersController < ApplicationController
  def create
    outcome = Users::CreateUser.run(params[:user])
    if outcome.valid?
      render json: outcome.result, status: :created
    else
      render json: outcome.errors.details, status: :unprocessable_entity
    end
  end
end
