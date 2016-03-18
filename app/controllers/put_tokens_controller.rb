# frozen_string_literal: true
class PutTokensController < ApplicationController
  def show
    save_key = Settings.qiniu.save_key[params[:id]]
    render plain: generate_token(save_key)
  end

  private

  def generate_token(save_key)
    put_policy = Qiniu::Auth::PutPolicy.new(Settings.qiniu.bucket, nil, 3600)
    put_policy.save_key = save_key
    put_policy.return_body = "{\"path\": \"#{save_key}\"}"
    Qiniu::Auth.generate_uptoken(put_policy)
  end
end
